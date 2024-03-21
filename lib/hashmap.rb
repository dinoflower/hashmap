# frozen_string_literal: true

require_relative 'linked_list'

# This class approximates a Hashmap, implemented in Ruby.
class HashMap
  include LinkedList
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(16)
    @length = 0
  end

  # this function takes the key as input and returns hash code, which accesses buckets
  def hash(string)
    hash_code = 0
    prime_number = 17

    string.each_char { |char| hash_code = prime_number & hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash_index(key)
    @buckets[index] ||= LinkedList.new(key, value)
    # if key exists, update key with new value - check
    # if key does not exist and bucket is empty, create normally - check
    # if key does not exist but there is a collision, resolve
    # grow buckets as needed
  end

  def get(key)
    index = hash_index(key)
    target_bucket = @buckets[index]
    target_bucket.find(key).value
  end

  def has?(key)
    keys.include?(key)
  end

  def remove(key)
    return nil unless has?(key)

    @length -= 1
    index = hash_index(key)
    target_bucket = @buckets[index]
    target_bucket.delete(key)
  end

  def length
    keys.length
  end

  # too cheeky?
  def clear
    @buckets = Array.new(16)
    @length = 0
  end

  def keys
    entries.map(&:first)
  end

  def values
    entries.map(&:last)
  end

  def entries
    @buckets.each_with_object([]) do |bucket, array|
      next unless bucket

      bucket.each_node { |entry| array << [entry.key, entry.value] }
    end
  end

  private

  def hash_index(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def capacity
    @buckets.length
  end

  def high_load?
    (length / capacity) >= LOAD_FACTOR
  end
end
