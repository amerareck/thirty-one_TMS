$(document).ready(function() {
	
	const root = document.querySelector(':root');
	const rootStyles = getComputedStyle(root);
	
	let preClicked = null;
	
	
	$(".sidebar-title").on("click", function() {
//		$(this).css("background-color", rootStyles.getPropertyValue('--blue'));
//		$(this).css("color", 'white');
		$('.sidebar-title').each(function(){
			let img = $(this).find('.sidebar-icon');
			let arrow = $(this).find('.arrow');
			let originArrow = arrow.data('original-src');
			let originSrc = img.data('original-src');
			img.attr('src',originSrc);
			arrow.attr('src', originArrow);
			
			$(this).css('background-color', '');
			$(this).css('color', rootStyles.getPropertyValue('--darkgray'))
		})
		
		var clickedImg = $(this).find('.sidebar-icon');
		var clickedArrow = $(this).find('.arrow');
		var newArrow = clickedArrow.data('active-src');
		var newSrc = clickedImg.data('active-src');
		clickedImg.attr('src', newSrc);
		clickedArrow.attr('src', newArrow);
		
		$(this).css('background-color', rootStyles.getPropertyValue('--blue'));
		$(this).css('color', 'white');
		let navText = $(this).find('span').html();
		let icon = $(this).find('.sidebar-icon');
		let arrow = $(this).find('.arrow');
		if(navText === '홈'){
			
		}else if(navText === '공지사항'){
			
		}else if(navText === '전자결재'){
			$(this).next('.sidebar-subtitle-box').slideToggle(300);	
		}else if(navText === 'HR'){
			$(this).next('.sidebar-subtitle-box').slideToggle(300);				
		}
		preClicked = this;
	});
	
	$(".sidebar-subtitle").on("click", function(){
		$('.sidebar-subtitle').each(function(){
			$(this).css('background-color', '');
			$(this).css('color', rootStyles.getPropertyValue('--lightkgray'))
		})
		$(this).css('background-color', rootStyles.getPropertyValue('--skyblue'));
		$(this).css('color', 'white');
	})

});