require 'km/user_patch'

Redmine::Plugin.register :redmine_knowledge_manager do
  name 'Knowledge Manager'
  author 'jresinas'
  description "This plugin allows to store and manage users' knowledge."
  version '0.0.1'

	permission :user_km, { :user_knowledges => [:show] }

  #settings :default => {}, :partial => 'settings/km_settings'
  menu :account_menu, :user_km, {:controller => 'user_knowledges', :action => 'show'}, 
  		 :caption => :"km.label_knowledges",
		   :if => Proc.new { User.current.allowed_to?(:user_km, nil, :global => true) }

	menu :admin_menu, :knowledges, { :controller => 'knowledges', :action => 'show'},
  		 :html => { :class => 'issue_statuses' }, 
  		 :caption => :"km.label_knowledge_management"
end
