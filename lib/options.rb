require "optparse"

module Options
  ARGV << "-h" if ARGV.empty?

  def self.parse
    options = {
      show_urls: false,
    }

    OptionParser.new do |opts|
      opts.banner = "Usage: ruby main.rb [options]"

      opts.on(
        "-r",
        "--root-id ROOT_ID",
        "Select root ID (default: nil)",
      ) do |o|
        options[:root_id] = o
      end

      opts.on(
        "-u",
        "--urls",
        "Show URLs next to files (default: false)",
      ) do |o|
        options[:show_urls] = o
      end
    end.parse!

    options
  end
end
