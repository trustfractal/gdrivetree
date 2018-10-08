require "optparse"

module Options
  ARGV << "-h" if ARGV.empty?

  def self.parse
    options = {
      provider: "GDrive",
      show_urls: false,
    }

    OptionParser.new do |opts|
      opts.banner = "Usage: ruby main.rb [options]"

      opts.on(
        "-p",
        "--provider PROVIDER",
        "Select filesystem provider (default: GDrive)",
      ) do |o|
        options[:provider] = o
      end

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
