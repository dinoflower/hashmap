# frozen_string_literal: true

require_relative 'linked_list'

# This class approximates a Hashmap, implemented in Ruby.
class HashMap
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(16)
  end

  # def set(key, value)
    # index = hash_index(key)
    # if @buckets[index].nil?
      # make a fresh list
    # elsif has?(key)
      # make the new entry where it goes, replacing any existing entry
      # @buckets[index].update(key, value) ?
    # elsif high_load?
      # increase_capacity
      # set(key, value)
    # else
      # @buckets[index].prepend(key, value)
    # end
  # end

  # works but I'm not sure if it's my favorite way of doing it
  def set(key, value)
    index = hash_index(key)
    @buckets[index] ||= LinkedList.new(key, value)
    entry = @buckets[index].find(key)
    if entry
      entry.value = value
    elsif high_load?
      increase_capacity
      set(key, value)
    else
      @buckets[index].prepend(key, value)
    end
  end

  def get(key)
    index = hash_index(key)
    target_bucket = @buckets[index]
    return nil if target_bucket.nil?

    target_bucket.find(key).value
  end

  def has?(key)
    keys.include?(key)
  end

  def remove(key)
    return nil unless has?(key)

    index = hash_index(key)
    target_bucket = @buckets[index]
    output = target_bucket.delete(key)
    empty_bucket(index) if target_bucket.head.nil?
    output
  end

  def length
    keys.length
  end

  def clear
    @buckets = Array.new(16)
  end

  def keys
    entries.map(&:first)
  end

  def values
    entries.map(&:last)
  end

  private

  def empty_bucket(index)
    @bucket[index] = nil
  end

  def increase_capacity
    stored_entries = entries
    @buckets = Array.new(capacity * 2)
    stored_entries.each { |key, value| set(key, value) }
  end

  def entries
    return nil if @buckets.empty?

    @buckets.each_with_object([]) do |bucket, array|
      next unless bucket

      bucket.each_node { |entry| array << [entry.key, entry.value] }
    end
  end

  def hash_index(key)
    index = hash(key) % capacity
    raise IndexError if index.negative? || index >= capacity

    index
  end

  def capacity
    @buckets.length
  end

  def high_load?
    (length / capacity) >= LOAD_FACTOR
  end

  # this function takes the key as input and returns hash code, which accesses buckets
  def hash(string)
    hash_code = 0
    prime_number = 17

    string.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end
