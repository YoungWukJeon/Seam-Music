var ID3 = window.ID3;

/**
 * Loading the tags using the FileAPI.
 */
function loadFile(input)
{
	var file = input.files[0], url = file.urn || file.name;
	
	ID3.loadTags(url, function()
	{
		showTags(url);
	}, {
		tags : [ "title", "artist", "album", "picture", "year", "genre", "lyrics", "track" ],
		dataReader : ID3.FileAPIReader(file)
	});
}
function loadFile2(input)
{
	var file = input.files[0], url = file.urn || file.name;

	if (file)
	{
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#album_art').attr('src', e.target.result);
        }
        reader.readAsDataURL(file);
	}
}
/**
 * Generic function to get the tags after they have been loaded.
 */
function showTags(url)
{
	var tags = ID3.getAllTags(url);
	
	$.ajax({
	    type: "POST",
	    url: "Convert.jsp",
	    processData: false,
	    dataType: "text",
	    data: "data=" + tags.title,
	    success: function(text) {
	    	$("#title").prop('value', text);
	    }
	});
	$.ajax({
	    type: "POST",
	    url: "Convert.jsp",
	    processData: false,
	    dataType: "text",
	    data: "data=" + tags.artist,
	    success: function(text) {
	    	$("#artist").prop('value', text);
	    }
	});
	$.ajax({
	    type: "POST",
	    url: "Convert.jsp",
	    processData: false,
	    dataType: "text",
	    data: "data=" + tags.album,
	    success: function(text) {
	    	$("#album").prop('value', text);
	    }
	});
	$.ajax({
	    type: "POST",
	    url: "Convert.jsp",
	    processData: false,
	    dataType: "text",
	    data: "data=" + tags.year,
	    success: function(text) {
	    	$("#release_date").prop('value', text);
	    	$("#music_file_upload").contents().find("#music_form").attr("action", "Admin_Music_FileUpload.jsp?release_date=" + text.trim());
	    }
	});
	$.ajax({
	    type: "POST",
	    url: "Convert.jsp",
	    processData: false,
	    dataType: "text",
	    data: "data=" + tags.genre,
	    success: function(text) {
	    	$("#genre").prop('value', text);
	    }
	});
	
	$("#track").prop('value', tags.track);
	
	var lyrics = tags.lyrics.U;
	
	// lyrics = lyrics.replace(/\r\n/gi, "<br>");
	
	$("#lyrics").prop('value', lyrics);

	    
	/*var image = tags.picture;
	if (image)
	{
		var base64String = "";
		for (var i = 0; i < image.data.length; i++)
		{
			base64String += String.fromCharCode(image.data[i]);
		}
		var base64 = "data:" + image.format + ";base64,"
				+ window.btoa(base64String);
		document.getElementById('picture').setAttribute('src', base64);
	}
	else
	{
		document.getElementById('picture').style.display = "none";
	}*/
}
var objectUrl;

function addAudioFile(file)
{
	objectUrl = URL.createObjectURL(file);
	$("audio").prop("src", objectUrl);
}
function formSubmit()
{
	$("#content_form").submit();
}

$(document).ready(function() {
	
	$("input[type='button']").click(function() {
		$("#music_file_upload").contents().find("#music_form").submit();
	});
	
	$("audio").on("canplaythrough", function(e){
	    var seconds = Math.floor(e.currentTarget.duration);
	    
	    /*var duration = moment.duration(seconds, "seconds");
	    
	    var time = "";
	    var hours = duration.hours();
	    if (hours > 0) { time = hours + ":" ; }
	    
	    time = time + duration.minutes() + ":" + duration.seconds();*/
	    
	    $("#time").prop('value', seconds);
	    URL.revokeObjectURL(objectUrl);
	});
});

