document.addEventListener("DOMContentLoaded", function() {

/*const dateControl = document.querySelector('input[type="date"]')
console.log(dateControl.value)
console.log(dateControl.valueAsNumber)*/


function enterkeySearch(event) {
	if (window.event.keyCode == 13) {	
		event.preventDefault();
		document.querySelector('form').submit();
	}
}

/*function search(value) {
	location.href = "/thirtyone/notice/searchNotice?noticeTitle=" + value;
	
}*/

document.getElementById("searchCancel").addEventListener("click", (e) => {
	e.preventDefault();
	const inputSearch = document.getElementById("enterkeySearch");
	inputSearch.value = '';
	location.href = "/thirtyone/notice/noticeList?pageNum=1";
	console.log("jjjjj");
	
	});
});