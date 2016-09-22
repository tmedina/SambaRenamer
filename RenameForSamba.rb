#!/usr/local/bin/ruby

$encoding_options = {
  :invalid           => :replace,  # Replace invalid byte sequences
  :undef             => :replace,  # Replace anything not defined in ASCII
  :replace           => ''        # Use a blank for those replacements
}


def recurse(path)
	Dir.chdir path
	Dir.foreach("."){
		|f|
		next if f == '.' or f == '..'
		# remove non-ASCII chars
		ff = f.encode(Encoding.find('ASCII'), $encoding_options)
		# remove samba unfriendly chars
		fff = ff.gsub(%r"[:'/\";()!]", "")
		if File.directory?(f) 
			recurse(f)
		end
		#puts f + "  ->  " + fff
		File.rename(f, fff)
	}
	Dir.chdir ".."
end

recurse(ARGV[0])




