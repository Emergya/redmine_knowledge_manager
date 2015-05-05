//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails

$(document).ready(function(){
	$('#user_knowledge_name').blur();

	$('#user_knowledge_name').bind('railsAutocomplete.select', function(event, data){
	  $('#user_knowledge_knowledge_id').val(data.item.id);
	});

	$('a').bind('click', function(e) {
	  if ($('tr.main_knowledge').length == 0){
	    if (!confirm("No ha seleccionado ningún conocimiento principal. ¿Está seguro que desea continuar?")){
	  	  return false;
	    }
	  }
	});
});