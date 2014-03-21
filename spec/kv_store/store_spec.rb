require 'spec_helper'


describe "KvCache::Store" do
  it "hello" do
    KvCache::Store.new.should be_kind_of(KvCache::Store)
  end

  it "#call second time will get data from cache " do
    call_time = 0
    KvCache::Store.delete("hello")
    res = KvCache::Store.call("hello", 20) do 
      call_time += 1
      90
    end

    call_time.should == 1
    res.should == 90

    res = KvCache::Store.call("hello", 20) do 
      call_time += 1
      90
    end

    call_time.should == 1
    res.should == 90

    KvCache::Store.delete("hello")

    res = KvCache::Store.call("hello", 20) do 
      call_time += 1
      90
    end

    call_time.should == 2
    res.should == 90
    KvCache::Store.delete("hello")
  end

  it "#call will still exec after storer are changed " do
    call_time = 0
    KvCache::Store.delete("hello")
    res = KvCache::Store.call("hello", 20) do 
      call_time += 1
      90
    end

    call_time.should == 1
    res.should == 90

    res = KvCache::Store.call("hello", 20) do 
      call_time += 1
      90
    end

    call_time.should == 1
    res.should == 90

    opts = { :namespace => "app_v2", :compress => true }
    KvCache::Store.storer = Dalli::Client.new('127.0.0.1:11211', opts)

    res = KvCache::Store.call("hello", 20) do 
      call_time += 1
      90
    end

    KvCache::Store.delete("hello")
    call_time.should == 2
    res.should == 90
    KvCache::Store.delete("hello")
  end

  it "#call auto Serializable" do
    key = "Serializable"
    KvCache::Store.delete(key)
    res = KvCache::Store.call(key, 20) do 
      { a: 9, b: 8}
    end
    res2 = KvCache::Store.call(key, 20) do 
      { a: 9, b: 8}
    end
    res2.should be_kind_of(Hash)
    res2[:b].should == 8
    KvCache::Store.delete(key)
  end
end