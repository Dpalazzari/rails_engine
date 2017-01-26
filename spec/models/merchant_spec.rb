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

    describe '.with_most_items(quantity)' do
      it 'returns top 5 merchants with most items sold' do
        merchants = create_list(:merchant, 10)
        (merchants.length - 1).times do |i|
          invoices = create_list(:invoice, i + 1, merchant: merchants[i])
          invoices.each do |invoice|
            create(:transaction, invoice: invoice)
            create_list(:invoice_item, i + 1, invoice: invoice)
          end
        end

        result   = Merchant.with_most_items(5).map { |m| m.invoice_items.sum(:quantity) }
        expected = [81, 64, 49, 36, 25]
        expect(result).to eq(expected)
      end
    end
  end
end
