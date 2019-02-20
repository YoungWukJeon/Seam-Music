function loadFile(input)
{
	var file = input.files[0], url = file.urn || file.name;

	if (file)
	{
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#profile_img').attr('src', e.target.result);
        }
        reader.readAsDataURL(file);
	}
}