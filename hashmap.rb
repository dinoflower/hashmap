class HashMap
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(16)
    @length = 0
  end

  def hash(string)
    hash_code = 0
    prime_number = 17

    string.each_char { |char| hash_code = prime_number & hash_code + char.ord }

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

  private

  def capacity
    @buckets.length
  end

  def high_load?
    (length / capacity) >= LOAD_FACTOR
  end
end
