require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'associations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :invoices }
  end

  context 'business analytics' do
  	describe '#best_day' do
  		it 'returns the best day' do
  			item 		= create(:item)
  			invoice = create(:invoice)
        invoice_2 = create(:invoice)
        date = invoice_2.created_at
        invoice_2.update(created_at: date - 10.days)
        create(:invoice_item, invoice: invoice_2, item: item)
  			create_list(:invoice_item, 4, item: item, invoice: invoice)

  			expect(item.best_day).to eq(invoice.created_at)
  		end
  	end

    describe '.most_revenue(quantity)' do
      it 'returns the top 2 items by revenue' do
        item1    = create(:item, name: 'Drew')
        item2    = create(:item, name: 'Mike')
        item3    = create(:item, name: 'Bilbo')
        invoice = create(:invoice)
        create(:transaction, invoice: invoice)
        invoice_item1 = create(:invoice_item, invoice: invoice, item: item1, quantity: 14, unit_price: 14)
        invoice_item2 = create(:invoice_item, invoice: invoice, item: item2, quantity: 14, unit_price: 2)
        invoice_item3 = create(:invoice_item, invoice: invoice, item: item3, quantity: 14, unit_price: 3)

        expect(Item.most_revenue(2).pluck(:id)).to match_array([item3.id,item1.id])
      end
    end

    describe '.most_items' do
      it 'returns the top 2 items by items sold' do
        item1    = create(:item, name: 'Drew')
        item2    = create(:item, name: 'Mike')
        item3    = create(:item, name: 'Bilbo')
        invoice = create(:invoice)
        create(:transaction, invoice: invoice)
        invoice_item1 = create(:invoice_item, invoice: invoice, item: item1, quantity: 4, unit_price: 14)
        invoice_item2 = create(:invoice_item, invoice: invoice, item: item2, quantity: 10, unit_price: 2)
        invoice_item3 = create(:invoice_item, invoice: invoice, item: item3, quantity: 14, unit_price: 3)

        expect(Item.most_items(2).pluck(:id)).to match_array([item3.id,item2.id])
      end
    end
  end
end
