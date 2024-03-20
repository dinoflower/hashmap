# frozen_string_literal: true

require_relative '../lib/linked_list'

describe LinkedList do
  describe '#append' do
    let(:append_node) { described_class.new('key_a', 'value_a') }

    it 'appends the new node' do
      append_node.append('key_b', 'value_b')
    end
  end
end