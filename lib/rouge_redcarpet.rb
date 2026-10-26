require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

# Syntax highlighting for markdown rendered with redcarpet gem.
class RougeHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

