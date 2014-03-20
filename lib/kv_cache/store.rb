# -*- encoding : utf-8 -*-
module KvCache
  class Store
    def self.call(key,expire_time)
      res = storer.get(key)
      return res if res

      res = yield

      storer.set(key, res, expire_time)

      res
    end
    
    def self.storer
      DALLI
    end

    def delete(*keys)
      keys.each { |e| storer.delete(e) }
    end
  end
end