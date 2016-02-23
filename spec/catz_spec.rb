require 'spec_helper'

RSpec.feature "Utility commands" do
  let(:url) { "http://thecatapi.com/api/images/get?format=xml&type=jpg" }
  let(:body) do
    Nokogiri::XML(
      <<-EOF
        <response>
          <data>
              <images>
                  <image>
                      <url>http://25.media.tumblr.com/Jjkybd3nSaqb3aswN368Nio3_500.jpg</url>
                      <id>758</id>
                      <source_url>http://thecatapi.com/?id=758</source_url>
                  </image>
              </images>
          </data>
        </response>
      EOF
    ).to_xml
  end

  before do
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: body
      )
  end

  context "browser" do
    it "open a new browser window displaying an image of a cat" do
      expect(subject.command("browser")).to eq("open http://thecatapi.com/api/images/get?format=xml&type=jpg")
    end
  end

  context "file" do
    it "save on the desktop an image of a cat, as an image file" do
      expect(subject).to receive(:open).with('http://25.media.tumblr.com/Jjkybd3nSaqb3aswN368Nio3_500.jpg')
      subject.command("browser")
    end
  end

  context "fact" do
    let(:url) { "http://catfacts-api.appspot.com/api/facts" }
    let(:body) do
      {
        "facts": [
            "After humans, mountain lions have the largest range of any mammal in the Western Hemisphere."
        ],
        "success": "true"
      }.to_json
    end
    it "should print to stdout a cat fact" do
      expect(subject.command("file")).to eq("After humans, mountain lions have the largest range of any mammal in the Western Hemisphere.")
    end
  end

  context "categories" do
    let(:url) { "http://thecatapi.com/api/categories/list" }
    let(:body) do
      Nokogiri::XML(
      <<-EOF
        <response>
          <data>
            <categories>
              <category>
                <id>1</id>
                <name>hats</name>
              </category>
              <category>
                <id>2</id>
                <name>space</name>
              </category>
            </categories>
          </data>
        </response>
      EOF
    ).to_xml
    end

    it "should print to stdout a list of cat categories" do
      expect(subject.command("categories")).to eq("1) hats\n2) space")
    end
  end
end
