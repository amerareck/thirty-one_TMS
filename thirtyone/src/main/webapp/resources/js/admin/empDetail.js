$("#empImage").on("change", function(e){
	const file = e.target.files[0];
	
	if(file && file.type.startsWith('image/')){
		const reader = new FileReader();
		reader.onload = function(e){
			$('#empImg').attr('src', e.target.result);
			$('#empImg').attr('width', 140);
			$('#empImg').attr('height', 185);
			
		}

        reader.readAsDataURL(file);
	}else {
        alert('이미지 파일을 선택해주세요.');
    }
})
