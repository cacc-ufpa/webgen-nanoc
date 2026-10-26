# Appends .html after links to other md or adoc files.
class LinkRewriter < Nanoc::Filter
	identifier :rewrite_links

	def run(content, params = {})
		content.gsub(/href="([^"]+\.(?:md|adoc))"/, 'href="\1.html"')
	end
end
