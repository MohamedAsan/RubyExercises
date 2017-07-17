class Polynomial

	POSITIVE_SIGN = "+"
  NEGATIVE_SIGN = "-"

	def initialize(coefficients)
		if coefficients.length < 2
			raise ArgumentError.new('Need at least 2 coefficients.')
		end

	  equation = ""
	  maximum_degree = coefficients.length - 1

		coefficients.each_with_index do |current_coefficient, current_index|

			next if current_coefficient.zero?

			current_degree = maximum_degree - current_index

			if current_coefficient.positive?
				equation << POSITIVE_SIGN unless current_degree == maximum_degree
			else
				equation << NEGATIVE_SIGN
			end

			equation << current_coefficient.abs.to_s unless current_coefficient.abs == 1 and current_degree != 0

			equation <<  "x" unless current_degree.zero?

			equation << "^#{current_degree}" unless current_degree <= 1
		end
		puts equation
	end
end

Polynomial.new([1, 0, -1])
Polynomial.new([-1, 0, 2, 3, 20, -9, 23])
Polynomial.new([-21, -8, 2])
Polynomial.new([-3,-4,1,0,6])
Polynomial.new([1,0,2])
# Polynomial.new([12])
