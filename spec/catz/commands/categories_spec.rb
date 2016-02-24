require 'spec_helper'

RSpec.describe Catz::Categories do
  let(:url) { "http://thecatapi.com/api/categories/list" }
  let(:body) do
    {
      "response" => {
        "data" => {
          "categories" => {
            "category" => [
              {
                "id" => "1",
                "name" => "hats"
              },
              "category" => {
                "id" => "2",
                "name" => "space"
              }
            ]
          }
        }
      }
    }.to_json
  end

  before do
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: body
      )
  end

  subject { described_class.new }

  it "outputs system call" do
    expect(subject).to receive(:system)
      .and_return('echo The number of cat categories is 2')
    subject.execute
  end

  context "faraday exception" do
    let(:error_message) { "Server (http://thecatapi.com/api/categories/list) is not available." }
    before do
      stub_request(:get, url).to_raise(Faraday::ConnectionFailed.new("Connection failed"))
      expect { subject.response }.to raise_error(
        Catz::ConnectionError,
        error_message
      )
    end

    it "outputs the error message" do
      expect(subject).to receive(:system)
        .and_return(error_message)
      subject.execute
    end
  end

  context "parsing error" do
    before do
      allow(subject).to receive(:parse_response).and_raise "BOOM!"
    end

    it "outputs the error message" do
      expect(subject).to receive(:system)
        .and_return("BOOM!")
      subject.execute
    end
  end
end
