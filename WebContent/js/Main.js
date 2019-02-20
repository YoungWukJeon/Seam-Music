var isPlaying = false;
var isSearchOn = false;
var isMenuOn = 0;
var playing_interval;
var currentPlayTime = 0;
var currentVolume = 0.2;
var duration;
var slider;
var player;
var isPlayerMode = false;
var isVolumeSet = false;
var isWebListMenu = false;
var isMobilePlayer = false;
var lyrics;
var islyrics = false;
var islyricsView = false;
var isLoopState = 1;
var isEnded = false;
var currentPlaySongIndex = 0;
var currentSelectedSongIndex = 0;
/*******들은시간계산용********/
var firstPlayTime = 0;
var lastPlayTime = 0;
var sumPlayTime = 0;
/*************************/
var playOrder;
var totalPlayTime = 0;
var isFirst = true;
var isM_nav = false;
var songname;
var times;
var lyrics;
/***********************/

$(document).ready(function() {
    
    contentResize();
    headerResize();
    lyrics_play()

    player = document.getElementsByTagName('audio')[0];
    player.volume = currentVolume;
    
    

    $('audio').on("loadeddata", function() {

        duration = Math.floor(this.duration);

        $("#song_current_time").text("0:00");
        $("#song_total_time").text(getTimeFormat(log_playtime()));
        $(".song_item_name").css("font-weight", "");
        $(".song_item_name").eq(currentPlaySongIndex).css("font-weight", "bold");
        $(".song_item_name").css("font-size", "10pt");
        $(".song_item_name").eq(currentPlaySongIndex).css("font-size", "10pt");

        if (isFirst) {
            slider = $("#song_progress input");

            rangeSlider.create(slider, {
                polyfill: true,
                rangeClass: 'rangeSlider',
                disabledClass: 'rangeSlider--disabled',
                fillClass: 'rangeSlider__fill',
                bufferClass: 'rangeSlider__buffer',
                handleClass: 'rangeSlider__handle',
                startEvent: ['mousedown', 'touchstart', 'pointerdown'],
                moveEvent: ['mousemove', 'touchmove', 'pointermove'],
                endEvent: ['mouseup', 'touchend', 'pointerup'],
                min: 0,
                max: log_playtime() * 2,
                step: 1,
                value: 0,
                buffer: 0,
                borderRadius: 10,
                onInit: function() {},
                onSlideStart: function(position, value) {},
                onSlide: function(position, value) {
                    currentPlayTime = (position % 2 == 0) ? position : (position + 1);
                    $("#song_current_time").text(getTimeFormat(currentPlayTime / 2));
                },
                onSlideEnd: function(position, value) {
                    /*************************************************************/
                    sumPlayTime += Math.abs(firstPlayTime - player.currentTime);
                    player.currentTime = currentPlayTime / 2;
                    firstPlayTime = player.currentTime;
                    /*************************************************************/
                }
            });
            isFirst = false;
        } else {
            var inputRange = document.getElementById("song_progress_bar");
            inputRange.rangeSlider.update({
                value: currentPlayTime,
                max: log_playtime() * 2 }, false);
            player.play();
        }
        lyrics_play();
    });

    $('audio').on("play", function() {
        playing_interval = setInterval(function() {
            if (currentPlayTime <= log_playtime() * 2) {
                if (currentPlayTime % 2 == 0)
                    $("#song_current_time").text(getTimeFormat(currentPlayTime / 2));
                var inputRange = document.getElementById("song_progress_bar");
                inputRange.value = currentPlayTime;
                inputRange.max = log_playtime() * 2;
                inputRange.dispatchEvent(new Event('change'));
            }
            currentPlayTime++;
            if(logstate == "") {
                if(currentPlayTime >= 80) {
                    audion_end();
                }
            }
        }, 500);
    });

    $('audio').on("timeupdate", function() {
        check();
    });

    $('audio').on("pause", function() {
        clearInterval(playing_interval)
    });

    $('audio').on("ended", function() {
        audion_end();
    });
    /********************************* *logo_click ****************************/
    $('#logo').click(function() {
        $('.logo_reset').val('');
    });
    /********************************* *current_click ****************************/
    $('#song_current').click(function() {
        if (!isPlaying) {
            isPlaying = true;
            $(this).find('img').attr('src', 'image/pause_icon.png');
            player.play();
        } else {
            isPlaying = false;
            $(this).find('img').attr('src', 'image/play_icon.png');
            player.pause();
        }
    });
    /********************************* *pre_click ****************************/
    $('#song_pre').click(function() {
        currentPlaySongIndex--;
        if(isLoopState == 1 && currentPlaySongIndex == -1) {
            currentPlaySongIndex = name2.length-1;
        }
        $(".song_item").eq(currentPlaySongIndex).trigger('dblclick');
    });
    /********************************* *next_click ****************************/
    $('#song_next').click(function() {
        currentPlaySongIndex++;
        if(isLoopState == 1 && currentPlaySongIndex == name2.length) {
            currentPlaySongIndex = 0;
        }
        $(".song_item").eq(currentPlaySongIndex).trigger('dblclick');
    });
    /********************************* *volume_click ****************************/
    $('#song_volume').click(function() {
        if (!isVolumeSet) {
            isVolumeSet = true;
            $("#volumeset").stop().animate({"top": ($(window).height() - 190) + "px"}, 'fast');
            if(isWebListMenu) {
                $("#web_listmenu").stop().animate({ "left": "+=285px" }, "fast");
                isWebListMenu = false;
            }
        } else {
            isVolumeSet = false;
            $("#volumeset").stop().animate({"top": "100%"}, 'fast');
        }
    });

    /******************************* *click_loop *********************************** */
    $("#song_loop").click(function() {
        if (isLoopState == 1) // loop_all
        {
            isLoopState = 2;
            $(this).find("img").attr("src", "image/loop_one.png");
        } else if (isLoopState == 2){ // loop_one
            isLoopState = 3;
            $(this).find("img").attr("src", "image/loop_none.png");
        } else if (isLoopState == 3){ // loop_none
            isLoopState = 4;
            $(this).find("img").attr("src", "image/shuffle_icon.png");
        } else if (isLoopState == 4){ // shuffle
            isLoopState = 1;
            $(this).find("img").attr("src", "image/loop_all.png");
        }
    });
    /******************************* *click_lyrics *********************************** */
    $("#song_lyrics").click(function() {
        if(!islyricsView) {
            $('#lyrics_box').stop().animate({ "top": "80px" }, "fast");
            islyricsView = true;
            if(isVolumeSet) {
                isVolumeSet = false;
                $("#volumeset").stop().animate({"top": "100%"}, 'fast');
            }
            if(isWebListMenu) {
                $("#web_listmenu").stop().animate({ "left": "+=285px" }, "fast");
                isWebListMenu = false;
            }
        } else {
            $('#lyrics_box').stop().animate({ "top": "100%" }, "fast");
            islyricsView = false;
        }
    });
    /******************************* *click_song_item *********************************** */
    $(".song_item").click(function() {
        currentSelectedSongIndex = $(this).index(".song_item");
        $(".song_item").css("background-color", "");
        $(this).css("background-color", "rgb(100, 100, 100)");

        if (currentSelectedSongIndex == currentPlaySongIndex) {
            $(".song_item_name").css("font-weight", "");
            $(".song_item_name").css("font-size", "10pt");
        } else {
            $(".song_item_name").eq(currentPlaySongIndex).css("font-weight", "bold");
            $(".song_item_name").eq(currentPlaySongIndex).css("font-size", "10pt");
        }
    });
    /******************************* *dblclick_song_item *********************************** */
    $(".song_item").dblclick(function() {
    	/***************************************************************************/
    	lastPlayTime = player.currentTime;
    	sumPlayTime += lastPlayTime - firstPlayTime;
    	
    	var tempIndex = (isEnded)? currentPlaySongIndex - 1: currentPlaySongIndex;
    	isEnded = false;
    	
    	if( sumPlayTime >= 3 )
    	{
    		$.ajax({
    		    type: "POST",
    		    url: "MusicHistoryProc.jsp",
    		    processData: false,
    		    dataType: "text",
    		    data: "music_no=" + music_no[tempIndex] + "&name=" + name2[tempIndex] + "&playTime=" + Math.floor(sumPlayTime),
    		    success: function(text) {}
    		});
    	}
    	currentPlaySongIndex = $(this).index(".song_item");
    	firstPlayTime = 0;
    	lastPlayTime = 0;
    	sumPlayTime = 0;
    	/***************************************************************************/
        clearInterval(playing_interval);
        currentPlayTime = 0;
        var inputRange = document.getElementById("song_progress_bar");
        inputRange.value = currentPlayTime;

        inputRange.dispatchEvent(new Event('change'));

        $(".song_item_name").css("font-weight", "");
        $(".song_item_name").eq(currentPlaySongIndex).css("font-weight", "bold");
        $(".song_item_name").css("font-size", "10pt");
        $(".song_item_name").eq(currentPlaySongIndex).css("font-size", "10pt");

        if(!isPlaying) {
            isPlaying = true;
            $('#song_current').find('img').attr('src', 'image/pause_icon.png');
        }

        if (currentSelectedSongIndex == currentPlaySongIndex) {
            $(".song_item_name").css("font-weight", "");
            $(".song_item_name").css("font-size", "10pt");
        } else {
            $(".song_item_name").eq(currentPlaySongIndex).css("font-weight", "bold");
            $(".song_item_name").eq(currentPlaySongIndex).css("font-size", "10pt");
        }

        var tempStr = "<span class=slash>&nbsp;<br></span>" +
            "<span class=info_singer></span>";

        $("#song_info").empty();
        $("#song_info").append(tempStr);

        $("#song_albumart img").attr("src", albumart[currentPlaySongIndex]);
        $('#background_image img').attr('src', albumart[currentPlaySongIndex]);
        $('#lyrics_albumart img').attr('src', albumart[currentPlaySongIndex]);
        $('#song_player .playbox_album img').attr('src', albumart[currentPlaySongIndex]);
        $('#m_playbox .playbox_music span').empty();
        $('#m_playbox .playbox_music span').prepend(name2[currentPlaySongIndex]);
        $('#m_playbox .playbox_singer span').empty();
        $('#m_playbox .playbox_singer span').prepend(artist_name[currentPlaySongIndex]);
        $("#lyrics_music").empty();
        $("#lyrics_singer").empty();
        if(name2[currentPlaySongIndex].length > 12) {
            $("#lyrics_music").prepend(name2[currentPlaySongIndex].substring(0,12) + "...");
        } else {
            $("#lyrics_music").prepend(name2[currentPlaySongIndex]);
        }
        if ($(window).outerWidth(true) <= 768) {
            if(name2[currentPlaySongIndex].length > 8) {
                $("#song_info .slash").prepend(name2[currentPlaySongIndex].substring(0,8) + "...");
            } else {
                $("#song_info .slash").prepend(name2[currentPlaySongIndex]);
            }
            if(artist_name[currentPlaySongIndex].length > 8) {
                $("#song_info .info_singer").prepend(artist_name[currentPlaySongIndex].substring(0,8) + "...");
            } else {
                $("#song_info .info_singer").prepend(artist_name[currentPlaySongIndex]);
            }
        } else {
                $("#song_info .slash").prepend(name2[currentPlaySongIndex]);
                $("#song_info .info_singer").prepend(artist_name[currentPlaySongIndex]);
                if(name2[currentPlaySongIndex].length > 8) {
                    $("#playbox_current").find(".playbox_music").find("span").find("b").text(name2[currentPlaySongIndex].substring(0,8) + "...");
                } else {
                    $("#playbox_current").find(".playbox_music").find("span").find("b").text(name2[currentPlaySongIndex]);
                }
                if(artist_name[currentPlaySongIndex].length > 8) {
                    $("#playbox_current").find(".playbox_singer").find("span").find("b").text(artist_name[currentPlaySongIndex].substring(0,8) + "...");
                } else {
                    $("#playbox_current").find(".playbox_singer").find("span").find("b").text(artist_name[currentPlaySongIndex]);
                }
        }
        $("#lyrics_singer").prepend(artist_name[currentPlaySongIndex]);

        $('audio source#audio_main').attr('src', $('audio source').eq(currentPlaySongIndex + 1).attr('src'));
        
        $("#playbox_current").find(".playbox_album").find("img").attr("src", albumart[currentPlaySongIndex]);
        if(currentPlaySongIndex > 1) {
            for(var num = 1; num <= 2; num++) {
                $("#playbox_pre"+num).find(".playbox"+num+"_album").find("img").attr("src", albumart[currentPlaySongIndex - num]);
                $("#playbox_pre"+num).find(".playbox"+num+"_music").find("span").find("b").text(name2[currentPlaySongIndex - num]);
                $("#playbox_pre"+num).find(".playbox"+num+"_singer").find("span").find("b").text(artist_name[currentPlaySongIndex - num]);    
            }
        } else if(currentPlaySongIndex == 1) { 
            $("#playbox_pre2").find(".playbox2_album").find("img").attr("src", 'image/default.png');
            $("#playbox_pre2").find(".playbox2_music").find("span").find("b").text('');
            $("#playbox_pre2").find(".playbox2_singer").find("span").find("b").text('');
            
            $("#playbox_pre1").find(".playbox1_album").find("img").attr("src", albumart[currentPlaySongIndex - 1]);
            $("#playbox_pre1").find(".playbox1_music").find("span").find("b").text(name2[currentPlaySongIndex - 1]);
            $("#playbox_pre1").find(".playbox1_singer").find("span").find("b").text(artist_name[currentPlaySongIndex - 1]);
        } else {
            for(var num = 1; num <= 2; num++) {
                $("#playbox_pre"+num).find(".playbox"+num+"_album").find("img").attr("src", 'image/default.png');
                $("#playbox_pre"+num).find(".playbox"+num+"_music").find("span").find("b").text('');
                $("#playbox_pre"+num).find(".playbox"+num+"_singer").find("span").find("b").text('');    
            }
        }

        if((name2.length-2) > currentPlaySongIndex) {
            for(var num = 1; num <= 2; num++) {
                $("#playbox_next"+num).find(".playbox"+num+"_album").find("img").attr("src", albumart[currentPlaySongIndex + num]);
                $("#playbox_next"+num).find(".playbox"+num+"_music").find("span").find("b").text(name2[currentPlaySongIndex + num]);
                $("#playbox_next"+num).find(".playbox"+num+"_singer").find("span").find("b").text(artist_name[currentPlaySongIndex + num]);    
            }
        } else if ((name2.length-2) == currentPlaySongIndex) {
            $("#playbox_next1").find(".playbox1_album").find("img").attr("src", albumart[currentPlaySongIndex + 1]);
            $("#playbox_next1").find(".playbox1_music").find("span").find("b").text(name2[currentPlaySongIndex + 1]);
            $("#playbox_next1").find(".playbox1_singer").find("span").find("b").text(artist_name[currentPlaySongIndex + 1]);
            
            $("#playbox_next2").find(".playbox2_album").find("img").attr("src", 'image/default.png');
            $("#playbox_next2").find(".playbox2_music").find("span").find("b").text('');
            $("#playbox_next2").find(".playbox2_singer").find("span").find("b").text('');
        } else {
            for(var num = 1; num <= 2; num++) {
                $("#playbox_next"+num).find(".playbox"+num+"_album").find("img").attr("src", 'image/default.png');
                $("#playbox_next"+num).find(".playbox"+num+"_music").find("span").find("b").text('');
                $("#playbox_next"+num).find(".playbox"+num+"_singer").find("span").find("b").text('');    
            }
        }
        if(isLoopState == 4) { shuffle(); }
        player.load();
    });
    /********* ****************************************************************************************** **********/

    /************* navi ************/
    $(".m_btnmenu").click(function() {
        if(!isM_nav) {
            $("nav").stop().animate({ "left": "+=200px" }, "slow");
            isM_nav = true;
            if(isWebListMenu){
                $("#web_listmenu").stop().animate({ "left": "+=260px" }, "slow");
                isWebListMenu = false;
            }
        } else {
            $("nav").stop().animate({ "left": "-=200px" }, "slow");
            isM_nav = false;
        }
    });

    $(".listmenu").click(function() {
        if ($(window).outerWidth(true) <= 768) {
            if (!isWebListMenu) {
                $("#web_listmenu").stop().animate({ "left": "-=260px" }, "slow");
                isWebListMenu = true;
            } else {
                $("#web_listmenu").stop().animate({ "left": "+=260px" }, "slow");
                isWebListMenu = false;
            }
            if(isM_nav) {
                $("nav").stop().animate({ "left": "-=200px" }, "slow");
                isM_nav = false;
            }
        } else {
            if (!isWebListMenu) {
                $("#web_listmenu").stop().animate({ "left": "-=285px" }, "fast");
                isWebListMenu = true;
                if(islyricsView) {
                    $('#lyrics_box').stop().animate({ "top": "100%" }, "fast");
                    islyricsView = false;
                }
                if(isVolumeSet) {
                    isVolumeSet = false;
                    $("#volumeset").stop().animate({"top": "100%"}, 'fast');
                }
            } else {
                $("#web_listmenu").stop().animate({ "left": "+=285px" }, "fast");
                isWebListMenu = false;
            }
        }
    });

    if ($(window).outerWidth(true) <= 768) {
        $("#song_info").click(function() {
            if(!isMobilePlayer) {
                if(isM_nav) {
                    $('.m_btnmenu').trigger('click'); //here
                }
                $("#song_player").stop().animate({ "top": "-=100%" }, "slow");
                $("#m_playbox").toggle();
                $("#song_info").toggle();
                $("#song_progress").show(1000);
                $("#song_time").show(1000);
                $("#song_loop").show(1000);
                $("#song_volume").show(1000);
                $("#song_pre").stop().animate({ "left": "-=17%" }, "slow");
                $("#song_current").stop().animate({ "left": "-=17%" }, "slow");
                $("#song_next").stop().animate({ "left": "-=17%" }, "slow");
                isMobilePlayer = true;
            }
        });   
    }
    $("#song_playerclose").click(function() {
        $("#song_player").stop().animate({ "top": "+=100%" }, "slow");
        $("#m_playbox").toggle();
        $("#song_info").toggle("slow");
        $("#song_progress").hide();
        $("#song_time").hide();
        $("#song_loop").hide();
        $("#song_volume").hide();
        $("#song_pre").stop().animate({ "left": "+=17%" }, "slow");
        $("#song_current").stop().animate({ "left": "+=17%" }, "slow");
        $("#song_next").stop().animate({ "left": "+=17%" }, "slow");
        isMobilePlayer = false;
    });

    /*************************playermode***************************/
    $(".playbox").hide();
    $(".playbox_side1").hide();
    $(".playbox_side2").hide();
    $("#mode").click(function() {
        if (!isPlayerMode) {
            // 추가~ //
            $('#mode').css('pointer-events', 'none');
            // ~추가 //
            $("#modebutton").animate({ "left": "-=40%" }, "slow");
            $("#modebox").css('background-color', "rgb(251, 59, 64)");
            $("footer").stop().animate({ "top": "82px" }, "slow");
            $("footer").css('background-color', "rgba(150, 150, 150, 1)");
            $("footer").css('z-index', '0');

            $("#song_info").hide();
            $(".playbox").toggle();
            $(".playbox_side1").toggle();
            $(".playbox_side2").toggle();
            $("#song_time").stop().animate({ "top": "50%", "left": "50%", "margin": "190px 0 0 210px" }, "slow");
            if($(window).outerWidth(true) <= 1100) {
            	$("#song_progress").stop().animate({ "top": "50%", "left": "250px", "margin": "170px 0 0 0" }, "slow");
            	$('#song_current_time').stop().animate({ "top": "50%", "left": "190px", "margin": "170px 0 0 0" }, "slow");
            	$('#song_total_time').stop().animate({ "top": "50%", "left": ($(window).width() - 250)+ "px", "margin": "170px 0 0 0" }, "slow");
            } else {
            	$("#song_progress").stop().animate({ "top": "50%", "left": "365px", "margin": "170px 0 0 0" }, "slow");
            	$('#song_current_time').stop().animate({ "top": "50%", "left": "305px", "margin": "170px 0 0 0" }, "slow");
            	$('#song_total_time').stop().animate({ "top": "50%", "left": ($(window).width() - 365)+ "px", "margin": "170px 0 0 0" }, "slow");
            }
            
            $("#footer_buttonbox").stop().animate({ "top": "50%", "left": "50%", "margin": "190px 0 0 80px" }, "slow");
            $("#footer_buttonbox2").stop().animate({ "top": "50%", "left": "50%", "margin": "200px 0 0 -70px" }, "slow");
            $("#song_menu").stop().animate({ "top": ($(window).height() - 130) + "px" }, "slow");

            $("#playbox_pre1").delay(750).animate({ "left": "-=231px" }, "slow");
            $("#playbox_next1").delay(750).animate({ "left": "+=231px" }, "slow");
            $("#playbox_pre2").delay(750).animate({ "left": "-=231px" }, "slow");
            $("#playbox_next2").delay(750).animate({ "left": "+=231px" }, "slow");
            $("#playbox_pre2").animate({ "left": "-=190px" }, "slow");
            $("#playbox_next2").animate({ "left": "+=190px" }, "slow");

            if(isWebListMenu) {
                isWebListMenu = false;
                $("#web_listmenu").stop().animate({ "left": "+=285px" }, "fast");
            }
            if(isVolumeSet) {
                isVolumeSet = false;
                $("#volumeset").stop().animate({"top": "100%"}, 'fast');
            }
            if(islyricsView) {
                islyricsView = false;
                $('#lyrics_box').stop().animate({ "top": "100%" }, "fast");
            }
            isPlayerMode = true;
            // 추가~ //
            setTimeout(function() {
            $('#mode').css('pointer-events', 'auto'); 
            }, 2000);
            // ~추가 //
        } else {
            $("#modebutton").animate({ "left": "+=40%" }, "slow");
            $("#modebox").css('background-color', "lightgray");
            $("footer").stop().animate({ "top": ($(window).height() - 60) + "px" }, "slow");
            $("footer").css('background-color', "rgba(75, 50, 50, 0.5)");
            $("footer").css('z-index', '3');
            
            $(".playbox").toggle();
            $(".playbox_side1").toggle();
            $(".playbox_side2").toggle();
            $("#song_time").stop().animate({ "top": "40px", "left": "700px", "margin": "0 0 0 0" }, "slow");
            if($(window).outerWidth(true) <= 1100) {
                $("#song_progress").css("width", ($(window).outerWidth(true) - 500) + "px");
                $("#song_progress").stop().animate({ "top": "20px", "left": "230px", "margin": "0 0 0 0" }, "slow");
                $('#song_current_time').stop().animate({ "top": "22px", "left": "170px", "margin": "0 0 0 0" }, "slow");
            } else {
                $("#song_info").show();
                $("#song_progress").css("width", ($(window).outerWidth(true) - 730) + "px");  //-----//
                $("#song_progress").stop().animate({ "top": "20px", "left": "460px", "margin": "0 0 0 0" }, "slow");
                $('#song_current_time').stop().animate({ "top": "22px", "left": "400px", "margin": "0 0 0 0" }, "slow");
            }
            $("#footer_buttonbox").stop().animate({ "top": "0", "left": ($(window).outerWidth(true) - 220) + "px", "margin": "0 0 0 0" }, "slow");
            $("#footer_buttonbox2").stop().animate({ "top": "8px", "left": "20px", "margin": "0 0 0 0" }, "slow");
            $("#song_menu").stop().animate({ "top": "12px" }, "slow");
            $("#song_total_time").stop().animate({ "top": "22px", "left": ($(window).outerWidth(true) - 270) + "px", "margin": "0 0 0 0" }, "slow");

            $("#playbox_pre1").css('left', '50%');
            $("#playbox_next1").css('left', '50%');
            $("#playbox_pre2").css('left', '50%');
            $("#playbox_next2").css('left', '50%');

            isPlayerMode = false;
        }
    });

    /**************** sidemenu ****************/

    $("#m_menu_chart").hide();
    $("#m_menu_radio").hide();
    $("#m_menu_seamdj").hide();

    $(".m_btnlogo").click(function() {
        if (isMenuOn != 0) {
            $("#m_menu_chart").hide();
            $("#m_menu_radio").hide();
            $("#m_menu_seamdj").hide();
            $("article").stop().animate({ "top": "-=50px" }, "slow");
            $('article').css('height', ($(window).height() - 133) + "px");
            $(window).resize(function() {
                $('article').css('height', ($(window).height() - 133) + "px");
            });
            isMenuOn = 0;
        }
    });
    $("#m_sidemenu_chart").click(function() {
        if (isMenuOn == 0) {
            $("#m_menu_chart").show();
            $('article').css('top', "113px");
            $('article').css('height', ($(window).height() - 183) + "px");
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
            $(window).resize(function() {
                $('article').css('height', ($(window).height() - 183) + "px");
            });
        } else {
            $("#m_menu_radio").hide();
            $("#m_menu_seamdj").hide();
            $("#m_menu_chart").show();
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
        }
        isMenuOn = 1;
    });
    $("#m_sidemenu_radio").click(function() {
        if (isMenuOn == 0) {
            $("#m_menu_radio").show();
            $('article').css('top', "113px");
            $('article').css('height', ($(window).height() - 183) + "px");
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
            $(window).resize(function() {
                $('article').css('height', ($(window).height() - 183) + "px");
            });
        } else {
            $("#m_menu_seamdj").hide();
            $("#m_menu_chart").hide();
            $("#m_menu_radio").show();
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
        }
        isMenuOn = 2;
    });
    $("#m_sidemenu_seamdj").click(function() {
        if (isMenuOn == 0) {
            $("#m_menu_seamdj").show();
            $('article').css('top', "113px");
            $('article').css('height', ($(window).height() - 183) + "px");
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
            $(window).resize(function() {
                $('article').css('height', ($(window).height() - 183) + "px");
            });
        } else {
            $("#m_menu_chart").hide();
            $("#m_menu_radio").hide();
            $("#m_menu_seamdj").show();
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
        }
        isMenuOn = 3;
    });
    $("#m_sidemenu_mypage").click(function() {
        if (isMenuOn != 0) {
            $("#m_menu_chart").hide();
            $("#m_menu_radio").hide();
            $("#m_menu_seamdj").hide();
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
            $('article').css('top', "63px");
            $('article').css('height', ($(window).height() - 133) + "px");
            $(window).resize(function() {
                $('article').css('height', ($(window).height() - 133) + "px");
            });
            isMenuOn = 0;
        } else {
            $("#sidemenu").stop().animate({ "left": "-=100%" }, "slow");
        }
    });

    /****************** footer ******************/

    /*************** search ******************/

    $(".m_btnsearch").click(function() {
        if (!isSearchOn) {
            isSearchOn = true;
            $("#m_searchbox").stop().animate({ opacity: 0 }, 0);
            $("#m_searchbox").stop().animate({ opacity: 1, "left": "-=80%" }, "slow");
        } else {
            isSearchOn = false;
            $("#m_searchbox").stop().animate({ opacity: 1 }, 0);
            $("#m_searchbox").stop().animate({ opacity: 0, "left": "+=80%" }, "slow");
        }
    });

    $("#tag_lyrics").click(function() {
        $(".m_lyrics_box").stop().animate({ "top": "50px" }, "fast");
    });
    $("#m_lyrics_close").click(function() {
        $(".m_lyrics_box").stop().animate({ "top": "90%" }, "fast");
    });
    
    $("#search input[type='image']").click(function() {
    	$("article iframe").attr("src", "Search.jsp?filter=all&filterValue=" + $(this).siblings("input[type='text']").val());
    });
    
    $("#search input[type='text']").keyup(function() {
    	if( event.keyCode == 13 )	// 검색에서 enter 키 입력
    		$("article iframe").attr("src", "Search.jsp?filter=all&filterValue=" + $(this).val());
    });

    /******************************** *click_join **************************** */
    $('#membership').click(function() {
        $('#join').show();
    });
    
    /*************** *volume ******************/
    $('#volume_progress_bar').attr({
        min: 0,
        max: 1,
        step: 0.1,
        value: currentVolume
    });
    $('#volume_progress_bar').change(function(){
            currentVolume = this.value;
            player.volume = currentVolume;
            if(currentVolume == 0) {
                $('#song_volume img').attr("src", 'image/mute_icon.png');
            } else {
                $('#song_volume img').attr("src", 'image/volume_icon.png');
            }
    });
    
    /**************** 추가~ ****************/
    $("#menu_radio").click(function() {
        $('#radio_dialog').show();
        $('#regist_dialog').hide();
        $('#pay_dialog').hide();
        registShow();
        
	});
    /**************** 추가~ ****************/
    
    $("#pay_btn").click(function() {
    	$("#pay_iframe")[0].contentWindow.$('#submit_btn').trigger('click');
    });
    
});

function registShow() {
    isPlaying = false;
    $('#song_current').find('img').attr('src', 'image/play_icon.png');
    player.pause();
	$(".btn-primary").trigger('click');
}

function registHide() {
	$(".modal-footer button").trigger('click');
}
/********* ****************************************************************************************** **********/
function contentResize() {
    $("#playermode").css("height", ($(window).outerHeight(true) - 175) + "px");
    $("#playermode").css("top", ($(window).outerHeight(true) - 80) + "px");
    if(!isWebListMenu) {
        $('aside').css('left', "100%");
    } else {
        $('aside').css('left', ($(window).outerWidth(true) - 260) + "px");
    }
}

function headerResize() {
    if ($(window).outerWidth(true) <=768) {
        $("article").css("left", "0");
        $("article").css("width", "100%");
        if (isMenuOn == 0) {
            $('article').css('height', ($(window).outerHeight(true) - 133) + "px");
        } else {
            $('article').css('height', ($(window).outerHeight(true) - 183) + "px");
        }
        $("footer").css("top", ($(window).outerHeight(true) - 70) + "px");
        $('footer').css('height', "70px");
        $("#song_progress").hide();
        $('.mobile').show();

        $('#web_listmenu').css('height',($(window).outerHeight(true) - 133) + "px");
        $('background_image').hide();
        isM_nav = false;
    } else {
        $("#logo").css("left", "600px");
        $("#search").css("left", "1150px");

        $("nav").css("height", ($(window).outerHeight(true) - 140) + "px");
        $("nav").css("left", "0");

        $("article").css("left", "200px");
        $("article").css("width", ($(window).outerWidth(true) - 200) + "px");
        $("article").css("height", ($(window).outerHeight(true)  - 140) + "px");
        $("article iframe").css("width", "1050px");

        $('aside').css('height', ($(window).height() - 140) + "px");

        $("footer").css("height", ($(window).outerHeight(true) - 82) + "px");
        $("#song_progress").show();
        $("footer").css("top", ($(window).outerHeight(true) - 60) + "px");
        if(isPlayerMode) {
            $('#mode').trigger('click');
        } else {
            $("#playbox_pre1").css('left', '50%');
            $("#playbox_next1").css('left', '50%');
            $("#playbox_pre2").css('left', '50%');
            $("#playbox_next2").css('left', '50%');
            $('#song_info').show();
        }
        $('#song_current_time').css("left", "400px");
        $("#song_progress").css("left", "460px");
        $("#song_progress").css("width", ($(window).outerWidth(true) - 730) + "px");
        $('#song_total_time').css("left", ($(window).outerWidth(true) - 270) + "px");
        $("#footer_buttonbox").css("left", ($(window).outerWidth(true) - 220) + "px");

        $('#menu_chart').show();
        $('#menu_radio').show();
        $('#menu_seamdj').show();
        $('#menu_mypage').show();
        $('nav').show();

        if($(window).outerWidth(true) <= 1100) {
            $('#song_info').hide();
            $('#song_current_time').css("left", "170px");
            $("#song_progress").css("left", "230px");
            $("#song_progress").css("width", ($(window).outerWidth(true) - 500) + "px");
        }
        if($(window).outerWidth(true) > 1350){
            $("#logo").css("left", "50%");
            $("#search").css("left", "92%");
            $("article iframe").css("width", "100%");
        }
        if($(window).outerHeight(true) < 560) {
            $('#menu_mypage').hide();
        }
        if($(window).outerHeight(true) < 500) {
            $('#menu_seamdj').hide();
        }
        if($(window).outerHeight(true) < 460) {
            $('#menu_radio').hide();
        }
        if($(window).outerHeight(true) < 400) {
            $('#menu_chart').hide();
            $('nav').hide();
        }
    }
}

function getTimeFormat(val) {
    var minute = Math.floor(val / 60);
    var second = val % 60;

    if (val % 60 < 10)
        second = '0' + (val % 60);
    else
        second = '' + (val % 60);

    return (minute + ":" + second);
}

function shuffle() {
    var tempOrder = new ArrayList();
    var temp = playOrder.get(currentPlaySongIndex);

    var len = playOrder.size();
    
    for( var i = 0; i < len; i++ )
    {
        var randomIndex = Math.floor(Math.random() * playOrder.size());
        if(temp == playOrder.get(randomIndex)) {
            currentPlaySongIndex = i;
        }
        tempOrder.add(playOrder.get(randomIndex));
        playOrder.remove(randomIndex);
    }
    // for(var i = 0; i < len; i++) {
    //     alert(tempOrder.get(i))
    // }
    playOrder = tempOrder;
}

function log_playtime() {
    var log_playtime;
    if(logstate == "") { log_playtime = 40; }
    else { log_playtime = duration; }

    return log_playtime;
}

function audion_end() {
    isEnded = true;
    if(isLoopState != 2) { currentPlaySongIndex++; }
    if(isLoopState == 1 && currentPlaySongIndex == name2.length) {
        currentPlaySongIndex = 0;
    }
    if(isLoopState == 3 && currentPlaySongIndex == name2.length) { }
    else { $('.song_item').eq(currentPlaySongIndex).trigger('dblclick'); }
}

function init() {
    playOrder = new ArrayList();
    
    for (var i = 0; i < name2.length; i++) {
        songname = "";
        
        playOrder.add(i);
        
        if (name2[i].length > 13)
            songname = name2[i].substr(0, 13) + "...";
        else
            songname = name2[i];

        var tempStr = "<div class=song_item>" +
            "<div class=song_item_no>" + (i + 1) + "</div>" +
            "<div class=song_item_name>" + songname + "</div>" +
            "<div class=song_item_time>" + getTimeFormat(time[i]) + "</div>" +
            "</div>";

        $("#song_list").append(tempStr);
        
        totalPlayTime += Number(time[i]);

        $("audio").append("<source src=audio/" + music_no[i] + ".mp3>");
    }
    var tempHour = Math.floor(totalPlayTime / 3600);
    var tempMinute = Math.floor((totalPlayTime - tempHour * 60) / 60);
    var tempSecond = ((totalPlayTime - tempHour * 60) - tempMinute * 60) % 60;

    var totalTime = "";

    if (tempHour < 10)
    	totalTime += "0" + tempHour + ":";
    else
    	totalTime += tempHour + ":";
    if (tempMinute < 10)
    	totalTime += "0" + tempMinute + ":";
    else
    	totalTime += tempMinute + ":";
    if (tempSecond < 10)
    	totalTime += "0" + tempSecond;
    else
    	totalTime += tempSecond;

    $("#total_time").append(name2.length + "곡 " + totalTime);
    $("#song_albumart img").attr("src", albumart[currentPlaySongIndex]);
    $('#background_image img').attr('src', albumart[currentPlaySongIndex]);
    $('#lyrics_albumart img').attr('src', albumart[currentPlaySongIndex]);
    $('#song_player .playbox_album img').attr('src', albumart[currentPlaySongIndex]);
    $('#m_playbox .playbox_music span').empty();
    $('#m_playbox .playbox_music span').prepend(name2[currentPlaySongIndex]);
    $('#m_playbox .playbox_singer span').empty();
    $('#m_playbox .playbox_singer span').prepend(artist_name[currentPlaySongIndex]);
    $("#lyrics_music").empty();
    $("#lyrics_singer").empty();
    if(name2[currentPlaySongIndex].length > 12) {
        $("#lyrics_music").prepend(name2[currentPlaySongIndex].substring(0,12) + "...");
    } else {
        $("#lyrics_music").prepend(name2[currentPlaySongIndex]);
    }
    if ($(window).outerWidth(true) <= 768) {
        if(name2[currentPlaySongIndex].length > 8) {
            $("#song_info .slash").prepend(name2[currentPlaySongIndex].substring(0,8) + "...");
        } else {
            $("#song_info .slash").prepend(name2[currentPlaySongIndex]);
        }
        if(artist_name[currentPlaySongIndex].length > 8) {
            $("#song_info .info_singer").prepend(artist_name[currentPlaySongIndex].substring(0,8) + "...");
        } else {
            $("#song_info .info_singer").prepend(artist_name[currentPlaySongIndex]);
        }
    } else {
            $("#song_info .slash").prepend(name2[currentPlaySongIndex]);
            $("#song_info .info_singer").prepend(artist_name[currentPlaySongIndex]);
            if(name2[currentPlaySongIndex].length > 8) {
                $("#playbox_current").find(".playbox_music").find("span").find("b").text(name2[currentPlaySongIndex].substring(0,8) + "...");
            } else {
                $("#playbox_current").find(".playbox_music").find("span").find("b").text(name2[currentPlaySongIndex]);
            }
            if(artist_name[currentPlaySongIndex].length > 8) {
                $("#playbox_current").find(".playbox_singer").find("span").find("b").text(artist_name[currentPlaySongIndex].substring(0,8) + "...");
            } else {
                $("#playbox_current").find(".playbox_singer").find("span").find("b").text(artist_name[currentPlaySongIndex]);
            }
    }
    $("#lyrics_singer").prepend(artist_name[currentPlaySongIndex]);
    $('audio source#audio_main').attr('src', $('audio source').eq(currentPlaySongIndex + 1).attr('src'));
    
    $("#playbox_current").find(".playbox_album").find("img").attr("src", albumart[currentPlaySongIndex]);
    
    if(currentPlaySongIndex > 1) {
        for(var num = 1; num <= 2; num++) {
            $("#playbox_pre"+num).find(".playbox"+num+"_album").find("img").attr("src", albumart[currentPlaySongIndex - num]);
            $("#playbox_pre"+num).find(".playbox"+num+"_music").find("span").find("b").text(name2[currentPlaySongIndex - num]);
            $("#playbox_pre"+num).find(".playbox"+num+"_singer").find("span").find("b").text(artist_name[currentPlaySongIndex - num]);    
        }
    } else if(currentPlaySongIndex == 1) { 
        $("#playbox_pre2").find(".playbox2_album").find("img").attr("src", 'image/default.png');
        $("#playbox_pre2").find(".playbox2_music").find("span").find("b").text('');
        $("#playbox_pre2").find(".playbox2_singer").find("span").find("b").text('');
        
        $("#playbox_pre1").find(".playbox1_album").find("img").attr("src", albumart[currentPlaySongIndex - 1]);
        $("#playbox_pre1").find(".playbox1_music").find("span").find("b").text(name2[currentPlaySongIndex - 1]);
        $("#playbox_pre1").find(".playbox1_singer").find("span").find("b").text(artist_name[currentPlaySongIndex - 1]);
    } else {
        for(var num = 1; num <= 2; num++) {
            $("#playbox_pre"+num).find(".playbox"+num+"_album").find("img").attr("src", 'image/default.png');
            $("#playbox_pre"+num).find(".playbox"+num+"_music").find("span").find("b").text('');
            $("#playbox_pre"+num).find(".playbox"+num+"_singer").find("span").find("b").text('');    
        }
    }

    if((name2.length-2) > currentPlaySongIndex) {
        for(var num = 1; num <= 2; num++) {
            $("#playbox_next"+num).find(".playbox"+num+"_album").find("img").attr("src", albumart[currentPlaySongIndex + num]);
            $("#playbox_next"+num).find(".playbox"+num+"_music").find("span").find("b").text(name2[currentPlaySongIndex + num]);
            $("#playbox_next"+num).find(".playbox"+num+"_singer").find("span").find("b").text(artist_name[currentPlaySongIndex + num]);    
        }
    } else if ((name2.length-2) == currentPlaySongIndex) {
        $("#playbox_next1").find(".playbox1_album").find("img").attr("src", albumart[currentPlaySongIndex + 1]);
        $("#playbox_next1").find(".playbox1_music").find("span").find("b").text(name2[currentPlaySongIndex + 1]);
        $("#playbox_next1").find(".playbox1_singer").find("span").find("b").text(artist_name[currentPlaySongIndex + 1]);
        
        $("#playbox_next2").find(".playbox2_album").find("img").attr("src", 'image/default.png');
        $("#playbox_next2").find(".playbox2_music").find("span").find("b").text('');
        $("#playbox_next2").find(".playbox2_singer").find("span").find("b").text('');
    } else {
        for(var num = 1; num <= 2; num++) {
            $("#playbox_next"+num).find(".playbox"+num+"_album").find("img").attr("src", 'image/default.png');
            $("#playbox_next"+num).find(".playbox"+num+"_music").find("span").find("b").text('');
            $("#playbox_next"+num).find(".playbox"+num+"_singer").find("span").find("b").text('');    
        }
    }
//    shuffle();
}

function check() {
    for (var i = 0; i < lyrics.length; i++) {
        if (i < lyrics.length - 1 && currentPlayTime/2 >= times[i] && currentPlayTime/2 < times[i + 1]) {
            $("li").css("background-color", "");
            $("li").eq(i).css("background-color", "rgb(217,124,124)");
            return;
        } else if (i == lyrics.length - 1) {
            $("li").css("background-color", "");
            $("li").eq(i).css("background-color", "rgb(217,124,124)");
            return;
        }
    }
}

function lyrics_play() {
    if(music_no[currentPlaySongIndex] == '201608_0001') {
        lyrics = [
        "우주를 줄게 - 볼빨간사춘기<br>",
        "커피를 너무 많이 마셨나 봐요", 
        "심장이 막 두근대고 잠은 잘 수가 없어요",
        "한참 뒤에 별빛이 내리면 ",
        "난 다시 잠들 순 없겠죠<br>",
        "지나간 새벽을 다 새면 ",
        "다시 네 곁에 잠들겠죠",
        "너의 품에 잠든 난 마치 ",
        "천사가 된 것만 같아요",
        "난 그대 품에 별빛을 쏟아 내리고 ",
        "은하수를 만들어 어디든 날아가게 할거야<br>",
        "Cause I’m a pilot anywhere ",
        "Cause I’m a pilot anywhere ",
        "lighting star shooting star 줄게 내 Galaxy",
        "Cause I’m a pilot anywhere ",
        "Cause I’m your pilot 네 곁에 ",
        "저 별을 따 네게만 줄게 my Galaxy<br>",
        "Like a star 내리는 비처럼",
        "반짝이는 널 가지고 싶어",
        "Get ma mind",
        "엄지와 검지만 해도 내 마음을 너무 잘 표현해",
        "붙어 안달 나니까",
        "마냥 떨리기만 한 게 아냐",
        "준비가 되면 쏘아 올린 인공위성처럼",
        "네 주윌 마구 맴돌려 해",
        "더 가까워진다면 네가 가져줄래",
        "이 떨림을<br>",
        "어제는 내가 기분이 참 좋아서 ",
        "지나간 행성에다가 그대 이름 새겨 놓았죠",
        "한참 뒤에 별빛이 내리면 ",
        "그 별이 가장 밝게 빛나요<br>",
        "지나간 새벽을 다 새면 ",
        "다시 네 곁에 잠들겠죠",
        "별빛 아래 잠든 난 마치",
        "온 우주를 가진 것만 같아",
        "난 그대 품에 별빛을 쏟아 내리고 ",
        "은하수를 만들어 어디든 날아가게 할거야<br>",
        "Cause I’m a pilot anywhere ",
        "Cause I’m a pilot anywhere ",
        "Lighting star Shooting star ",
        "줄게 내 Galaxy",
        "Cause I’m a pilot anywhere ",
        "Cause I’m your pilot 네 곁에 ",
        "저 별을 따 네게만 줄게 my Galaxy<br>",
        "Cause I’m a pilot anywhere ",
        "Cause I’m a pilot anywhere ",
        "Lighting star Shooting star 줄게 내 Galaxy",
        "Cause I’m a pilot I’m your pilot",
        "Lighting star Shooting star 줄게 my Galaxy<br>",
        "라라라라라 라라라라라<br>"
    ];
    times = [0, 4, 8, 15, 20, 26, 29, 32, 35, 38, 44, 52, 55, 58, 64, 66, 69, 78, 81, 83, 85, 89, 91, 94, 96, 98, 100, 102, 107, 113, 118, 124, 128, 131, 133, 137, 142 ,149, 152, 155, 157, 160, 163, 166, 172, 175, 178, 183, 189, 196];
    } else if (music_no[currentPlaySongIndex] == '201608_0002') {
        lyrics = [
            "그림 같은 집이 뭐 별거겠어요 ",
            "어느 곳이든 그대가 있다면 그게 그림이죠<br>",
            "빛나는 하루가 뭐 별거겠어요",
            "어떤 하루던 그대 함께라면 뭐가 필요하죠<br>",
            "나 그대가 있지만 힘든 세상이 아니라",
            "힘든 세상 이지만 곁에 그대가 있음을 깨닫고", 
            "또 감사해요 또 기도해요", 
            "내 곁에서 변치 않고 영원하길 기도 드리죠<br>",
            "무려 우리 함께 눈뜨는 아침과",
            "매일 그댈 만나 돌아오는 집 앞",
            "나 만의 그대, 나의 그대, 내겐 사치라는걸<br>",
            "과분한 입맞춤에 취해 잠이 드는 일",
            "그래 사치, 그댄 사치, 내겐 사치<br>",
            "행복이란 말이 뭐 별거겠어요",
            "그저 그대의 잠꼬대 마저 날",
            "기쁘게 하는데<br>",
            "사랑이란 말이 뭐 별거겠어요",
            "그저 이렇게 보고만 있어도",
            "입에서 맴돌죠<br>",
            "나 그대가 있지만 거친 세상이 아니라",
            "거친 세상 이지만 내겐 그대가 있음을 깨닫고", 
            "또 다짐하죠 또 약속하죠", 
            "그대 곁에 변치않고 영원하길 약속할게요<br>",
            "무려 우리 함께 눈뜨는 아침과",
            "매일 그댈 만나 돌아오는 집 앞",
            "나 만의 그대, 나의 그대, 내겐 사치 라는걸<br>",
            "과분한 입맞춤에 취해 잠이 드는 일",
            "그래 사치, 그댄 사치, 내겐 사치<br>",
            "내가 상상하고 꿈꾸던 사람 그대",
            "정말 사랑하고 있다고 나 말 할 수 있어서",
            "믿을 수 없어, 정말 믿을 수 없어",
            "내가 어떻게 내가 감히 사랑할 수 있는지 말야<br>", 
            "무려 우리 함께 잠드는 이 밤과",
            "매일 나를 위해 차려진 이 식탁",
            "나 만의 그대, 나의 그대, 내겐 사치 라는걸<br>",
            "과분한 입맞춤에 취해 잠이 드는 일",
            "그래 사치, 그댄 사치, 내겐 사치<br>"
        ];
        times = [0, 13, 19, 26, 33, 41, 47, 54, 62, 75, 82, 88, 96, 104, 114, 120, 126, 129, 136, 141, 144, 151, 158, 165, 176, 183, 188, 196, 204, 215, 222, 229, 236, 246, 253, 259, 268, 275];
    } else if (music_no[currentPlaySongIndex] == '201608_0003') {
        lyrics = [
            "그림 같은 집이 뭐 별거겠어요 ",
            "어느 곳이든 그대가 있다면 그게 그림이죠<br>",
            "빛나는 하루가 뭐 별거겠어요",
            "어떤 하루던 그대 함께라면 뭐가 필요하죠<br>",
            "나 그대가 있지만 힘든 세상이 아니라",
            "힘든 세상 이지만 곁에 그대가 있음을 깨닫고", 
            "또 감사해요 또 기도해요", 
            "내 곁에서 변치 않고 영원하길 기도 드리죠<br>",
            "무려 우리 함께 눈뜨는 아침과",
            "매일 그댈 만나 돌아오는 집 앞",
            "나 만의 그대, 나의 그대, 내겐 사치라는걸<br>",
            "과분한 입맞춤에 취해 잠이 드는 일",
            "그래 사치, 그댄 사치, 내겐 사치<br>",
            "행복이란 말이 뭐 별거겠어요",
            "그저 그대의 잠꼬대 마저 날",
            "기쁘게 하는데<br>",
            "사랑이란 말이 뭐 별거겠어요",
            "그저 이렇게 보고만 있어도",
            "입에서 맴돌죠<br>",
            "나 그대가 있지만 거친 세상이 아니라",
            "거친 세상 이지만 내겐 그대가 있음을 깨닫고", 
            "또 다짐하죠 또 약속하죠", 
            "그대 곁에 변치않고 영원하길 약속할게요<br>",
            "무려 우리 함께 눈뜨는 아침과",
            "매일 그댈 만나 돌아오는 집 앞",
            "나 만의 그대, 나의 그대, 내겐 사치 라는걸<br>",
            "과분한 입맞춤에 취해 잠이 드는 일",
            "그래 사치, 그댄 사치, 내겐 사치<br>",
            "내가 상상하고 꿈꾸던 사람 그대",
            "정말 사랑하고 있다고 나 말 할 수 있어서",
            "믿을 수 없어, 정말 믿을 수 없어",
            "내가 어떻게 내가 감히 사랑할 수 있는지 말야<br>", 
            "무려 우리 함께 잠드는 이 밤과",
            "매일 나를 위해 차려진 이 식탁",
            "나 만의 그대, 나의 그대, 내겐 사치 라는걸<br>",
            "과분한 입맞춤에 취해 잠이 드는 일",
            "그래 사치, 그댄 사치, 내겐 사치<br>"
        ];
        times = [0, 0];
    } else {
        lyrics = [''];
        times = [];
    }
    $("#lyrics").empty();
    for (var i = 0; i < lyrics.length; i++) {
        var text = "<li>" + lyrics[i] + "</li>";

        if (lyrics[i].includes("<br>"))
            text = "<li>" + lyrics[i].substring(0, lyrics[i].length - 4) + "</li><br>";

        $("#lyrics").append(text);
    }
}

//resize가 최종완료되기전까지 resize 이벤트를 무시(최대화의 경우 resize가 계속발생하는 것을 방지)
$(window).resize(function() {
    if (this.resizeTO)
        clearTimeout(this.resizeTO);
    this.resizeTO = setTimeout(function() {
        $(this).trigger('resizeEnd');
    }, 0);
});
// resize가 최종완료된 후 실행되는 callback 함수
$(window).on('resizeEnd', function() {
    contentResize();
    headerResize();
});