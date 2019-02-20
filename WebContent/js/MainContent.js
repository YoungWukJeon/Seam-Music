var isChartClick = 1;
var currentIndex = -1;

$(document).ready(function() {
	
    $("#newalbum").click(function() {
        isChartClick = 1;
        $("#newalbum").css('color', "lightgray" );
        $("#allalbum").css('color', "black" );
        $("#internalalbum").css('color', "black" );
        $("#externalalbum").css('color', "black" );
        $(".movebox").animate({ "margin": "-15px 0 0 -120px" }, "slow");
    });
    $("#allalbum").click(function() {
        isChartClick = 2;
        $("#newalbum").css('color', "black" );
        $("#allalbum").css('color', "lightgray" );
        $("#internalalbum").css('color', "black" );
        $("#externalalbum").css('color', "black" );
        $(".movebox").animate({ "margin": "-15px 0 0 -59px" }, "slow");
    });
    $("#internalalbum").click(function() {
        isChartClick = 3;
        $("#newalbum").css('color', "black" );
        $("#allalbum").css('color', "black" );
        $("#internalalbum").css('color', "lightgray" );
        $("#externalalbum").css('color', "black" );
        $(".movebox").animate({ "margin": "-15px 0 0 4" }, "slow");
    });
    $("#externalalbum").click(function() {
        isChartClick = 4;
        $("#newalbum").css('color', "black" );
        $("#allalbum").css('color', "black" );
        $("#internalalbum").css('color', "black" );
        $("#externalalbum").css('color', "lightgray" );
        $(".movebox").animate({ "margin": "-15px 0 0 66px" }, "slow");
    });
    
    $('.album_image img').mouseover(function() {
        var latest_index = $(this).index(".album_image img");
        currentIndex = latest_index;
        $('#album_inform span').empty();
        $('#album_inform img').attr("src", albumart[latest_index]);
        $('#album_inform span').append('앨 범 : '+name2[latest_index]+'<br>');
        $('#album_inform span').append('가 수 : '+artist_name[latest_index]+'<br>');
        $('#album_inform span').append('발매일 : '+release_date[latest_index]+'<br>');
    });
    
    $("#album_more span").click(function() {
    	location.href = "NewMusic.jsp";
    });
    
    $(".album_image").click(function() {
    	location.href = "AlbumDetail.jsp?album_no=" + album_no[$(this).index()];
    });
    
    $("#album_inform").click(function() {
    	if( currentIndex > 0 )
    		location.href = "AlbumDetail.jsp?album_no=" + album_no[currentIndex];
    });
    
    $(".seamdj_image").click(function() {
    	location.href = "DJDetail.jsp?playlist_no=" + $(this).attr("data-no");
    });
});

function init() {
	for( var i = 0; i < name2.length; i++ )
		$(".album_image").eq(i).find("img").attr("src", albumart[i]);
}
