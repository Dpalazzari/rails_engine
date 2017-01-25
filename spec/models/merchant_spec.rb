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

    describe '#revenue' do
      it 'returns total revenue' do
        merchant = create(:merchant)
        merchant.invoices << create_list(:invoice, 2)
        merchant.invoices.each do |invoice|
          invoice.transactions << create(:transaction)
          invoice.invoice_items << create(:invoice_item, unit_price: 100)
          invoice.invoice_items << create(:invoice_item, unit_price: 150, quantity: 2)
        end

        expect(merchant.revenue).to eq(800)
      end
    end

    describe '#revenue_by_date(date)' do
      it 'returns total revenue' do
        merchant = create(:merchant)
        merchant.invoices << create_list(:invoice, 2)
        merchant.invoices.each do |invoice|
          invoice.transactions << create(:transaction)
          invoice.invoice_items << create(:invoice_item, unit_price: 100)
          invoice.invoice_items << create(:invoice_item, unit_price: 150, quantity: 2)
        end
        new_date = merchant.invoices.first.created_at + 10.days
        merchant.invoices.first.update(created_at: new_date)
        merchant.reload

        expect(merchant.revenue_by_date(new_date)).to eq(400)
      end
    end

    describe '#revenue(date)' do
      it 'returns total revenue' do
        merchant = create(:merchant)
        merchant.invoices << create_list(:invoice, 2)
        merchant.invoices.each do |invoice|
          invoice.transactions << create(:transaction)
          invoice.invoice_items << create(:invoice_item, unit_price: 100)
          invoice.invoice_items << create(:invoice_item, unit_price: 150, quantity: 2)
        end
        new_date = merchant.invoices.first.created_at + 10.days
        merchant.invoices.first.update(created_at: new_date)
        merchant.reload

        expect(merchant.revenue(new_date)).to eq(400)
      end
    end
  end
end
