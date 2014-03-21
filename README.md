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
  #config
  opts = { :namespace => "app_v2", :compress => true }
  KvCache::Store.storer = Dalli::Client.new('127.0.0.1:11211', opts)

  #class
class City < ActiveRecord::Base
  attr_accessible :name, :province
  include KvCache
  
  def of_province(prv)
     Store.call("#City.of_province:#{prv}") {where(province: prv)}
  end
  after_save :kv_cache_reset

  def kv_cache_reset
    Store.delete(self.province)
  end
end

  # some code 
  City.of_province("guangxi")  # first call will :
  			    # fecth from db
  			    # select * from cities where province = 'guangxi'
  cs = City.of_province("guangxi")  # will just return result above
  cs.first.save      # will kv_cache_reset("guangxi") 
  City.of_province("guangxi")  # fecth from db again
  
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
