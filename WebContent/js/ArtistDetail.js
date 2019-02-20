$(document).ready(function() {
	$(".musicList_listen img").on("mouseenter", function() {
        $(this).attr("src", "image/listen_over_icon.png");
    });
    $(".musicList_listen img").on("mouseleave", function() {
        $(this).attr("src", "image/listen_icon.png");
    });
    $(".musicList_add img").on("mouseenter", function() {
        $(this).attr("src", "image/add_over_icon.png");
    });
    $(".musicList_add img").on("mouseleave", function() {
        $(this).attr("src", "image/add_icon.png");
    });
    $(".musicList_lyrics img").on("mouseenter", function() {
        $(this).attr("src", "image/lyrics_over_icon.png");
    });
    $(".musicList_lyrics img").on("mouseleave", function() {
        $(this).attr("src", "image/lyrics_icon.png");
    });

    $("#all_select").click(function() {

        var totalCount = $(".box_checkbox").length;
        var partCount = $(".box_checkbox:checked").length;

        if (totalCount > partCount)
            $(".box_checkbox").prop("checked", true);
        else
            $(".box_checkbox").prop("checked", false);

    });
    
    $(".list_title").click(function() {
		var index = $(this).index();
		
		if( index == 0 )
		{
			$('#musicList').css('display', 'block');
			$('#list_title_1').css('color', 'rgb(243, 119, 117)');
			$('#list_title_1').css('background', 'white');
			$('#album_table_back').css('display', 'none');
			$('#list_title_2').css('color', 'white');
			$('#list_title_2').css('background', 'rgb(180, 180, 180)');
		}
		else
		{
			$('#album_table_back').css('display', 'block');
			$('#list_title_2').css('color', 'rgb(243, 119, 117)');
			$('#list_title_2').css('background', 'white');
			$('#musicList').css('display', 'none');
			$('#list_title_1').css('color', 'white');
			$('#list_title_1').css('background', 'rgb(180, 180, 180)');
		}
	});
    
    $("#like_button").click(function() {
    	
    	if( id != 'null' )
    	{
	    	$.ajax({
	    		url: "PreferenceProc.jsp",
	            type: 'post',
	            async: false,
	            crossDomain: true,
	            data: {
	            	kind: 'artist',
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
	
	$(".musicList_music img, .musicList_music span").click(function() {
    	location.href = "MusicDetail.jsp?music_no=" + $(this).attr("data-no");
    });
    
    $(".musicList_artist span").click(function() {
    	location.href = "ArtistDetail.jsp?artist_no=" + $(this).attr("data-no");
    });
    
    $(".musicList_album").click(function() {
    	location.href = "AlbumDetail.jsp?album_no=" + $(this).attr("data-no");
    });
    
    $(".musicList_lyrics").click(function() {
        // $('#myModal').modal('show');
        $("#lyrics_iframe").attr("src", "Lyrics.jsp?music_no=" + $(this).parent().attr("data-no"));
        $(".btn-primary").trigger('click');
        // $("#lyrics_modal").on("modal", function() {
        //     alert('g');
        // });
    });
});