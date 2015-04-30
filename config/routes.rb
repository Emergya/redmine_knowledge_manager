# Plugin's routes
RedmineApp::Application.routes.draw do
	match '/user_knowledges/:action' => 'user_knowledges'
	match '/knowledges/:action' => 'knowledges'
end
