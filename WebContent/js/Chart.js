var currentClickTop3Index = 0;

$(document).ready(function() {
	
	$(".tab_menu").click(function() {
		var index = $(this).index();
		
		if( index == 0 )			// 실시간
			location.href = "Chart.jsp";
		else if( index == 1 )	// 주간
			location.href = "Chart.jsp?tab_no=1";
		else if( index == 2 )	// 월간
			location.href = "Chart.jsp?tab_no=2";
	});
	
	$("#chart_refresh").click(function() {
		location.reload(true);
	});
	
	
	$(".chart_listen img").on("mouseenter", function() {
		$(this).attr("src", "image/listen_over_icon.png");
	})
	$(".chart_listen img").on("mouseleave", function() {
		$(this).attr("src", "image/listen_icon.png");
	})
	$(".chart_add img").on("mouseenter", function() {
		$(this).attr("src", "image/add_over_icon.png");
	})
	$(".chart_add img").on("mouseleave", function() {
		$(this).attr("src", "image/add_icon.png");
	})
	$(".chart_lyrics img").on("mouseenter", function() {
		$(this).attr("src", "image/lyrics_over_icon.png");
	})
	$(".chart_lyrics img").on("mouseleave", function() {
		$(this).attr("src", "image/lyrics_icon.png");
	})
	
	$("#all_select").click(function() {

		if( $("#page_navi_1").hasClass("current_list") )
		{
			var totalCount = $(".box1_checkbox").length;
			var partCount = $(".box1_checkbox:checked").length;
			
			if( totalCount > partCount )
				$(".box1_checkbox").prop("checked", true);
			else
				$(".box1_checkbox").prop("checked", false);
		}
		else
		{
			var totalCount = $(".box2_checkbox").length;
			var partCount = $(".box2_checkbox:checked").length;
			
			if( totalCount > partCount )
				$(".box2_checkbox").prop("checked", true);
			else
				$(".box2_checkbox").prop("checked", false);
		}
	});
	
	$(".page_navi_area").click(function() {
		var index = $(this).index();
		
		if( index == 0 )
		{
			$(this).addClass("current_list");
			$(".page_navi_area").eq(1).removeClass("current_list");
			$("#chart_box1").css("display", "block");
			$("#chart_box2").css("display", "none");
			$(".box2_checkbox").prop("checked", false);
		}
		else
		{
			$(this).addClass("current_list");
			$(".page_navi_area").eq(0).removeClass("current_list");
			$("#chart_box2").css("display", "block");
			$("#chart_box1").css("display", "none");
			$(".box1_checkbox").prop("checked", false);
		}
	})
	
	$(".chart_lyrics").click(function() {
		// $('#myModal').modal('show');
    	$("#lyrics_iframe").attr("src", "Lyrics.jsp?music_no=" + $(this).parent().attr("id"));
    	$(".btn-primary").trigger('click');
        $("#lyrics_modal").on("modal", function() {
            alert('g');
        });
	});
	
// Graph scripts here
	
	$(".category").click(function() {
		
		changeTop3($(this).index());
		
		// graphData[$(this).index()].color;
	});
	
	var temp1 = [];
	var temp2 = [];
	var temp3 = [];
	
	/*var temp1 = [ [1, 10], [2, 30], [3, 20], [4, 60], [5, 50], [6, 50], [7, 50], [8, 30] ];
	var temp2 = [ [1, 20], [2, 50], [3, 40], [4, 30], [5, 30], [6, 50], [7, 20], [8, 60] ];
	var temp3 = [ [1, 20], [2, 50], [3, 30], [4, 70], [5, 40], [6, 40], [7, 40], [8, 50] ];
	
	for( var i = 0; i < temp1.length; i++ )
	{
		sum = temp1[i][1] + temp2[i][1] + temp3[i][1];
		temp1[i][1] = Math.floor((temp1[i][1] / sum) * 100);
		temp2[i][1] = Math.floor((temp2[i][1] / sum) * 100);
		temp3[i][1] = Math.floor((temp3[i][1] / sum) * 100);
	}*/
	
	var today = new Date();
	var yesterday = new Date(today.valueOf() - (24*60*60*1000));
	
	// alert((new Date(yesterday.getTime() + 1 * 3600000)).getHours());
	//  + 32400000 <- 9시간 추가
	
	for( var i = 0; i < top1Order.length; i++ )
	{
		var sum = top1Order[top1Order.length - 1 - i][3] + top2Order[top1Order.length - 1 - i][3] + top3Order[top1Order.length - 1 - i][3];
		
		// alert(new Date(yesterday.getTime() + (i+1) * 3600000));
		
		temp1.push([yesterday.getTime() + (i+1) * 3600000 + 32400000, Math.floor(top1Order[top1Order.length - 1 - i][3] / sum  * 100)]);
		temp2.push([yesterday.getTime() + (i+1) * 3600000 + 32400000, Math.floor(top2Order[top1Order.length - 1 - i][3] / sum  * 100)]);
		temp3.push([yesterday.getTime() + (i+1) * 3600000 + 32400000, Math.floor(top3Order[top1Order.length - 1 - i][3] / sum  * 100)]);
	
	}
	
	var graphData = [{
		data: temp1,
		color: '#71c73e'
		}, {
			data: temp2,
			color: 'rgb(77, 183, 197)' // '#77b7c5' 
		}, {
			data: temp3,
			color: '#ff0000'
		}
	];
	
	// Lines
	$.plot($('#graph-lines'), graphData, {
	    series: {
	        points: {
	            show: true,
	            radius: 3
	        },
	        lines: {
	            show: true,
	        },
	        shadowSize: 0
	    },
	    grid: {
	        /*color: '#646464',*/
	    	color: 'white',
	        borderColor: 'transparent',
	        borderWidth: 10,
	        hoverable: true
	    },
	    xaxis: {
	        tickColor: 'transparent',
	        mode: "time",
	        tickSize: [1, "hour"],
	        timeformat: '%H',
            min: yesterday.getTime()  + 32400000,
            max: today.getTime()  + 32400000
	    },
	    yaxis: {
	        tickSize: 5
	    }
	});
	
	function showTooltip(x, y, contents) {
	    $('<div id="tooltip">' + contents + '</div>').css({
	        top: y - 16,
	        left: x + 20
	    }).appendTo('body').fadeIn();
	}
	 
	var previousPoint = null;
	 
	$('#graph-lines, #graph-bars').bind('plothover', function (event, pos, item) {
	    if (item) {
	        if (previousPoint != item.dataIndex) {
	            previousPoint = item.dataIndex;
	            $('#tooltip').remove();
	            var x = item.datapoint[0],
	                y = item.datapoint[1];
	                showTooltip(item.pageX, item.pageY, '시간 : ' + (new Date(x - 32400000)).getHours() + "시<br>점유율 : " + y + "%");
	        }
	    } else {
	        $('#tooltip').remove();
	        previousPoint = null;
	    }
	});
});

function changeTab(tabIndex)
{
	$(".tab_menu").eq(tabIndex).addClass("selected_tab_menu");
}
function changeTop3(top3Index)
{
	var colors = ["#71c73e", "#77b7c5", "#ff0000"];
	
	top3Index -= 1;
	
	var short_music_name = (music_name[top3Index].length >= 8)? music_name[top3Index].substring(0, 8) + "...": music_name[top3Index];
	var short_artist_name = (artist_name[top3Index].length >= 8)? artist_name[top3Index].substring(0, 8) + "...": artist_name[top3Index];
	
	$("#rank_num").text((top3Index + 1) + "위");
	$("#rank_num").css("color", colors[top3Index]);
	$("#music_info_area img").attr("src", albumart[top3Index]);
	$("#rank_music_title").text(short_music_name);
	$("#rank_music_artist").text(short_artist_name);
	$("#rank_music_play_count").text(play_count[top3Index]);
}