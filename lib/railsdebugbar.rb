class RailsDebugBar
	def self.filter(controller)
		content_type = controller.response.content_type
		return unless content_type =~ /html/
		
		body = controller.response.body
		head = controller.response.body
		
		insertpoint = (body =~ /<\/body>/)
		head_insert_point = (head =~ /<\/head>/)
		
		css_link = "<link href=\"/stylesheets/rails_debug_bar.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />"
		
		if insertpoint.nil? or head_insert_point.nil?
			insertpoint = -1
			head_insert_point = -1
		end
		
		parts = ["DEBUG",
			rails_version,
			"#{controller.class.to_s}/#{controller.action_name}.#{controller.request.format}",
			controller.response.status,
			["Request headers"] + hash_to_array(controller.request.headers),
			["Response headers"]+ hash_to_array(controller.response.headers)
		]
		
		controller.response.body = body.insert(insertpoint, decorate_parts(parts))
		controller.response.body = head.insert(head_insert_point, css_link)    
	end
	
	def self.rails_version
		"Rails: #{ Rails::VERSION::STRING }"
	end
	
	def self.decorate_parts(parts)
		parts_for_insertion = array_to_li(parts)
		html_for_insertion = "<ul id=\"rails_debug_bar\">#{parts_for_insertion}</ul>"
		return html_for_insertion
	end
	
	private
	def self.array_to_li(array)
		array.map do |s|
			if s.is_a? Array
				"<li>#{CGI::escapeHTML s.first}<ul>#{array_to_li(s[1..-1])}</ul></li>"
			else
				"<li>#{CGI::escapeHTML s}</li>"
			end
		end
	end
	
	def self.hash_to_array(hash)
		hash.map do |k,v|
			"#{k}: #{v}"
		end
	end
end