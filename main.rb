require "./lib/gdrive"
require "./lib/tree"
require "./lib/options"

OPTIONS = Options.parse

Tree.display(
  tree: GDrive.tree(root_id: OPTIONS.fetch(:root_id)),
  show_urls: OPTIONS.fetch(:show_urls),
)
