class HashEachWithIndex
  include Habuco

  each_with_index -> { collection } do |val, index|
    namespace :ns do
      attribute :"foo_#{index}", val
      attribute :"bar_#{index}", -> { num }
    end
  end
end

RSpec.describe '.each_with_index' do
  let(:output) do
    {
      ns: {
        foo_0: :red,
        bar_0: 123,
        foo_1: :green,
        bar_1: 123,
        foo_2: :blue,
        bar_2: 123
      }
    }
  end

  it 'allows to return correct hash' do
    result = HashEachWithIndex.build(collection: %i[red green blue], num: 123)
    expect(result).to eq(ns: { foo_0: :red, bar_0: 123, foo_1: :green, bar_1: 123, foo_2: :blue, bar_2: 123 })
  end
end
