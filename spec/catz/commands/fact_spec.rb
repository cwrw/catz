require 'spec_helper'

RSpec.describe Catz::Fact do
  let(:url) { "http://catfacts-api.appspot.com/api/facts" }
  let(:body) do
    {
      "facts": [
        "After humans, mountain lions"
      ],
      "success": "true"
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

  it "outputs fact about cats" do
    expect(subject).to receive(:system).and_return('echo After humans, mountain lions')
    subject.execute
  end

  context "faraday exception" do
    let(:error_message) { "Server (http://catfacts-api.appspot.com/api/facts) is not available." }
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
