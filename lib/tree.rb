module Tree
  INDENT_WIDTH = 2

  class TreeRequired < StandardError
  end

  def self.display tree:, show_urls: false, level: 0
    raise TreeRequired if tree.nil?

    print "#{indent level}* #{tree[:file][:name]} {#{tree[:file][:type]}}"
    print " {#{tree[:file][:url]}}" if show_urls
    print "\n"

    tree[:children].sort_by { |c| c[:file][:name] }.each do |child|
      display tree: child, show_urls: show_urls, level: level + 1
    end
  end

  def self.indent level
    " " * INDENT_WIDTH * level
  end
end
