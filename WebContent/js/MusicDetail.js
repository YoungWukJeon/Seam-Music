$(document).ready(function() {
    $('#music_title').css('height', 'calc(140px + ' + 1*60 + 'px');
    // 1을 나중에 music.length로
    
    
    
	$("#like_button").click(function() {
	    	
    	if( id != 'null' )
    	{
	    	$.ajax({
	    		url: "PreferenceProc.jsp",
	            type: 'post',
	            async: false,
	            crossDomain: true,
	            data: {
	            	kind: 'music',
	            	item_no: item_no,
	                id: id,
	                processType: processType
	            },
	            success: function(data) {
	            	
	            	if( processType == 'add')
	            	{
	            		alert("좋아요를 하셨습니다.");
	            		
	            		$("#like_button").empty();
	            		$("#like_button").append("<img src='image/heart.png'>" + "좋아요 취소 (" + data.trim() + ")");
	            		processType = "delete";
	            	}
	            	else
	            	{
	            		alert("좋아요를 취소하셨어요.");
	            		
	            		$("#like_button").empty();
	            		$("#like_button").append("<img src='image/heart_none.png'>" + "좋아요 (" + data.trim() + ")");
	            		processType = "add";
	            	}
	            }
	    	});
    	}
    	else
    	{
    		alert('좋아요를 하기 위해서는 로그인이 필요합니다.');
    		parent.$("#login_form")[0].contentWindow.$(".logo_reset").eq(0).focus();
    	}
    });

	$(".move_artist").click(function() {
		location.href = "ArtistDetail.jsp?artist_no=" + $(this).attr("data-no");
	});
	
	$(".move_album").click(function() {
		location.href = "AlbumDetail.jsp?album_no=" + $(this).attr("data-no");
	});
	
	$(".move_playlist").click(function() {
		location.href = "DJDetail.jsp?playlist_no=" + $(this).attr("data-no");
	});
});