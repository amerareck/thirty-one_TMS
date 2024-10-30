$('.add-pos-btn').on('click', function(){
	const posVal = $('.add-position').val();
	$.ajax({
		method: "post",
		url: contextPath + '/admin/createPos',
		data: {'pos' : posVal},
		success: function () {
			location.reload();
		}
	})
})

$(document).on("click", ".fa-caret-up", function() {
	const posClass = $(this).data('pos');
	console.log(posClass);
	$.ajax({
		method: "GET",
		url: contextPath + '/admin/moveUpPos',
		data: {'posClass': posClass},
		success: function (){
			location.reload();
		}
	})
})

$(document).on("click", ".fa-caret-down", function() {
	const posClass = $(this).data('pos');
	$.ajax({
		method: "GET",
		url: contextPath + '/admin/moveDownPos',
		data: {'posClass': posClass},
		success: function (){
			location.reload();
		}
	})
})

$(document).on("click", '.fa-pencil-alt', function () {
	let positionClass = this.dataset.pos;
	let posname = this.dataset.posname;
	
	document.querySelector('.change-btn-accept').dataset.posclass= positionClass;
	document.querySelector('.pre-pos-name').innerHTML = posname;
})

$(document).on("click", ".change-btn-accept", function () {
	let posClass = this.dataset.posclass;
	let posName = document.querySelector('.after-pos-name').value;
	
	$.ajax({
		method: "post",
		url: contextPath + '/admin/changePosName',
		data: {'posClass': posClass, 'posName': posName},
		success: function(){
			location.reload();
		}
	})
})
