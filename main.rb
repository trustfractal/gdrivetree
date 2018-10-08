require "./providers/gdrive"
require "./tree"

ROOT_ID = ARGV[0]
DISPLAY_URLS = ARGV[1] == "--urls"

Tree.display(
  tree: Providers::GDrive.tree(root_id: ROOT_ID),
  show_urls: DISPLAY_URLS,
)
