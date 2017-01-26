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
  end
end
