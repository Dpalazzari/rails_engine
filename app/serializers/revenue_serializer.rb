class RevenueSerializer < ActiveModel::Serializer
	include ActionView::Helpers::NumberHelper

	attributes :revenue

	def revenue
		revenue = object.revenue(@instance_options[:date])
		number_with_precision(revenue.to_f / 100, precision: 2).to_s
	end
end
