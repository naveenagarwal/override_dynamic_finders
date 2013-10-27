require "override_active_record_dynamic_finders/version"
require "override_active_record_dynamic_finders/active_record_not_found"
require "override_active_record_dynamic_finders/class_methods"

module OverrideActiveRecordDynamicFinders
  
  class Engine <  ::Rails::Railtie
    config.after_initialize do

      raise "ActiveRecord module not found", ActiveRecordNotFound unless defined?(ActiveRecord)
      ​
      class ActiveRecord::Base
        
        def self.inherited(subclass)
          subclass.initialize_generated_modules
          super
          subclass.extend OverrideActiveRecordDynamicFinders::ClassMethods
        end

      end​
    end
  end


end
