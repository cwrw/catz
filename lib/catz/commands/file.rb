class Catz
  class File < Commands
    def initialize
      super(
        base_url: 'http://thecatapi.com',
        extension: '/api/images/get',
        params: { format: "xml", type: "jpg" }
      )
    end

    def execute
      save_file_to_desktop
      system "echo Cat image: #{file_name} successfully saved to desktop"
    rescue => e
      system "echo #{e.backtrace}"
    end

    private

    def save_file_to_desktop
      open("#{Dir.home}/Desktop/#{file_name}", 'wb') do |file|
        file << open(parse_response).read
      end
    end

    def parse_response
      response["response"]["data"]["images"]["image"]["url"]
    end

    def file_name
      @file_name ||= parse_response.split('/')[-1]
    end
  end
end
