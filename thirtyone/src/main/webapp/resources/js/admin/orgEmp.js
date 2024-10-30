$('.check-all-select').on('change', function () {
	if($(this).is(':checked')){
		$('.check-box').each( function () {
			$(this).prop('checked', true);
		})
	}else{
		$('.check-box').each( function () {
			$(this).prop('checked', false);
		})
	}
})
let empList = [];

$(document).on('click', 'tr.table-group-divider', function(e) {
	let deptName = $(this).find('td').eq(3).html();
	let empId = $(this).find('input').data('empid');
	if (!$(e.target).hasClass('check-box')) {
        $('#dept-update-modal').modal('show');
        empList = [];
        empList.push(empId);
        $('.pre-pos-dept').html(deptName);
    }
});


$('.dept-update-btn').on('click', function(){
	empList = [];
	let deptList = new Set;
	$('.check-box:checked').each(function (){
		deptList.add($(this).closest('tr').find('td').eq(3).html());
		empList.push($(this).data('empid'));
	})
	
	deptList = Array.from(deptList);
	if(deptList.length > 1){
		$('.pre-pos-dept').html(deptList[0]+' 외 '+ (deptList.length-1) );
		$('.pre-pos-dept').append('<span>'+empList.length+'</span>');
	}else if(deptList.length === 1){
		$('.pre-pos-dept').html(deptList[0]);
	}else{
		$('.pre-pos-dept').html("선택된 데이터가 없습니다.");		
	}
	
})



$('.accept').on('click', function(){
	let deptId= $('.aftermove').val();
	let changeData={'empList' : empList, 'deptId': deptId};
	
	$.ajax({
		method: "post",
		url: contextPath+"/admin/changeEmpDept",
		contentType: "application/json",
		data: JSON.stringify(changeData),
		success: function(data){
			location.reload();
		}
	})
})


function enterkeySearch(){
	if (window.event.keyCode == 13			) {
		search($('#search').val(), $('#search-menu').val() );
	}
}

$('.search-btn').on("click", function () {
	search($('#search').val(), $('#search-menu').val() );
})

function search(value, category){
	console.log(value, category);
	location.href = contextPath + "/admin/searchDeptEmp?query=" + value + "&category=" + category;
}
