require "spec_helper"

RSpec.feature 'Catz Client Errors' do
  subject do
    Catz::Client.new(
      base_url: 'http://example.com:5170',
      extension: "/get",
      params: { type: "jpg" }
    )
  end

  it "raises an error when the status code is 400" do
    stub_request(:get, "http://example.com:5170/get?type=jpg")
      .to_return(status: 404, body: "Missing Content")
    expect { subject.response }.to raise_error(
      Catz::ClientError,
      "GET http://example.com:5170/get?type=jpg: 404: Missing Content")
  end

  it "raises an Catz::ParsingError when server responds with a malformed body" do
    stub_request(:get, "http://example.com:5170/get?type=jpg").to_raise(Faraday::ParsingError.new("Parsing error"))
    expect { subject.response }.to raise_error(
      Catz::ClientError,
      "Server (http://example.com:5170/get?type=jpg) responded with a parsing error. Response body was: "
    )
  end

  it "raises an Catz::ConnectionError when server was unable to connect" do
    stub_request(:get, "http://example.com:5170/get?type=jpg").to_raise(Faraday::ConnectionFailed.new("Connection failed"))
    expect { subject.response }.to raise_error(
      Catz::ConnectionError,
      "Server (http://example.com:5170/get?type=jpg) is not available."
    )
  end

  it "raises an Catz::TimeoutError when the server does not respond" do
    stub_request(:get, "http://example.com:5170/get?type=jpg").to_raise(Faraday::TimeoutError.new("Timeout error"))
    expect { subject.response }.to raise_error(
      Catz::TimeoutError,
      "Server (http://example.com:5170/get?type=jpg) is not responding."
    )
  end
end
