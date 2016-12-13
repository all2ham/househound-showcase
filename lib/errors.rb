module Error

  # class BaseError < StandardError
  #   attr_reader :message

  #   MESSAGE = "Base Error Message"

  #   def initialize(msg = self::MESSAGE)
  #     @message = msg
  #   end

  #   begin
  #     raise self.new, self::MESSAGE
  #   rescue self => e
  #     puts self::MESSAGE
  #   end
  # end

  # class Unauthorized < BaseError
  #   MESSAGE = "You must be authenticated to do that."
  # end

  class Unauthorized < StandardError; end
  class Forbidden < StandardError; end
  class NotFound < StandardError; end
  class UnprocessableEntity < StandardError; end
  class InternalServerError < StandardError; end
  class ServiceUnavailable < StandardError; end

  # exceptions = %w[ Unauthorized Forbidden NotFound UnprocessableEntity InternalServerError ServiceUnavailable ]

  # exceptions.each { |e| const_set(e, Class.new(Exception)) }

end
