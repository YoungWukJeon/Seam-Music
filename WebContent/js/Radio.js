var isPlay = false;
var player;
var playing_interval;
var currentPlayTime = 0;
var currentVolume = 0.2
var currentPlaySongIndex = 0;
var currentSelectedSongIndex;
var isMute = false;
var duration;

$(document).ready(function() {
    
    player = document.getElementsByTagName('audio')[0];
    player.volume = currentVolume;

    $('audio').on("loadeddata", function() {
        duration = Math.floor(this.duration);
        $("#song_current_time").text("0:00");
        $("#song_total_time").text(getTimeFormat(log_playtime()));

        $("#appearance7").roundSlider({
            radius: 200,
            width: 10,
            handleSize: "+16",
            handleShape: "dot",
            startAngle: 90,
            sliderType: "min-range",
            value: currentPlayTime,
            max: duration * 2,
            animation: false,
            editableTooltip: false,
            showTooltip: false,
            change: function(e) {
                currentPlayTime = e.value;
                player.currentTime = currentPlayTime / 2;
            }
        });
    });

    $('audio').on("play", function() {
        playing_interval = setInterval(function() {
            $("#song_current_time").text(getTimeFormat(currentPlayTime));
            currentPlayTime++;
            if(logstate == "") {
                if(currentPlayTime >= 80) {
                    audion_end();
                }
            }
        }, 1000);
    });

    $('audio').on("pause", function() {
        clearInterval(playing_interval)
    });

    $('#play_btn').click( function() {
        playclick();
    });

    $('#next_btn').click( function() {
        currentPlaySongIndex++;
        $(".music").eq(currentPlaySongIndex).trigger('dblclick');
    });

    $('.music').click( function() {
        currentSelectedSongIndex = $(this).index('.music');
        $('.music').css({'background': "", 'color': 'black'});
        $(this).css({'background': '#a0a0a0', 'color': 'white'});
    });

    $('.music').dblclick( function() {
        isEnded = false;
        currentPlaySongIndex = $(this).index(".music");

        $(".music").css("font-weight", "");
        $(".music").eq(currentPlaySongIndex).css("font-weight", "bold");

        if(!isPlay) {
            isPlay = true;
            $('#play_btn').attr('src', 'image/pause_icon.png');
        }
        clearInterval(playing_interval);
        currentPlayTime = 0;
        $('audio source#audio_radio').attr('src', $('audio source').eq(currentPlaySongIndex + 1).attr('src'));
        $('#left_img').empty();
        $('#left_img').attr("src", albumart[currentPlaySongIndex]);
        $('#current_info').empty();
        $('#current_info').prepend(artist_name[currentPlaySongIndex]+"<br>"+name2[currentPlaySongIndex]);
        $('.list_block').css('height', currentPlaySongIndex*30+'px');
        if(currentPlaySongIndex != 0) {
            $('.list_block span').show();
            $('.list_block span').css('top', 'calc(50% - 12px)');
        }

        parent.$('.radio_on').show();
        player.load();
        player.play();
    });

    $('audio').on("ended", function() {
        audion_end();
    });

    $('#volume_btn').click( function() {
        if(!isMute) {
            isMute = true;
            $('#volume_btn').attr('src', 'image/mute_icon.png');
            player.volume = 0;
            $('#volume_progress_bar').prop("value",0);
        } else {
            isMute = false;
            $('#volume_btn').attr('src', 'image/volume_icon.png');
            $('#volume_progress_bar').prop("value",currentVolume);
            player.volume = currentVolume;
        }
    });

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
                isMute = true;
                $('#volume_btn').attr("src", 'image/mute_icon.png');
            } else {
                isMute = false;
                $('#volume_btn').attr("src", 'image/volume_icon.png');
            }
    });

    $('.genre').click(function() {
        var index = $(this).index();
        if(index == 0) {
            $('.playlist').hide();
            $('#playlist').show();
        } else if (index == 1) {
            $('.playlist').hide();
            $('#playlist_trot').show();
        } else if (index == 2) {
            $('.playlist').hide();
            $('#playlist_pop').show();
        } else {
            $('.playlist').hide();
            $('#playlist_rock').show();
        }
    });
});

function playclick() {
    if(isPlay == false) {
        $('#play_btn').attr('src', 'image/pause_icon.png');
        isPlay = true;
        player.play();
        parent.$('.radio_on').show();
    } else {
        $('#play_btn').attr('src', 'image/play_icon.png');
        isPlay = false;
        player.pause();
        parent.$('.radio_on').hide();
    }
}

function audion_end() {
    isEnded = true;
    if(currentPlaySongIndex == name2.length) {
        currentPlaySongIndex = 0;
    } else {
        currentPlaySongIndex++;
    }
    $('.music').eq(currentPlaySongIndex).trigger('dblclick');
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

function log_playtime() {
    var log_playtime;
    if(logstate == "") { log_playtime = 40; }
    else { log_playtime = duration; }
    return log_playtime;
}

function init() {
    var totalPlayTime = 0;

    for (var i = 0; i < name2.length; i++) {
        var songname = name2[i];
        var artist = artist_name[i];

        var tempStr = 
            "<div class=music>" + songname + " - " + artist + "</div>";

        $("#playlist").append(tempStr);

        $("audio").append("<source src=audio/" + music_no[i] + ".mp3>");
    }
    
    $('audio source#audio_radio').attr('src', $('audio source').eq(currentPlaySongIndex + 1).attr('src'));
    $('#left_img').attr("src", albumart[currentPlaySongIndex]);
    $('#current_info').prepend(artist_name[currentPlaySongIndex]+"<br>"+name2[currentPlaySongIndex]);
}