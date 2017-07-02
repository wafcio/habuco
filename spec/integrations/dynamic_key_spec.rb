class HashDynamicKey
  include Habuco

  attribute -> { :"ns_#{num}" }, :bar
end

RSpec.describe '.attribute' do
  it 'allows to return correct hash' do
    result = HashDynamicKey.build(num: 123)
    expect(result).to eq(ns_123: :bar)
  end
end
