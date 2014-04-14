$(document).ready(function(){
	
	// user role description
	$("#user_role").on("change", function(){
		switch(this.value)
		{
		case 'user':
			$('.role_description')
			.html('<p>Обычный пользователь может:</p><ul><li>— Читать статьи</li><li>— Добавлять избранное, подписки</li><li>— Скачивать файлы из библиотеки</li><li>— Оставлять комментарии в блогах</li></ul>')
		  break;
		case 'moderator':
		  $('.role_description').html('<p>Модератор может:</p><ul><li>— Назначать категорию статье</li></ul>')
		  break;
		case '':
		  $('.role_description').html('')
		  break;
		}
	});
	
	
	

});