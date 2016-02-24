class Catz
  class Browser < Commands
    def initialize
      super(
        base_url: 'http://thecatapi.com',
        extension: '/api/images/get',
        params: { format: "xml", type: "jpg" }
      )
    end

    def execute
      system "open #{parse_response}"
    rescue => e
      system "echo #{e.backtrace}"
    end

    private

    def parse_response
      response["response"]["data"]["images"]["image"]["url"]
    end
  end
end
