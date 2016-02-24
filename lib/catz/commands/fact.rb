class Catz
  class Fact < Commands
    def initialize
      super(
        base_url: 'http://catfacts-api.appspot.com',
        extension: '/api/facts',
        params: nil
      )
    end

    def execute
      system "echo #{parse_response}"
    rescue => e
      system "echo #{e.backtrace}"
    end

    private

    def parse_response
      JSON.parse(response)["facts"].first
    end
  end
end
