require 'km/user_patch'
require 'km/hooks'

Redmine::Plugin.register :redmine_knowledge_manager do
  name 'Knowledge Manager'
  author 'jresinas'
  description "This plugin allows to store and manage users' knowledge."
  version '0.0.2'

  permission :km_user_knowledges, { :user_knowledges => [:show] }, :require => :loggedin
	permission :km_knowledge_search, { :knowledge_searches => [:show] }, :require => :loggedin

  settings :default => {}, :partial => 'settings/km_settings'
  menu :account_menu, :km_user_knowledges, {:controller => 'user_knowledges', :action => 'show'}, 
  		 :caption => :"km.label_knowledges",
		   :if => Proc.new { User.current.allowed_to?(:km_user_knowledges, nil, :global => true) }, 
       :before => :my_account

	menu :admin_menu, :knowledges, { :controller => 'knowledges', :action => 'show'},
  		 :html => { :class => 'issue_statuses' }, 
  		 :caption => :"km.label_knowledge_management"

  menu :top_menu, :km_knowledge_search, { :controller => 'knowledge_searches', :action => 'show'}, 
       :caption => :"km.label_knowledge_search",
       :if => Proc.new { User.current.allowed_to?(:km_knowledge_search, nil, :global => true) }
end
