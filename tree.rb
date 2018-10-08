module Tree
  INDENT_WIDTH = 2

  class TreeRequired < StandardError
  end

  def self.display tree:, show_urls: false, level: 0
    raise TreeRequired if tree.nil?

    tree.each do |filename, metadata|
      print "#{indent level}* #{filename}"
      print " {https://drive.google.com/open?id=#{metadata[:id]}}" if show_urls
      print "\n"

      metadata[:children]&.sort_by(&:keys)&.each do |child|
        display tree: child, level: level + 1
      end
    end
  end

  def self.indent level
    " " * INDENT_WIDTH * level
  end
end
