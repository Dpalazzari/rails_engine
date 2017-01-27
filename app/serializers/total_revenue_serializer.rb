class TotalRevenueSerializer < ActiveModel::Serializer
	include ActionView::Helpers::NumberHelper

	attributes :total_revenue

	def total_revenue
		revenue = object.total_revenue(@instance_options[:date])
		number_with_precision(revenue.to_f / 100, precision: 2).to_s
	end
end
