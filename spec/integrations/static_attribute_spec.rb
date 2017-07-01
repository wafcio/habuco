class HashDSL
  include Habuco

  attribute :foo, :bar
end

RSpec.describe '.attribute' do
  it 'allows to return correct hash' do
    result = HashDSL.build
    expect(result).to eq({ foo: :bar })
  end
end
