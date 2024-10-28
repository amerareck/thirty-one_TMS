document.addEventListener('input', function() {
	
	if(event.target.matches("#updatePw") || event.target.matches("#updatePwCheck")){
		inputPasswordCheck();
	}

})

let inputPw = document.querySelector('#curPw');
inputPw.addEventListener('change', inputCurPwCheck);


let validCheck = false;

function inputCurPwCheck () {
	let empPassword = document.querySelector('#curPw').value;
	console.log(empPassword)
	let inputPasswordMessage1 = document.querySelector('.curpw-check');
	$.ajax({
		method: "post",
		url: "/thirtyone/emp/pwCheck",
		data: {"empPassword": empPassword },
		success: function(data) {
			if(data==false) {
				inputPasswordMessage1.innerHTML = "<span>비밀번호가 맞지 않습니다.</span>";
				validCheck = false;
			}else{
				inputPasswordMessage1.innerHTML = "";
				validCheck = true;
			}
		}
	})
	
	return validCheck;
	
}

document.querySelector('.pwChangeBtn').addEventListener('click', function() {
	if(!validNewCheck) return;
	if(!validCheck) return;
	
	let inputPassword1 = document.querySelector('#updatePw').value;
	
	$.ajax({
		method: "post",
		url: contextPath + "/emp/updatePw",
		data: {
			"empPassword" : inputPassword1
		},
		success: function (data) {
			location.href = contextPath+"/home";
		}
	})
	
})

let validNewCheck = false;

function inputPasswordCheck() {
	
	let inputPassword1 = document.querySelector('#updatePw');
	let inputPassword2 = document.querySelector('#updatePwCheck');
	let inputPasswordMessage1 = document.querySelector('.changed-pw');
	let inputPasswordMessage2 = document.querySelector('.pw-check');
	
	let regExp = RegExp(/^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,20}$/);
	if (regExp.test(inputPassword1.value)) {
		inputPasswordMessage1.innerHTML = 
			"";
		validNewCheck =  true;
	} else {
	    inputPasswordMessage1.innerHTML = 
	    "<span>*6자 이상 20자 이하면서 영문, 숫자, 특수문자를 모두 포함해주세요</span>";
	    validNewCheck =  false;
	}
	 
	if (document.activeElement === inputPassword2) {
		if (inputPassword1.value === inputPassword2.value) {
			inputPasswordMessage2.innerHTML =
				"";
			validNewCheck = true;
	    }else {
	        inputPasswordMessage2.innerHTML =
	        "<span>*비밀번호가 다릅니다.</span>";
	        validNewCheck = false;
	    }
	}
}