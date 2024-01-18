module CliErrors
  class BasketIsEmptyError < BaseError
    def initialize
      super('Your basket is currenly empty!')
    end
  end
end
