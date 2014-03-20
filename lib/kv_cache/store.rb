# -*- encoding : utf-8 -*-
require "dalli"

module KvCache
  class Store
    class << self
      # call yield if key is not exist
      def call(key,expire_time)
        res = storer.get(key)
        return res if res

        res = (yield rescue nil)

        storer.set(key, res, expire_time)

        res
      end

      # delete key 
      def delete(*keys)
        keys.each { |e| storer.delete(e) }
      end

      # like Dalli for memcached
      # #get, #set is Necessary！！
      def storer
        @@_storer ||= defalt_storer
      end

      def defalt_storer
        opts = { :namespace => "app_v1", :compress => true }
        Dalli::Client.new('127.0.0.1:11211', opts)
      end

      # opts = { :namespace => "app_v2", :compress => true }
      # KvCache::Store.storer = Dalli::Client.new('127.0.0.1:11211', opts)
      def storer=(_storer)
        @@_storer = _storer
      end
    end
  end
end