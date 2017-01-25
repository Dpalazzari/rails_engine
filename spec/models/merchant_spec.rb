require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context 'associations' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many :customers }
  end

  context 'business analytics' do
    describe '#successful_transactions' do
      it 'returns all successful transactions' do
        merchant = create(:merchant)
        successful_invoice = create(:invoice, merchant: merchant)
        failed_invoice = create(:invoice, merchant: merchant)
        successful_transaction = create(:transaction, result: 'success', invoice: successful_invoice)
        failed_transaction = create(:transaction, result: 'failed', invoice: failed_invoice)

        expect(merchant.successful_transactions).to match_array([successful_transaction])
      end
    end
  end
end
