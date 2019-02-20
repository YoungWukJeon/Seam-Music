var filter = null;
var filterValue = null;
var sortType = null;
var id = null;

$(document).ready(function() {
    // $('#vertical').lightSlider({
    //     gallery: true,
    //     item: 1,
    //     vertical: true,
    //     verticalHeight: 295,
    //     vThumbWidth: 50,
    //     thumbItem: 8,
    //     thumbMargin: 4,
    //     slideMargin: 0
    // });

    $("#dj_request").click(function() {
    	
    	if( id != 'null' )
    		$(".btn-primary").trigger('click');
    	else
    	{
    		alert('Seam DJ 가입을 위해서는 로그인이 필요합니다.');
    		parent.$("#login_form")[0].contentWindow.$(".logo_reset").eq(0).focus();
    	}
    });
    
    $("#order_recently").click(function() {
    	if( !$(this).hasClass("selected_order") )
		{
    		$(this).addClass("selected_order");
    		$("#order_like").removeClass("selected_order");
    		location.href = "DJ.jsp?filter=" + filter + "&filterValue=" + filterValue;
		}
    });
    
    $("#order_like").click(function() {
    	if( !$(this).hasClass("selected_order") )
		{
    		$(this).addClass("selected_order");
    		$("#order_recently").removeClass("selected_order");
    		location.href = "DJ.jsp?filter=" + filter + "&filterValue=" + filterValue + "&sortType=preference";
		}
    });
    
    $("#today_main_content_img, #today_main_list_name, .today_sub_content_img, .today_sub_list_name, .dj_list_img, .dj_list_name").click(function() {
    	location.href = 'DJDetail.jsp?playlist_no=' + $(this).attr("data-no");
    });
    
    $(".move_dj").click(function() {
    	location.href = 'MemberDetail.jsp?member_id=' + $(this).attr("data-no");
    })
    

    $(".btn-primary").click(function() {
        // $('#myModal').modal('show');
        $("#regist_iframe").attr("src", "DJRegist.jsp");
        $("#regist_modal").on("modal", function() {
            alert('g');
        });
    });

    $("#dj_regist_btn").click(function() {
    	$("#regist_iframe")[0].contentWindow.$('#submit_btn').trigger('click');
    });
    
    $("#search_text").keyup(function () {
    	
    	if( event.keyCode == 13 )	// 검색에서 enter 키 입력
    		$("#search_button").trigger("click");
    });
    
    $("#search_button").click(function() {
    	if( $("#search_text").val().trim().length == 0 )
    		location.href = "DJ.jsp";
    	else
    	{
    		filter = $("#search_select").val();
    		filterValue = $("#search_text").val().trim();
    		location.href = "DJ.jsp?filter=" + filter + "&filterValue=" + filterValue;
    	}
    });
});

function registHide(result) {
	
	if( result == 'success' )
		location.reload(true);
	else
		$(".modal-footer button").eq(1).trigger('click');
}