
const addBtn = document.querySelector('.add-department-btn');

addBtn.addEventListener("click",function() {
	const deptId = document.querySelector('.input-dept-id').value;
	const deptName = document.querySelector('.input-dept-name').value;
	const empNumber = document.querySelector('.choice-dept-name').value;
	const regionalOffice = document.querySelector('.input-region').value;
	if(deptId !== "" && deptId !== null && deptId !== undefined && 
		deptName !== "" && deptName !== null && deptName !== undefined && 
		empNumber !== "" && empNumber !== null && empNumber !== undefined && 
		regionalOffice !== "" && regionalOffice !== null && regionalOffice !== undefined){
		$.ajax({
			method:"post",
			url: contextPath+'/dept/addDept',
			data :{ 'deptId' : deptId,
					'deptName' : deptName,
					'regionalOffice' : regionalOffice,
					'empNumber': empNumber
			},
			success: function(data){
				location.reload();
			}
		})
	}
	else{
		alert("입력을 다시 확인해 주세요.");
	}
})

$(document).on("click", '.dept-move-btn', function () {
	$(".aftermove").val("");
	let deptId = this.dataset.deptid;
	let region = this.dataset.region;
	
	document.querySelector('.move-btn-accept').dataset.deptid= deptId;
	document.querySelector('.pre-office').innerHTML = region;
	
})

$(document).on("click", '.dept-name-btn',function () {
	$(".aftermove").val("");
	let deptId = this.dataset.deptid;
	let deptname = this.dataset.deptname;
	document.querySelector('.dept-name-change-btn').dataset.deptid= deptId;
	document.querySelector('.pre-dept').innerHTML = deptname;
	
})

$(document).on("click", '.dept-head-btn',function () {
	$(".choice-dept-name-modal").val("");
	$(".aftermove").val("");
	let deptId = this.dataset.deptid;
	let depthead = this.dataset.depthead;
	document.querySelector('.dept-head-change-btn').dataset.deptid= deptId;
	document.querySelector('.pre-dept-head').innerHTML = depthead;
	
})

$(document).on("click", '.dept-id-btn',function () {
	$(".aftermove").val("");
	let deptId = this.dataset.deptid;
	document.querySelector('.dept-id-change-btn').dataset.deptid= deptId;
	document.querySelector('.pre-dept-id').innerHTML = deptId;
	
})

$(".move-btn-accept").on("click", function(){
	const region = $('.after-office').val();
	const deptId = $('.move-btn-accept').data('deptid');
	$.ajax({
		method: "post",
		url: contextPath+'/dept/changeRegion',
		data: {
			'region': region,
			'deptId': deptId
		},
		success: function(data){
			location.reload();
		}
	})
});
$(".dept-name-change-btn").on("click", function(){
	const deptName = $('.after-dept').val();
	const deptId = $('.dept-name-change-btn').data('deptid');
	$.ajax({
		method: "post",
		url: contextPath+'/dept/changeDeptName',
		data: {
			'deptName': deptName,
			'deptId': deptId
		},
		success: function(data){
			location.reload();
		}
	})
});
$(".dept-head-change-btn").on("click", function(){
	const deptHead = $('.choice-dept-name-modal').val();
	const deptId = $('.dept-head-change-btn').data('deptid');
	$.ajax({
		method: "post",
		url: contextPath+'/dept/changeDeptHead',
		data: {
			'deptHead': deptHead,
			'deptId': deptId
		},
		success: function(data){
			location.reload();
		}
	})
});

$(".dept-id-change-btn").on("click", function(){
	const deptId = $('.after-dept-id').val();
	const preDeptId = $('.dept-id-change-btn').data('deptid');
	$.ajax({
		method: "post",
		url: contextPath+'/dept/changeDeptId',
		data: {
			'deptId': deptId,
			'preDeptId' : preDeptId
			
		},
		success: function(data){
			location.reload();
		}
	})
});

$(document).on("click", ".dept-delete-btn", function() {
	const deptId = $(this).data("deptid");
	$.ajax({
		method: "post",
		url : contextPath+"/dept/deleteDept",
		data: {"deptId": deptId},
		success: function (data){
			if(!data){
				alert("부서원이 남아있습니다.");
			}else{
				location.reload();
			}
		}
		
	})
})


$('.input-dept-head').on('change', function(){
	let	empName = $('.input-dept-head').val();
	
	$.ajax({
		method: "get",
		url: contextPath+"/emp/getEmpNumber",
		data: {'empName':empName},
		success: function(data) {
			if(data.length > 0){
				data.forEach(function(item) {
					$('.choice-dept-name').append('<option>'+item.empNumber+'</option>');				
				})
			}else{
				$('.input-dept-head').val('');
				$('.input-dept-head').prop('placeholder', "존재하지 않습니다.");
			}
		}
		
		
	})
})

$('.after-dept-head').on('change', function(){
	let	empName = $('.after-dept-head').val();
	
	$.ajax({
		method: "get",
		url: contextPath+"/emp/getEmpNumber",
		data: {'empName':empName},
		success: function(data) {
			if(data.length > 0){
				data.forEach(function(item) {
					$('.choice-dept-name-modal').append('<option>'+item.empNumber+'</option>');				
				})
			}else{
				$('.after-dept-head').val('');
				$('.after-dept-head').prop('placeholder', "존재하지 않습니다.");
			}
		}
	})
})

$(".input-dept-id").on('change', function(){
	let inputDeptId = $(this).val();
	let regExp = RegExp(/^[0-9]{3}$/);
	if(inputDeptId !== "" && inputDeptId !== null && inputDeptId !== undefined){
		$.ajax({
			method: "get",
			url: contextPath+"/dept/hasDeptId",
			data: {'deptId' : inputDeptId},
			success: function (data) {
				if( !regExp.test(inputDeptId)){
					$(".input-dept-id").val("");
					$('.input-dept-id').prop("placeholder", "숫자만 3글자 입력해주세요.");		
				}else if(!data){
					$(".input-dept-id").val("");
					$('.input-dept-id').prop("placeholder", "이미 있는 아이디입니다.");				
				}			
			}
		})
	}
})

$(".input-region").on('change', function(){
	let inputRegion = $(this).val();
	if(inputRegion !== '서울' && inputRegion !== '세종' && inputRegion !== '진천'){
		$('.input-region').val('');
		$('.input-region').prop('placeholder', "존재하지 않습니다.");
	}
})



