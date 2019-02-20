$(document).ready(function() {
    // $(".nav").hide();

    var nav_open = 0;
    var lyrics_open = 0;
    var playing = 0;

    var canvas;
    var ctx;

    $(".nav_menu_btn img").click(function() {

        if (nav_open == 0) {
            $(this).attr("src", "image/nav_menu_close.png");
            $(".nav_menu_btn").css("width", "15%");
            $(".nav_menu_btn").css("margin-left", "85%");
            $("#nav").css("width", "20%");
            nav_open = 1;
        } else {
            $(this).attr("src", "image/nav_menu_open.png");
            $(".nav_menu_btn").css("width", "100%");
            $(".nav_menu_btn").css("margin-left", "0");
            $("#nav").css("width", "3%");
            nav_open = 0;
        }
    });

    $(".lyrics_open").click(function() {

        if (lyrics_open == 0) {

        }

    });

    $("#current_circle img").click(function() {
        if (playing == 0) {
            $(this).attr("src", "image/pause_btn.png");
            playing = 1;

            document.getElementById("audio").play();
            document.getElementById("audio").volume = 0.3;
            // $("#audio").play();
        } else {
            $(this).attr("src", "image/play_btn.png");
            playing = 0;

            document.getElementById("audio").pause();
            // $("#audio").pause();
        }
    });

    $("audio").on("loadeddata", function() {
        canvas = document.getElementById("progress_bar");
        ctx = canvas.getContext("2d");
    });



    $("audio").on("progress", function() {
        var audio = document.getElementById("audio");
        var rate = Math.floor((100 / audio.duration) * audio.currentTime);

        // alert(rate);
    });

});