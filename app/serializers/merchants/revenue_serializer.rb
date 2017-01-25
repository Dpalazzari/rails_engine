class Merchants::RevenueSerializer < MerchantSerializer

	include ActionView::Helpers::NumberHelpers

	attributes :revenue

	def revenue
		number_with_precision(object.revenue / 100.00, precision: 2)
	end

end