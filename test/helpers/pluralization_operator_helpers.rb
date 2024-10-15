module PluralizationOperatorHelpers
  def operator_class
    self.class.name.gsub(/Test\z/, "").constantize
  end
end
