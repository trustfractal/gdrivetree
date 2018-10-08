require "./providers/gdrive/fs"

module Providers
  module GDrive
    class RootIDRequired < StandardError
    end

    def self.tree root_id:
      raise RootIDRequired if root_id.nil?

      convert node: FS.tree(root_file: FS.file(id: root_id))
    end

    def self.human_type mime_type
      if mime_type.match?(/google-apps/)
        mime_type[%r{/.*\.(.*)$}, 1]
      else
        mime_type[%r{/.*\/(.*)$}, 1]
      end
    end

    def self.convert node:
      node.each_with_object({}) do |(file, children), object|
        type = human_type file.mime_type

        object[file.name] = {
          id: file.id,
          type: type,
          children: (children.flat_map { |child| convert node: child } if children.any?),
        }
      end
    end
  end
end
