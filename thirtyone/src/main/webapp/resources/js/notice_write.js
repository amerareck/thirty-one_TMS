
function contentValidChk(content) {
    var content = document.getElementById("content").value;
    var titleBox = document.getElementById("titleBox").value;
    var customSelect = document.getElementById("custom-select").value;


    if(titleBox.length === 0) {
        alert("제목을 입력해주세요.");
        return false;
    }

    if(content.length === 0) {
        alert("내용이 비어있습니다. 내용을 입력해주세요.");
        return false;
     }

     if(customSelect.value === 0) {
        alert("중요도를 선택해주세요.");
        return false;
     }     
    }


    const uploadFile = document.getElementById('uploadFile');
    
    uploadFile.onchange = function() {
        const selectedFile = [...uploadFile.files];
        const fileReader = new FileReader();

        fileReader.readAsDataURL(selectedFile[0]);

        fileReader.onload = function() {
            document.getElementById("previewImg").src = fileReader.result;
        };
        console.log(selectedFile);
    };
