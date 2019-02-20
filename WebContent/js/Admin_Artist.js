$(document).ready(function() {
	$("#check_all").click(function() {
		if( $(this).is(":checked") )
			$(".check_each").prop("checked", true);
		else
			$(".check_each").prop("checked", false);
	});
});

function deleteMusic()
{
	alert('삭제');
}