
const addBtn = document.querySelector('.add-department-btn');

addBtn.addEventListener("click",function() {
	const deptId = document.querySelector('.input-dept-id').value;
	const deptName = document.querySelector('.input-dept-name').value;
	const empId = document.querySelector('.input-dept-head').value;
	const regionalOffice = document.querySelector('.input-region').value;
	
	console.log(deptId + " " + deptName+ " " + empId+ " " +regionalOffice);
	$.ajax({
		method:"post",
		url: contextPath+'/dept/addDept',
		data :{
			'deptId' : deptId,
			'deptName' : deptName,
			'empId' : empId,
			'regionalOffice' : regionalOffice
		},
		success: function(data){
			location.reload();
		}
	})
})

$(document).on("click", '.dept-move-btn', function () {
	let deptId = this.dataset.deptid;
	let region = this.dataset.region;
	console.log(region);
	document.querySelector('.move-btn-accept').dataset.deptid= deptId;
	document.querySelector('.pre-office').innerHTML = region;
	
})

$(document).on("click", '.dept-name-btn',function () {
	let deptId = this.dataset.deptid;
	let deptname = this.dataset.deptname;
	document.querySelector('.dept-name-change-btn').dataset.deptid= deptId;
	document.querySelector('.pre-dept').innerHTML = deptname;
	
})

$(document).on("click", '.dept-head-btn',function () {
	let deptId = this.dataset.deptid;
	let depthead = this.dataset.depthead;
	document.querySelector('.dept-head-change-btn').dataset.deptid= deptId;
	document.querySelector('.pre-dept-head').innerHTML = depthead;
	
})

$(document).on("click", '.dept-id-btn',function () {
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
	const deptHead = $('.after-dept-head').val();
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