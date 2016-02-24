require 'spec_helper'

RSpec.feature "Utility commands" do
  context "browser" do
    it "open a new browser window displaying an image of a cat" do
      allow(ARGV).to receive(:[]).and_return('browser')
      allow(Catz::Browser).to receive(:execute).and_return("open http://thecatapi.com/api/images/get?format=xml&type=jpg")
      expect(Catz.commands).to eq("open http://thecatapi.com/api/images/get?format=xml&type=jpg")
    end
  end

  context "file" do
    it "save on the desktop an image of a cat, as an image file" do
      allow(ARGV).to receive(:[]).and_return('file')
      allow(Catz::File).to receive(:execute).and_return("echo Cat image: Jjkybd3nSaqb3aswN368Nio3_500.jpg successfully saved to desktop")
      expect(Catz.commands).to eq('echo Cat image: Jjkybd3nSaqb3aswN368Nio3_500.jpg successfully saved to desktop')
    end
  end

  context "fact" do
    it "should print to stdout a cat fact" do
      allow(ARGV).to receive(:[]).and_return('fact')
      allow(Catz::Fact).to receive(:execute).and_return("echo After humans, mountain lions have the largest")
      expect(Catz.commands).to eq("echo After humans, mountain lions have the largest")
    end
  end

  context "categories" do
    it "should print to stdout the number of cat categories" do
      allow(ARGV).to receive(:[]).and_return('categories')
      allow(Catz::Categories).to receive(:execute).and_return("2")
      expect(Catz.commands).to eq("2")
    end
  end

  context "no arg" do
    it "should print out relevant message" do
      allow(Catz).to receive(:system).and_return("You didn't provide an output")
      expect(Catz.commands).to eq("You didn't provide an output")
    end
  end
end
