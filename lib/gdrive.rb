require "./lib/gdrive/fs"

module GDrive
  FILE_BASE_URL = "https://drive.google.com/open?id=".freeze

  class RootIDRequired < StandardError
  end

  def self.tree root_id:
    raise RootIDRequired if root_id.nil?

    convert tree: FS.tree(root_file: FS.get_file(id: root_id))
  end

  def self.human_type mime_type
    if mime_type.match?(/google-apps/)
      mime_type[/.*\.(.*)$/, 1]
    else
      mime_type[%r{.*\/(.*)$}, 1]
    end
  end

  def self.url file
    FILE_BASE_URL + file.id
  end

  def self.convert tree:
    file, children = tree.fetch_values(:file, :children)

    {
      file: {
        id: file.id,
        name: file.name,
        type: human_type(file.mime_type),
        url: url(file),
      },
      children: children.map { |child| convert tree: child },
    }
  end
end
