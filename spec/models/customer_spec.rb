require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'associations' do
    it { should have_many :invoices }
    it { should have_many :merchants }
    it { should have_many :transactions }
  end

  context 'business analytics' do

  	describe '#favorite_merchant' do
  		it 'returns the favorite merchant' do
  			customer 			 = create(:customer)
				top_merchant 	 = create(:merchant)
				worse_merchant = create(:merchant)
				invoice 			 = create(:invoice, merchant: top_merchant, customer: customer)
				invoice_3 		 = create(:invoice, merchant: top_merchant, customer: customer)
				invoice_2			 = create(:invoice, merchant: worse_merchant, customer: customer)
				create(:transaction, result: 'success', invoice: invoice)
				create(:transaction, result: 'success', invoice: invoice_2)
				create(:transaction, result: 'success', invoice: invoice_3)
  			
	  		expect(customer.favorite_merchant).to eq(top_merchant)
  		end
  	end
  end
end
