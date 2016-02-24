class Catz
  class Commands
    attr_reader :client

    def self.execute
      new.execute
    end

    def initialize(base_url:, extension:, params:)
      @client = Client.new(base_url: base_url, extension: extension, params: params)
    end

    def response
      client.response
    end
  end
end
