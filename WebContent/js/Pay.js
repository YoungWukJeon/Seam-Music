$(document).ready(function () {
	$("#submit_btn").click(function() {
    	if ($("#agree_check label input[type=checkbox]:checked").length == 0) {
            alert('약관에 동의하세요.');
            return;
        }
        
        if( $("#radio_box label input[type=radio]:checked").length == 0 ) {
        	alert('결제방법을 선택해주세요.');
        	return;
        }
        
        parent.$("#pay_dialog").css("width", "800px");
        parent.$("#pay_iframe").css("height", "500px");
        
        startPay();
    });
});