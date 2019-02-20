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

    $("#profile_image, #creator_name span, #another_playList_header span").click(function() {
    	location.href = "MemberDetail.jsp?id=" + $(this).attr("data-no");
    });
    
    $(".another_playList_img, .another_playList_title").click(function() {
    	location.href = "DJDetail.jsp?playlist_no=" + $(this).attr("data-no");
    });
    
    $(".another_playList_top1_music").click(function() {
    	if( $(this).attr("data-no") == null || $(this).attr("data-no") != "" )
    		location.href = "MusicDetail.jsp?music_no=" + $(this).attr("data-no");
    	else
    		alert('곡이 없습니다.');
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