class Catz
  class Exceptions < StandardError
    attr_reader :original
    def initialize(msg, original = nil)
      super(msg)
      @original = original
    end
  end

  class ClientError < Exceptions; end
  class ServerError < Exceptions; end
  class ConnectionError < Exceptions; end
  class TimeoutError < Exceptions; end
end
