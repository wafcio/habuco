class HashContext
  include Habuco

  attribute :foo, -> { user_name }
end

RSpec.describe '#context' do
  it 'return passed data to constructor' do
    result = HashContext.new(foo: :bar)
    expect(result.context.foo).to eq(:bar)
  end

  it 'returns hash with user data' do
    result = HashContext.build(user_name: 'John')
    expect(result).to eq(foo: 'John')
  end
end
