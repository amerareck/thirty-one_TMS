document.getElementById('contentForm').addEventListener("submit", function(e) {
	e.preventDefault();

	if (contentValidChk()) {
		contentForm.submit();
		window.location.href = '/thirtyone/notice/noticeList';
	}
});

function contentValidChk() {
	var content = document.getElementById("content").value;
	var titleBox = document.getElementById("titleBox").value;

	if (titleBox.length === 0) {
		alert("제목을 입력해주세요.");
		return false;
	}

	if (content.length === 0) {
		alert("내용이 비어있습니다. 내용을 입력해주세요.");
		return false;
	}
	return true;
}

const box = document.querySelector(".fileBox");

window.addEventListener("dragover", function(e) {
	console.log("드래그")
	e.preventDefault();
});

window.addEventListener("drop", function(e) {
	console.log("드랍")
	e.preventDefault();
	
	const arr = e.dataTransfer.files;
	addFileList(arr);
	
	const dataTransfer = new DataTransfer();
	
	for(var i=0; i<arr.length; i++) {
		dataTransfer.items.add(arr[i])
	}
	
	/*document.getElementById("files").files = dataTransfer.files;*/
	
})

function addFileList(files) {
	const fileList = document.getElementById("fileList");
}


CKEDITOR.replace('editor', {
	height: 200,
});

function getEditorData() {
	const data = CKEDITOR.instances.editor.getData();
	console.log(data);
	return data;
}
	
	
	