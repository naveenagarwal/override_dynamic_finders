# OverrideActiveRecordDynamicFinders

Overrides find, find_by_*, find_all_by_*, find_last_by_* and count method for the ActiveRecord module to use the new ActiveRecord relation methods like where, limit, offset etc.

## Installation

Add this line to your application's Gemfile:

    gem 'override_activerecord_dynamic_finders'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install override_activerecord_dynamic_finders

## Usage

when upgrading one of the applications from rails 2.3 to 3.2 the onemajor hurdel was to update the ActiveRecord query methods like find(:all, :conditions => "...", select => "..."), find_by_status("active", :conditions => "...") etc.

As we had more than 2000 such method calls, so it was not feasible for us to to change each and every query to use new ActiveRecord methods.

Then I decided to comeup with a library which lets you use these methods, but behind the secenes these methods use only new ActiveRecord relation methods like where, limit, offcet, includes, having etc. Just include this gem in your gemfile and you are good to go.

It overrides following methods for the ActiveRecord model class

1. find
2. find_by_*
3. find_(all|last)_by_*
4. count

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
