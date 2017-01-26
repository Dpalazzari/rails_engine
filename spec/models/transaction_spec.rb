require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'associations' do
    it { should belong_to :invoice }
  end

  context 'intelligence methods' do
    describe '.successful' do
      it 'returns only successful transactions' do
        expected = create_list(:transaction, 2, result: 'success')
        create(:transaction, result: 'failed')

        expect(Transaction.successful).to eq(expected)
      end
    end
  end
end
