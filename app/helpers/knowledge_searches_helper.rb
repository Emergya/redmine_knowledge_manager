module KnowledgeSearchesHelper
	# Controls CPM tab selected
	def highlight(knowledges, selected)
		text = ""
		knowledges.each_with_index do |knowledge, index|
			if index != 0
				text += ", " 
			end

			if selected.include?(knowledge.id.to_s)
				text += "<span style='color:red;'>"+knowledge.name+"</span>"
			else
				text += knowledge.name
			end
		end
		text.html_safe
	end
end