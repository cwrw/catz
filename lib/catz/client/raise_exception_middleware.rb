class Catz
  class Client
    class RaiseExceptionMiddleware < Faraday::Middleware
      def call(env) # rubocop:disable MethodLength, Metrics/AbcSize
        @app.call(env).on_complete do |response|
          if response[:status].to_s =~ /4\d\d/
            fail Catz::ClientError,
              error_message(response)
          end
        end
      rescue Faraday::ParsingError => error
        raise Catz::ClientError.new(
          "Server (#{env[:url]}) responded with a parsing error. Response body was: #{env[:body]}", error
        )
      rescue Faraday::ConnectionFailed => error
        raise Catz::ConnectionError.new(
          "Server (#{env[:url]}) is not available.", error
        )
      rescue Faraday::TimeoutError => error
        raise Catz::TimeoutError.new(
          "Server (#{env[:url]}) is not responding.", error
        )
      end

      private

      def error_message(response)
        error_info = [
          response[:status],
          response[:body]
        ].compact.join(': ')

        "#{response[:method].upcase} #{response[:url]}: #{error_info}"
      end
    end
  end
end
