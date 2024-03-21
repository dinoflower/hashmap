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

  # okay close but now that would create a duplicate entry
  def set(key, value)
    index = hash_index(key)
    @buckets[index] ||= LinkedList.new(key, value)
    if high_load?
      increase_capacity
    else
      @buckets[index].append(key, value)
    end
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

  private

  def increase_capacity
    stored_entries = entries
    @buckets = Array.new(capacity * 2)
    stored_entries.each { |key, value| set(key, value) }
  end

  def entries
    @buckets.each_with_object([]) do |bucket, array|
      next unless bucket

      bucket.each_node { |entry| array << [entry.key, entry.value] }
    end
  end

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
