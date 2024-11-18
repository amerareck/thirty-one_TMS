const toastTrigger = document.getElementById('liveToastBtn')
const toastLiveExample = document.getElementById('liveToast')

if (toastTrigger) {
  const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
  toastTrigger.addEventListener('click', () => {
    toastBootstrap.show()
  })
}

$("#search-menu").on("change", function(){
	const query = $(this).val();
	location.href = '/thirtyone/alert/list?query=' + query;
})

$(document).ready(function() {
	$.ajax({
		method: "post",
		url: '/thirtyone/alert/updateReadedAlert',
		success: function (){
			$.ajax({
				method:"get",
				url: contextPath+'/getNumberNotReaded',
				success: function (data){
					$(".alert-num").empty();
					$(".alert-num").html(data);
				}
			})
			
		}
	})
})