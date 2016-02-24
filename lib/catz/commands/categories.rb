class Catz
  class Categories < Commands
    def initialize
      super(
        base_url: 'http://thecatapi.com',
        extension: '/api/categories/list',
        params: nil
      )
    end

    def execute
      system "echo The number of cat categories is #{parse_response}"
    rescue => e
      system "echo #{e.backtrace}"
    end

    private

    def parse_response
      response["response"]["data"]["categories"]["category"].count
    end
  end
end
