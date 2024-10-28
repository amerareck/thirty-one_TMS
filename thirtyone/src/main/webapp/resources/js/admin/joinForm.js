
document.addEventListener('click', () => {
	if(event.target.matches('#btnZipcode')){
		console.log("asd");
	    new daum.Postcode({
	        oncomplete: function(data) {
	            console.log(data);
	            let fullAddr = '';
	            let extraAddr = '';
	
	            if (data.userSelectedType === 'R') {
	                fullAddr = data.roadAddress;
	            } else {
	                fullAddr = data.jibunAddress;
	            }
	
	            if (data.userSelectedType = 'R') {
	                if (data.bname !== '') {
	                    extraAddr += data.bname;
	                }
	                if (data.buildingName !== '') {
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                fullAddr += (extraAddr !== '' ? '(' + extraAddr + ')' : '');
	            }
	
	            document.formInfo.empPostal.value = data.zonecode;
	            document.formInfo.empAddress.value = fullAddr;
	            
	        }
	    }).open();
	}
});

let inputName = document.querySelector('#empName');
inputName.addEventListener('input', inputNameCheck);

function inputNameCheck() {
    let inputNameMessage = document.querySelector('#inputNameMessage');

    let regExp = RegExp(/^[가-힣a-zA-Z]{1,20}$/);
    if (regExp.test(inputName.value) || inputName.value === '') {
        inputNameMessage.innerHTML =  ''; 
        return true;
    } else {
        inputNameMessage.innerHTML = 
        "<span style='color:#F03F40; font-size:12px;'>영문 또는 한글로 입력해주세요</span>";
        return false;
    }
}

//핸드폰 번호 입력 유효성 검사 
let inputPhone = document.querySelector('#empTel');
inputPhone.addEventListener('input', inputPhoneCheck);

function inputPhoneCheck() {
    let inputTelMessage = document.querySelector('#inputTelMessage');

    let regExp = RegExp(/^[0-9]{1,11}$/);
    if (regExp.test(inputPhone.value) || inputPhone.value === '') {
    	inputTelMessage.innerHTML =  ''; 
        return true;
    } else {
    	inputTelMessage.innerHTML = 
        "<span style='color:#F03F40; font-size:12px;'>-하이픈을 제외하고 11자리로 입력해주세요</span>";
        return false;
    }
}

let idCheck = false;
let inputId = document.querySelector('#empId');
inputId.addEventListener('input', inputIdCheck);

function inputIdCheck() {
    let inputIdMessage = document.querySelector('#inputIdMessage');
    const submitBtn = document.querySelector('.id-check');

    let regExp = RegExp(/^[A-Za-z\d@$!%*?&]{6,16}$/);
    if (regExp.test(inputId.value)) {
        inputIdMessage.innerHTML =  ''; 
        submitBtn.disabled = false;
        idCheck = true;
    } else if(inputId.lenght == 0){
    	submitBtn.disabled = true;   
    	idCheck = false;
    } else{
        inputIdMessage.innerHTML = 
        "<span style='color:#F03F40; font-size:12px;'>6자 이상 16자 이하로 영문, 숫자를 사용해주세요</span>";
        submitBtn.disabled = true;
        idCheck = false;
    }
}

$(".id-check").on('click', function(){
    let inputIdMessage = document.querySelector('#inputIdMessage');
	const empId = $("#empId").val();
	console.log(empId);
	$.ajax({
		method: "POST",
		url: '/thirtyone/emp/idCheck',
		data: {"empId" : empId} ,
		success: function(data){
			let inputIdMessage = document.querySelector('#inputIdMessage');
			if(data)
				inputIdMessage.innerHTML = 
			        "<span style='color:#F03F40; font-size:12px;'>사용할 수 있는 아이디입니다.</span>";
			else{
				inputIdMessage.innerHTML = 
			        "<span style='color:#F03F40; font-size:12px;'>이미 사용중인 아이디입니다.</span>";
				$("#empId").val("");
			}
				
		}
		
		
	})
})

let inputEmail = document.querySelector('#empEmail');
inputEmail.addEventListener('input', inputEmailCheck);

function inputEmailCheck() {
    let inputEmailMessage = $('#inputEmailMessage');

    let regExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (regExp.test(inputEmail.value) || inputEmail.value === '') {
        inputEmailMessage.html('');
        return true;
    } else {
        inputEmailMessage.html(
            "<span style='color:#F03F40; font-size:12px;'>이메일 형식을 확인해주세요</span>"
        );
        return false;
    }
}

let signupGo = document.querySelector('#submit-btn');
signupGo.addEventListener('click', function (e) {

	 if (!idCheck) {
		 e.preventDefault();
		 console.log("못함");
	     return; 
	 }
	 else if(!inputPhoneCheck()){
		e.preventDefault();
		console.log("못함");
	    return; 
	 }
	 else if(!inputEmailCheck()){
		e.preventDefault();
		console.log("못함");
	    return;
	 }
	 else if(!inputNameCheck()){
		e.preventDefault();
		console.log("못함");
	    return;
	 }
	 
});

