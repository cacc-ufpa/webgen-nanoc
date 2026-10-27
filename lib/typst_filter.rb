require 'open3'

# Builds typst files into pdf files.
class TypstFilter < Nanoc::Filter
	identifier :typst
	type text: :binary

	def run(content, params = {})
		input_file = @item[:filename]
		stdout, stderr, status = Open3.capture3('typst', 'compile', '-f', 'pdf', input_file, '-')
		if not status.success?
			raise "Typst compilation failed for #{input_file}:\n" + stderr
		end
		File.binwrite(output_filename, stdout)
	end
end
