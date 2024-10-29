function enterkeySearch(){
	if (window.event.keyCode == 13			) {
		search($('#search').val(), $('#search-menu').val() );
		console.log($('#search-menu').val());
	}
}


function search(value, category){
	
	location.href = contextPath + "/admin/searchEmp?query=" + value + "&category=" + category;
}