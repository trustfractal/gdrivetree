module Tree
  def self.human_type mime_type
    if mime_type.match?(/google-apps/)
      mime_type[%r{/.*\.(.*)$}, 1]
    else
      mime_type[%r{/.*\/(.*)$}, 1]
    end
  end

  def self.print_tree node, urls, column = 0
    node.each do |filename, metadata|
      column.times { print "  " }
      print "* #{filename}"
      print " {https://drive.google.com/open?id=#{metadata[:id]}}" if urls
      print "\n"
      metadata[:children]&.sort_by(&:keys)&.each { |child| print_tree child, urls, column + 1 }
    end
  end

  def self.convert node
    node.map do |file, children|
      type = human_type file.mime_type

      new_node = {}
      new_node[file.name] = {
        id: file.id,
        type: type,
        children: (children.flat_map { |child| convert child } if children.any?),
      }

      new_node
    end.first
  end

  def self.printsss google_tree, urls
    tree = convert google_tree
    print_tree tree, urls
  end
end
