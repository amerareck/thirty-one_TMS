document.addEventListener("DOMContentLoaded", function() {

function enterkeySearch(event) {
	if (window.event.keyCode == 13) {	
		event.preventDefault();
		document.querySelector('form').submit();
	}
}


document.getElementById("searchCancel").addEventListener("click", (e) => {
	e.preventDefault();
	const inputSearch = document.getElementById("enterkeySearch");
	inputSearch.value = '';
	location.href = "/thirtyone/notice/noticeList?pageNo=1";
	console.log("jjjjj");
	
	});
});