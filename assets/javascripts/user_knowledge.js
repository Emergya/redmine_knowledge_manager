//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails

$(document).ready(function(){
	$('#user_knowledge_name').blur();

	$('#user_knowledge_name').bind('railsAutocomplete.select', function(event, data){
	  $('#user_knowledge_knowledge_id').val(data.item.id);
	});
});