class Catz
  def self.commands # rubocop:disable Metrics/MethodLength
    case ARGV[0]
    when "browser"
      Browser.execute
    when "file"
      File.execute
    when "fact"
      Fact.execute
    when "categories"
      Categories.execute
    else
      system "echo Please provide one of the following options: browser | file | fact | categories"
    end
  end
end
