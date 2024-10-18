$(document).ready(function() {
	
	const root = document.querySelector(':root');
	const rootStyles = getComputedStyle(root);
	
	const customBlue = rootStyles.getPropertyValue('--blue');
	const customDarkGray = rootStyles.getPropertyValue('--darkgray');
	const customLightGray = rootStyles.getPropertyValue('--lightgray');
	const customSkyBlue = rootStyles.getPropertyValue('--skyblue');
	const customBlack = rootStyles.getPropertyValue('--black');
	
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
			$(this).css('color',customDarkGray);
			$(this).find('a').css('color', customDarkGray);
		})
		
		var clickedImg = $(this).find('.sidebar-icon');
		var clickedArrow = $(this).find('.arrow');
		var newArrow = clickedArrow.data('active-src');
		var newSrc = clickedImg.data('active-src');
		clickedImg.attr('src', newSrc);
		clickedArrow.attr('src', newArrow);
		
		$(this).css('background-color', customBlue);
		$(this).find('a').css('color', 'white');
		$(this).css('color', 'white');
		
		let navText = $(this).find('a').html();
		let icon = $(this).find('.sidebar-icon');
		let arrow = $(this).find('.arrow');
		
		$('.sidebar-subtitle').each(function(){
			$(this).css('background-color', '');			
			$(this).find('a').css('color', customLightGray);		
		})
		$(this).next('.sidebar-subtitle-box').children('div:nth-child(1)').css('background-color', customSkyBlue);			
		$(this).next('.sidebar-subtitle-box').children('div:nth-child(1)').find('a').css('color', 'white');			
		
		if(navText === '홈'){
			$(".sidebar-subtitle-box").each( function() {
				if($(this).css("display") == 'block'){
					$(this).slideToggle(300);
				}
			});
		}else if(navText === '공지사항'){
			$(".sidebar-subtitle-box").each( function() {
				if($(this).css("display") == 'block'){
					$(this).slideToggle(300);
				}
			});
		}else if(navText === '전자결재'){
			if($('.sidebar-hr').next('.sidebar-subtitle-box').css("display") == 'block'){
				$('.sidebar-hr').next('.sidebar-subtitle-box').slideToggle(300);
			}
			$(this).next('.sidebar-subtitle-box').slideToggle(300);	
		}else if(navText === 'HR'){
			if($('.sidebar-approval').next('.sidebar-subtitle-box').css("display") == 'block'){
				$('.sidebar-approval').next('.sidebar-subtitle-box').slideToggle(300);
			}
			$(this).next('.sidebar-subtitle-box').slideToggle(300);				
		}
		preClicked = this;
	});
	
	$(".sidebar-subtitle").on("click", function(){
		$('.sidebar-subtitle').each(function(){
			$(this).css('background-color', '');
			$(this).find('a').css('color', customLightGray)
		})
		$(this).css('background-color', customSkyBlue);
		$(this).find('a').css('color', 'white');
		let subtitle = $(this).data("subtitle");
		if(subtitle !== undefined){
			$('.subtitle').css("display", "none");
			$("."+subtitle).css("display", 'flex');

			$("."+subtitle).children('div:nth-child(1)').css('border-bottom', '2px solid ' + customBlue);
			$("."+subtitle).children('div:nth-child(1)').find('a').css('color', customBlue);
			
		}else{
			$('.subtitle').css("display", "none");
		}
				
	})
	
	$(".subtitle div a").on("click", function(){
		$(this).parent().siblings().css("border-bottom", "none");
		$(this).parent().siblings().find('a').css("color", customDarkGray);		
		$(this).parent().css("border-bottom", "2.5px solid "+ customBlue);
		$(this).css("color", customBlue);
	})
	

});