class Polynomial

  ARGUMENT_ERROR_MESSAGE = "Need at least 2 coefficients"

  def initialize(coefficients)
    number_of_coefficients = coefficients.length
    raise ArgumentError.new(ARGUMENT_ERROR_MESSAGE) if number_of_coefficients < 2

    expression = ""

    coefficients.each_with_index do |coefficient, index|
      next if coefficient.zero?
      exponent = number_of_coefficients - index - 1
      if coefficient > 0
        expression << "+" if expression != ""
      else
        expression << "-"
      end
      expression << coefficient.abs.to_s if coefficient.abs != 1 || exponent.zero?
      expression << "x" if exponent.nonzero?
      expression << "^#{exponent}" if exponent > 1
    end

    puts expression
  end

end

Polynomial.new([1, 1])
Polynomial.new([-1, -1])
Polynomial.new([0, 0])
Polynomial.new([0, 0, 1])
Polynomial.new([0, 0, -1])
Polynomial.new([0, 0, 5])
Polynomial.new([0, 0, -5])
Polynomial.new([0, 1, 0])
Polynomial.new([0, -1, 0])
Polynomial.new([0, 5, 0])
Polynomial.new([0, -5, 0])
Polynomial.new([1, 0, 0])
Polynomial.new([-1, 0, 0])
Polynomial.new([5, 0, 0])
Polynomial.new([-5, 0, 0])
Polynomial.new([1, 0, -1])
Polynomial.new([-1, 0, 1])
Polynomial.new([5, 0, -5])
Polynomial.new([-5, 0, 5])
Polynomial.new([1, 1, 1])
Polynomial.new([-1, -1, -1])
Polynomial.new([5, 5, 5])
Polynomial.new([-5, -5, -5])
Polynomial.new([-1, 0, 2, 3, 20, -9, 23])
Polynomial.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 20])
Polynomial.new([12])
