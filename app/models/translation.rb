class Translation
  include ActiveModel::Model
  attr_accessor :english

  def codes
    @codes ||= ProcessWords.new(english).to_codes
  end
end
