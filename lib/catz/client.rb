class Catz
  class Client
    attr_reader :client, :extension, :params

    def initialize(base_url:, extension:, params:)
    	@extension = extension
    	@params = params
      @client = Faraday.new(url: base_url) do |faraday|
        faraday.request :url_encoded
        faraday.response :xml,  content_type: /\bxml$/
        faraday.response :json, content_type: /\bjson$/
        faraday.use Catz::Client::RaiseExceptionMiddleware
        faraday.adapter Faraday.default_adapter
      end
    end

    def response
      client.get(extension, params).body
    end
  end
end