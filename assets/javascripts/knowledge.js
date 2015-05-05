$(document).ready(function(){
	$('#knowledge_id').bind('change', function(){
	  $.ajax({
	  	url: '/knowledges/get_data',
	  	data: {id: $('#knowledge_id').val()},
		success: function(data){
			knowledge = data['knowledge'];

			$('#knowledge_name').val(knowledge['name']);
			
			if (knowledge['main']){
				$('#knowledge_main').attr('checked',true);
			} else {
				$('#knowledge_main').attr('checked', false);
			}

			$('#knowledge_id_delete').val(knowledge['id']);
		}
	  })
	});
});