module OverrideActiveRecordDynamicFinders
  module ClassMethods

    KEYS_SET  = [:joins, :select, :group, :order, :having, :limit, :offset, :conditions, :extend, :include]
    ALL       = :all

    def find(*args)
      if args.first.is_a?(Symbol) && args.last.is_a?(Hash)
        compute_result(*args).send(args.first)
      elsif args.first.is_a?(Symbol) && !args.last.is_a?(Hash)
        result = clone
        result.send(args.first)
      else
        super *args
      end
    end

    def count(*args)

      if args.last.is_a?(Hash) && ALL == args.first
        compute_result(*args).count
      elsif args.last.is_a?(Hash) && ALL != args.first
        compute_result(*args).count(args.first)
      elsif args.first.is_a?(Symbol) && ALL == args.first
        count
      else
        super *args
      end
    end

    private

    def compute_result(*args)
      result = clone

      finder_keys = KEYS_SET & args.last.keys
      finder_hash = args.last

      finder_keys.each do |key|
        method_name = key

        method_name = :where      if key == :conditions
        method_name = :includes   if key == :include
        method_name = :extending  if key == :extend

        result = result.send(method_name, finder_hash[key]) if finder_hash[key].present?
      end
      result
    end

    def method_missing(method_id, *args, &block)
      method = method_id.to_s

      if method.start_with?("find_")

        case method
        when /^find_(all_|last_)?by_([_a-zA-Z]\w*)$/
          finder  = :last if $1 == 'last_'
          finder  = :all if $1 == 'all_'
          names   = $2.split("_and_")
        when /^find_by_([_a-zA-Z]\w*)$/
          names   = $1.split("_and_")
        end

        finder      ||= :first
        finder_hash = {}
        finder_hash = args.delete(args.last) if args.last.is_a?(Hash)

        raise "Invalid number of arguments", ArgumentError if args.size != names.size

        conditions = nil

        if finder_hash[:conditions].blank?
          conditions = {}

          names.each_with_index do |name, index|
            conditions[name.to_sym] = args[index]
          end

          finder_hash[:conditions] = conditions

        else
          conditions = []

          names.each_with_index do |name, index|
            conditions << " #{name} = '#{args[index]}' "
          end

          conditions = conditions.join(" AND ")

          if finder_hash[:conditions].is_a?(Array)
            finder_hash[:conditions][0] += " AND " + conditions
          else
            finder_hash[:conditions] += " AND " + conditions
          end
        end

        find(finder, finder_hash)

      else
        super method_id, *args, &block
      end
    end # end method missing

  end

end