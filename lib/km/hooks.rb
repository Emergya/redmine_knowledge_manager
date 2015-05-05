module KM
  class Hooks < Redmine::Hook::ViewListener
  	def view_layouts_base_html_head(context={ })
  		if Setting.plugin_redmine_knowledge_manager['show_alert'].present? and User.current.main_knowledges.empty?
	  		return "<div style='overflow:hidden; background-color:#EB0;'>
	  			<div style='margin:10px; font-weight:bold;'>"+
	  			l(:"km.text_main_knowledges_alert")+
	  			"</div>
	  		</div>".html_safe
	  	end
  	end
  end
end