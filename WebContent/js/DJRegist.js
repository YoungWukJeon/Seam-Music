var test = 3;

$(window).load(function() {

});

$(document).on("click", ".select_playlist_content_hover", function() {
    $(this).find("input[type=radio]").prop("checked", true);
});

$(document).ready(function() {
    $(".text_check").keyup(function() {
        $(".text_num_checker span").text($(this).val().length);
    });

    $(".select_playlist_content").mouseover(function() {
        if (!$(this).hasClass("non_selected_playlist"))
            $(this).addClass("select_playlist_content_hover");
    });

    $(".select_playlist_content").mouseout(function() {
        $(this).removeClass("select_playlist_content_hover");
    });
    
    $("#submit_btn").click(function() {
    	if ($("#playlist_name input").val().trim().length == 0) {
            alert('제목을 입력하세요');
            $("#playlist_name input").focus();
            return;
        }

        if ($("#playlist_theme input").val().trim().length == 0 && $("#playlist_theme select").val() == 'no_select') {
            alert('테마나 장르를 입력하세요');
            $("#playlist_theme input").focus();
            return;
        }
        
        if( $("input[type=radio]:checked").length == 0 ) {
        	alert('플레이리스트를 선택하세요.');
        	return;
        }
        
        if( $("#intro_main textarea").val().trim().length == 0 ) {
        	alert('소개글을 입력하세요.');
        	$("#intro_main textarea").focus();
        	return;
        }
        
        if( $("#rule_agree label input[type=checkbox]:checked").length == 0 ) {
        	alert('약관에 동의해 주세요.');
        	return;
        }
        
        $("#dj_regist_form").submit();
        	
    });

});

function loadFile(input) {
    var file = input.files[0],
        url = file.urn || file.name;

    var filename = url;

    // if (window.FileReader) { // modern browser
    //     var filename = $(this)[0].files[0].name;
    // } else { // old IE
    //     var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
    // }

    // 추출한 파일명 삽입
    $(".upload-name").val(filename);

    if (file) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#playlist_img img').attr('src', e.target.result);
        }
        reader.readAsDataURL(file);
    }
}