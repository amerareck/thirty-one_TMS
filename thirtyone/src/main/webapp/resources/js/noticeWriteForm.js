document.addEventListener("DOMContentLoaded", function() {

document.getElementById('contentForm').addEventListener("submit", function(e) {
	e.preventDefault();

	if (contentValidChk()) {
		contentForm.submit();
	}
});

//유효성 검사
function contentValidChk() {
	var editor = document.getElementById("editor").value;
	var titleBox = document.getElementById("titleBox").value;
	
	if (titleBox.length === 0 || titleBox == "") {
		alert("제목을 입력해주세요.");
		return false;
	}

	if (editor.length === 0) {
		alert("내용이 비어있습니다. 내용을 입력해주세요.");
		return false;
	}
	return true;
}

/*$('textarea').on('keyup', function() {
	var editor = $(this).val();
	var titleBox = $(this).val();*/



//부트스트랩 모달
const exampleModal = document.getElementById('exampleModal')

exampleModal.addEventListener('shown.bs.modal', () => {
	exampleModal.focus()
})

//드래그 앤 드랍
const box = document.querySelector("dropZone");

window.addEventListener("dragover", function(e) {
	console.log("드래그")
	e.preventDefault();
});

window.addEventListener("drop", function(e) {
	console.log("드랍")
	e.preventDefault();

	
	
	const files = e.dataTransfer.files;
	addFileList(files[0]);
	console.log(files[0]);
	
	const dataTransfer = new DataTransfer();


	
	for(var i=0; i<files.length; i++) {
		dataTransfer.items.add(files[i])
	}
	
})

function addFileList(files) {
	const fileList = document.getElementById("fileList");
};
//드래그 앤 드랍 이미지 출력
const dropZone = document.querySelector("#dropZone");
const fileBox = document.querySelector(".fileBox");

fileBox.addEventListener('click', (e)=> {
	e.preventDefault();
});

dropZone.addEventListener('dragover', (e)=> {
	e.preventDefault();
});

dropZone.addEventListener('drop', (e)=> {
	e.preventDefault();
	
	
	const files = e.dataTransfer.files;
	console.log(files[0]);
	
	const type=files[0].type;
	
	if(type !=="image/png" && type !=="image/jpg" && type !=="image/jpeg" && type !=="image/gif") {
		alert("이미지 파일이 아닙니다.");
		return;
	}
	
	if(files.length > 0) {
		const reader=new FileReader();
		reader.onload=(event)=> {
			const data=event.target.result;
			console.log(data);
			
			$(".fileBox p").empty(); // 처음에만 empty사용 후 여러개 하고싶으면 append로
										// 추가해줘야 한다.
			$('#preview').attr("src", data);
			$('#preview').css("width", "100px");
			
		};
		reader.readAsDataURL(files[0]);
	}
});
//빈 영역 클릭시 이미지 첨부 가능
document.querySelector(".fileBox").addEventListener("click", () => {
	document.querySelector("#uploadFile").click();
	});
});

//체크박스
function getCheckboxValue() {
	
	const query = 'input[name="deptId"]:checked';
	const selectedEls =
		document.querySelectorAll(query);
	
	let result = '';
	selectedEls.forEach((el) => {
		result += el.value + ' ';
	});
	
	
	document.getElementById('result').innerText
		=result;
	console.log(result);
	
}
	