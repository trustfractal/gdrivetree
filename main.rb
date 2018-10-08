require "./providers/gdrive"
require "./tree"
require "./options"

OPTIONS = Options.parse

provider = Providers.const_get(OPTIONS[:provider].to_sym)

Tree.display(
  tree: provider.tree(root_id: OPTIONS[:root_id]),
  show_urls: OPTIONS[:show_urls],
)
