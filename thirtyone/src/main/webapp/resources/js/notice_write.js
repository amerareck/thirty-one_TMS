document.addEventListener("DOMContentLoaded", function() {

document.getElementById('contentForm').addEventListener("submit", function(e) {
	e.preventDefault();

	if (contentValidChk()) {
		form.action = 'thirtyone/notice/insertNotice';
		form.method = 'POST'
		contentForm.submit();
		window.location.href = '/thirtyone/notice/noticeList';
	}
});


function contentValidChk() {
	var editor = document.getElementById("editor").value;
	var titleBox = document.getElementById("titleBox").value;

	if (titleBox.length === 0) {
		alert("제목을 입력해주세요.");
		return false;
	}

	if (editor.length === 0) {
		alert("내용이 비어있습니다. 내용을 입력해주세요.");
		return false;
	}
	return true;
}


const exampleModal = document.getElementById('exampleModal')

exampleModal.addEventListener('shown.bs.modal', () => {
	exampleModal.focus()
})



const box = document.querySelector(".fileBox");

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
	
	/* document.getElementById("files").files = dataTransfer.files; */
	
})


function addFileList(files) {
	const fileList = document.getElementById("fileList");
};

const dropZone = document.querySelector("#dropZone");
dropZone.addEventListener('dragover', (e)=> {
	e.preventDefault();
});
dropZone.addEventListener('drop', (e)=> {
	e.preventDefault();
	
	const files = e.dataTransfer.files;
	console.log(files[0]);
	
	const type=files[0].type;
	
	if(type !="image/png" & type !="image/jpg" & type !="image/gif") {
		alert("이미지 파일이 아닙니다.");
		return;
	}
	
	if(files.length > 0) {
		const reader=new FileReader();
		reader.onload=(event)=> {
			const data=event.target.result;
			
			document.querySelector('#preview').setAttribute("src", data);
			document.querySelector('#preview').style.display="block";			
			document.querySelector('#dropZone p').style.display="none";
			document.querySelector("#uploadFile").files = files;
		};
		reader.readAsDataURL(files[0]);
	}
});

document.querySelector("#dropZoneLink").addEventListener("click", () => {
	document.querySelector("#uploadFile").click();
	});
});

function getCheckboxValue() {
	
	const query = 'input[name="check"]:checked';
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
	