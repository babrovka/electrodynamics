jQuery ->
	if $('#user_country_id').val() == ''
	  $('#user_city_id').hide()
		states = $('#user_city_id').html()
		$('#user_country_id').change ->
			country = $('#user_country_id :selected').text()
			escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
			options = $(states).filter("optgroup[label='#{escaped_country}']").html()
			if options
				$('#user_city_id').html(options)
				$('#user_city_id').show()
			else
				$('#user_city_id').empty()
				$('#user_city_id').hide()
	
		