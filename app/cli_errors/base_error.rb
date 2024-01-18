module CliErrors
  class BaseError
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end
end
