# frozen_string_literal: true

require_relative '../lib/linked_list'

describe LinkedList do
  describe '#append' do
    let(:append_node) { described_class.new('key_a', 'value_a') }

    it 'appends the new node' do
      append_node.append('key_b', 'value_b')
    end
  end

  describe '#contains?' do
    let(:contains_node) { described_class.new('key_c', 'value_c') }

    context 'when the key is found' do
      it 'returns true' do
        expect(contains_node.contains?('key_c')).to be(true)
      end
    end

    context 'when the key is not found' do
      it 'returns false' do
        expect(contains_node.contains?('key_b')).to be(false)
      end
    end
  end

  describe '#find' do
    let(:finds_node) { described_class.new('key_d', 'value_d')}

    context 'when the key is found' do
      it 'returns the key' do
        expect(finds_node.find('key_d')).not_to be_nil
      end
    end

    context 'when the key is not found' do
      it 'returns nil' do
        expect(finds_node.find('key_e')).to be_nil
      end
    end
  end
end
