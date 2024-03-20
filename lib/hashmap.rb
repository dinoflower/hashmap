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
    # if key found, return value
    # else return nil
  end

  def has?(key); end

  def remove(key)
    # if key in hash map, remove entry and return entry's value
    # if key not in map, return nil
  end

  def length
    # return number of stored keys
  end

  def clear
    # remove all entries in hash map
  end

  def keys
    # return array containing all keys in hash map
  end

  def values
    # return array containing all values
  end

  def entries
    # return array of each key, value pair [[first_key, first_value], etc.]
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
