class HashWithDate
  include Habuco

  attribute :date, -> { Date.today }
end

RSpec.describe '.attribute' do
  it 'allows to pass lambda as value' do
    result = HashWithDate.build
    expect(result).to eq(date: Date.today)

    Timecop.freeze(Time.new(2000))
    result = HashWithDate.build
    expect(result).to eq(date: Date.new(2000))
    Timecop.return
  end
end
