require 'asciidoctor'

# Converts AsciiDoc content to an HTML fragment suitable for layouts.
class AsciiDocFilter < Nanoc::Filter
	identifier :asciidoctor

	def run(content, params = {})
		Asciidoctor.convert(content, safe: :safe, header_footer: false)
	end
end

