
function updateClock(role) {
    const now = new Date();    
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    
    const timeString = `${hours}:${minutes}:${seconds}`;
    if(role=="ROLE_USER"){
    	document.querySelector('.sidebar-today-time').textContent = timeString;
    }else if(role=="true"){
    	document.querySelector('.sidebar-today-time').textContent = timeString;
    	document.querySelector('.mini-today-time').textContent = timeString;
    }
}


function updateToday(role){
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');

    const todayString = `${year}년${month}월${day}일`;
    if(role=="ROLE_USER"){
	    document.querySelector('.sidebar-today').textContent = todayString;
    }else if(role=="true"){
    	document.querySelector('.sidebar-today').textContent = todayString;
        document.querySelector('.mini-today').textContent = todayString;
    }
}

function formatTime(date){

	const dateTime = new Date(date);

	const hours = dateTime.getHours();
	const minutes = dateTime.getMinutes();

	return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
}
$(document).ready(function() {
	$.ajax({
		method:"get",
		url: contextPath+'/getNumberNotReaded',
		success: function (data){
			$(".alert-num").empty();
			$(".alert-num").html(data);
			console.log(data);
		}
	})
	$.ajax({
		method: "get",
		url: contextPath+'/getInfo',
		success: function(data){
			$(".emp-name").text(data.empName + " " + data.position);
			$(".dept-name").text(data.deptName);
			let role = data.empRole;

			if(data.atd !== null){
				if(data.atd.checkIn === null || data.atd.checkIn === undefined){
					$('.sidebar-start-time span:nth-child(2)').html('--:--');
				}else{
					$('.sidebar-start-time span:nth-child(2)').html(formatTime(data.atd.checkIn));
				}
				
				if(data.atd.checkOut === null || data.atd.checkOut == undefined){
					$('.sidebar-end-time span:nth-child(2)').html('--:--');
				}else{
					$('.sidebar-end-time span:nth-child(2)').html(formatTime(data.atd.checkOut));
				}
			}else{
				$('.sidebar-start-time span:nth-child(2)').html('--:--');
				$('.sidebar-end-time span:nth-child(2)').html('--:--');
			}
			
			
			updateToday(role);
			updateClock(role);
			
			setInterval(function() {
				updateClock(role);
			}, 1000);
		}
		
	})
	
	
	const root = document.querySelector(':root');
	const rootStyles = getComputedStyle(root);
	
	const customBlue = rootStyles.getPropertyValue('--blue');
	const customDarkGray = rootStyles.getPropertyValue('--darkgray');
	const customLightGray = rootStyles.getPropertyValue('--lightgray');
	const customSkyBlue = rootStyles.getPropertyValue('--skyblue');
	const customBlack = rootStyles.getPropertyValue('--black');
	
	let preClicked = null;
	
	$(".sidebar-title").on("click", function() {
		
		$('.sidebar-title').each(function(){
			let img = $(this).find('.sidebar-icon');
			let arrow = $(this).find('.arrow');
			let originArrow = arrow.data('original-src');
			let originSrc = img.data('original-src');
			img.attr('src',originSrc);
			arrow.attr('src', originArrow);
			
			$(this).css('background-color', 'white');
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
			$('.subtitle').css("display", "none");
			if($('.sidebar-hr').next('.sidebar-subtitle-box').css("display") == 'block'){
				$('.sidebar-hr').next('.sidebar-subtitle-box').slideToggle(300);
			}
			$(this).next('.sidebar-subtitle-box').slideToggle(300);	
		}else if(navText === 'HR'){			
			if($('.sidebar-approval').next('.sidebar-subtitle-box').css("display") == 'block'){
				$('.sidebar-approval').next('.sidebar-subtitle-box').slideToggle(300);
			}
			$(this).next('.sidebar-subtitle-box').slideToggle(300);
		}else if(navText ==='회원관리'){
			if($('.sidebar-org').next('.sidebar-subtitle-box').css("display") == 'block'){
				$('.sidebar-org').next('.sidebar-subtitle-box').slideToggle(300);
			}
			$(this).next('.sidebar-subtitle-box').slideToggle(300);
		}else if(navText ==='조직관리'){
			if($('.sidebar-emp').next('.sidebar-subtitle-box').css("display") == 'block'){
				$('.sidebar-emp').next('.sidebar-subtitle-box').slideToggle(300);
			}
			$(this).next('.sidebar-subtitle-box').slideToggle(300);
		}
		preClicked = this;
	});
	
	
	var options = {
	  enableHighAccuracy: true,
	  timeout: 5000,
	  maximumAge: 0,
	};

	function success(pos, atd) {
		var crd = pos.coords;
		console.log(atd);
		console.log(crd);
		
		$.ajax({
			method: 'Get',
			url: '/thirtyone/atd/' + atd,
			data: {
				"latitude" : crd.latitude,
				"longitude" : crd.longitude
			},
			success : function (data){
				if(!data){
					Swal.fire({
					  icon: "error",
					  title: "지역이 다른 곳입니다.",
					  text: "해당 지역에서 버튼을 눌러주세요."
					});
				
				}
				location.reload();
			},
			error : function (request, status, error){
						  
			}	
		})

	}

	function error(err) {
	  console.warn(`ERROR(${err.code}): ${err.message}`);
	}	
	
	$(".sidebar-start").on("click", function(){ 
		navigator.geolocation.getCurrentPosition((pos) => success(pos, "checkIn"), error, options);
	});
	
	$(".sidebar-end").on("click", function(){ 
		navigator.geolocation.getCurrentPosition((pos) => success(pos, "checkOut"), error, options);
	});
	

});