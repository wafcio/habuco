class HashNamespace
  include Habuco

  attribute :a, :aa

  namespace :ns do
    attribute :b, :bb
  end

  attribute :c, :cc

  namespace :ns2 do
    namespace :ns3 do
      attribute :d, -> { user_name }
    end
  end

  attribute :e, :ee
  attribute :f, -> { user_name }
end

RSpec.describe '.attribute' do
  let(:output) do
    {
      a: :aa,
      ns: {
        b: :bb
      },
      c: :cc,
      ns2: {
        ns3: {
          d: 'John'
        }
      },
      e: :ee,
      f: 'John'
    }
  end

  it 'allows to return correct hash' do
    result = HashNamespace.build(user_name: 'John')
    expect(result).to eq(output)
  end
end
