class HashMap
  def initialize
    @buckets = 16
    @load_factor = 0.75
  end

  def hash(value)
    hash_code = 0
    prime_number = 17

    value.each_char { |char| hash_code = prime_number & hash_code + char.ord }

    hash_code
  end

  def set(key, value); end

  def get(key); end

  def key?(key); end

  def remove(key); end

  def length; end

  def clear; end

  def keys; end

  def values; end

  def entries; end
end
