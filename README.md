# KvCache

kv_cache is a tool caching keys and values in a ruby project.


## Installation

Add this line to your application's Gemfile:

    gem 'kv_cache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kv_cache

## Usage

```
require 'kv_cache'

class City < ActiveRecord::Base
  attr_accessible :name, :province
  include KvCache
  
  # kv_cache :method_name, expire_time, :key, values_lambda
  scope :guangxi, ->{ puts "fecth from db" 
                      Store.call {where(province: "guangxi")} }
  
  after_save :kv_cache_reset

  def kv_cache_reset
    Store.delete(self.province)
  end
end

  # some code 
  City.guangxi  # first call will :
  			    # fecth from db
  			    # select * from cities where province = 'guangxi'
  cs = City.guangxi  # will just return result above
  cs.first.save      # will kv_cache_reset("guangxi") 
  City.guangxi  # fecth from db again
  
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
