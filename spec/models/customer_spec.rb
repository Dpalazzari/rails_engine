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
  			invoice_2			 = create(:invoice, merchant: worse_merchant, customer: customer)
  			transactions 	 = create_list(:transaction, 100, result: 'success', invoice: invoice)
  			top_merchant.invoices 	<< invoice
  			worse_merchant.invoices << invoice_2
  			# binding.pry
  			# top_merchant.invoices 	<< create_list(:invoice, 100, customer: customer)
  			# worse_merchant.invoices << create_list(:invoice, 5, customer: customer)

  			# returns a merchant where the customer 
	  		# has conducted the most successful transactions
	  		expect(customer.favorite_merchant).to eq(top_merchant)
  		end
  	end
  end
end
