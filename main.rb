require "./google_tree.rb"
require "./tree.rb"

Tree.printsss(
  GoogleTree.generate(ARGV[0]),
  ARGV[1] == "--urls",
)
