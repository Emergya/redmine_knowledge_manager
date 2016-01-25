# Plugin's routes
RedmineApp::Application.routes.draw do
	match '/user_knowledges/:action' => 'user_knowledges', via: [:get, :delete]
	match '/knowledges/:action' => 'knowledges', via: [:get]
	match '/knowledge_searches/:action' => 'knowledge_searches', via: [:get, :post]
end