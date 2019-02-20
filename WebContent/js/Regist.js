var regist_step = 0;
var isCertMakeOK = false;
var isIdCheck = false;
var isNicknameCheck = false;
var cert_num = "ZZZZZZZ"; // 임시 데이터(7자리는 나올수 없으므로 초기값으로 설정함)

$(document).ready(function() {
  $("#cert_method a").click(function() {
    $("#cert_method a").removeClass("selected_method");
    $("#cert_method a").addClass("non_selected_method");
    $(this).removeClass("non_selected_method");
    $(this).addClass("selected_method");

    if ($(this).index() == 0) {
      $("#cert_phone").css("display", "block");
      $("#cert_email").css("display", "none");
      $("#content p").text("입력한 휴대폰번호로 인증 후 회원가입 됩니다.");
    } else {
      $("#cert_phone").css("display", "none");
      $("#cert_email").css("display", "block");
      $("#content p").text("입력한 이메일로 인증 후 회원가입 됩니다.");
    }
  });

  $("#all_agree input[type=checkbox]").change(function() {
    if ($(this).is(":checked"))
      $(".rule input[type=checkbox]").prop("checked", true);
    else $(".rule input[type=checkbox]").prop("checked", false);
  });

  $(".open_btn img").click(function() {
    if ($(this).attr("src") == "image/regist_open_btn.png") {
      $(this).attr("src", "image/regist_fold_btn.png");
      $(this)
        .parent()
        .parent()
        .addClass("open_rule");
      $(this)
        .parent()
        .siblings(".rule_content")
        .css("display", "block");
    } else {
      $(this).attr("src", "image/regist_open_btn.png");
      $(this)
        .parent()
        .parent()
        .removeClass("open_rule");
      $(this)
        .parent()
        .siblings(".rule_content")
        .css("display", "none");
    }
  });

  $(".num_input").keydown(function() {
    onlyNumber(this);
  });

  $(".cancel_input").keyup(function() {
    if ($(this).val().length > 0)
      $(this)
        .siblings(".cancel_btn")
        .css("display", "block");
    else
      $(this)
        .siblings(".cancel_btn")
        .css("display", "none");
  });

  $("#year_input input").keyup(function() {
    if ($(this).val().length == 4) $("#month_input input").focus();
  });

  $("#month_input input").keyup(function() {
    if ($(this).val().length == 2) $("#day_input input").focus();
  });

  $(".cancel_btn").click(function() {
    $(this).css("display", "none");
    $(this)
      .siblings("input")
      .val("");
  });

  $("#cert_number a div").click(function() {
    if (
      $("#name_input input")
        .val()
        .trim().length == 0
    ) {
      alert("이름을 입력해 주세요.");
      $("#name_input input").focus();
      return;
    }

    if (isCertMakeOK) {
      var answer = confirm("인증번호를 재전송 하시겠습니까?");

      if (!answer) return;
    }

    cert_num = makeCertificationNumber();
    // cert_num = 'PPPPPP';

    if (
      $("#cert_method a")
        .eq(0)
        .hasClass("selected_method")
    ) {
      if ($("#phone_input input").val().length == 11) {
        $.ajax({
          url: "RegistProc.jsp",
          type: "post",
          async: false,
          crossDomain: true,
          data: {
            requestType: "phone_check",
            phone: $("#phone_input input")
              .val()
              .trim()
          },
          success: function(data) {
            if (data.trim() == "fail") {
              $("#phone_input input").focus();
              alert("이미 해당 휴대폰 번호의 계정이 존재합니다.");
              return;
            } else {
              $.ajax({
                url: "https://rest.nexmo.com/sms/json",
                type: "get",
                dataType: "jsonp",
                jsonp: "success",
                async: false,
                crossDomain: true,
                data: {
                  api_key: "YourAppKey",
                  api_secret: "YourSecret",
                  type: "unicode",
                  from: "Seam Music",
                  msisdn: "YourPhone(해외형식821012345678)",
                  to: "RecievedPhoneNumber(해외형식821087654321)", // 이 부분을 인증번호를 보낼 번호로 바꾸면됨
                  text:
                    "Seam Music 가입 인증 번호는 '" +
                    cert_num +
                    "' [6자리] 입니다."
                },
                success: function(data) {
                  alert(JSON.stringify(data));
                },
                error: function() {
                  // alert("Cannot get data");
                  isCertMakeOK = true;
                  alert("해당 휴대폰 번호로 인증번호가 발송되었습니다.");
                }
              });
            }
          }
        });
      } else {
        alert("휴대폰 번호를 다시 입력해주세요.");
        $("#phone_input input").focus();
        return;
      }
    } else {
      if (
        $("#email_input input")
          .val()
          .trim().length > 0 &&
        $("#email_input select").val() != ""
      ) {
        $.ajax({
          url: "RegistProc.jsp",
          type: "post",
          async: false,
          crossDomain: true,
          data: {
            requestType: "email_check",
            email:
              $("#email_input input")
                .val()
                .trim() +
              "@" +
              $("#email_input select").val()
          },
          success: function(data) {
            if (data.trim() == "fail") {
              $("#phone_input input").focus();
              alert("이미 해당 이메일의 계정이 존재합니다.");
              return;
            } else {
              $.ajax({
                url: "RegistProc.jsp",
                type: "post",
                async: false,
                crossDomain: true,
                data: {
                  requestType: "cert_mail",
                  from: "YourEmailAdress",
                  to:
                    $("#email_input input")
                      .val()
                      .trim() +
                    "@" +
                    $("#email_input select").val(),
                  subject: "[Seam Music] 가입 인증 번호",
                  content:
                    "Seam Music 가입 인증 번호는 '" +
                    cert_num +
                    "' [6자리] 입니다."
                },
                success: function(data) {
                  if (data.trim() == "success") {
                    isCertMakeOK = true;
                    alert("해당 이메일로 인증번호가 발송되었습니다.");
                  } else {
                    isCertMakeOK = false;
                    cert_num = "ZZZZZZZ";
                    alert(
                      "메일 전송에 실패했습니다. 이메일 주소를 확인해주세요."
                    );
                  }
                },
                error: function() {
                  isCertMakeOK = false;
                  cert_num = "ZZZZZZZ";
                  alert(
                    "메일 전송에 실패했습니다. 이메일 주소를 확인해주세요."
                  );
                }
              });
            }
          }
        });
      } else {
        alert("이메일을 다시 입력해주세요.");
        $("#email_input input").focus();
        return;
      }
    }
  });

  $("#id_checker").click(function() {
    if (
      $("#id_input input")
        .val()
        .trim().length >= 5
    ) {
      $.ajax({
        url: "RegistProc.jsp",
        type: "post",
        async: false,
        crossDomain: true,
        data: {
          requestType: "id_check",
          id: $("#id_input input")
            .val()
            .trim()
        },
        success: function(data) {
          if (data.trim() == "success") {
            isIdCheck = true;
            alert("사용가능한 아이디입니다.");
          } else {
            isIdCheck = false;
            alert("이미 존재하는 아이디입니다.");
          }
        }
      });
    } else {
      alert("5자리 이상의 아이디를 입력하세요.");
      $("id_input input").focus();
      return;
    }
  });

  $("#nickname_checker").click(function() {
    if (
      $("#nickname_input input")
        .val()
        .trim().length >= 2
    ) {
      $.ajax({
        url: "RegistProc.jsp",
        type: "post",
        async: false,
        crossDomain: true,
        data: {
          requestType: "nickname_check",
          nickname: $("#nickname_input input")
            .val()
            .trim()
        },
        success: function(data) {
          if (data.trim() == "success") {
            isNicknameCheck = true;
            alert("사용가능한 닉네임입니다.");
          } else {
            isNicknameCheck = false;
            alert("이미 존재하는 닉네임입니다.");
          }
        }
      });
    } else {
      alert("2자리 이상의 닉네임을 입력하세요.");
      $("nickname_input input").focus();
      return;
    }
  });

  $("#step_changer div").click(function() {
    if (regist_step == 0) {
      var rule_length = $(".rule label input[type=checkbox]:checked").length;
      var cert_code = cert_num.substring(0, 1);

      if (
        $("#name_input input")
          .val()
          .trim().length == 0
      ) {
        alert("이름을 입력하세요.");
        $("#name_input input").focus();
        return;
      }

      if (
        cert_code == "P" &&
        $("#phone_input input")
          .val()
          .trim().length < 11
      ) {
        alert("휴대폰 번호를 입력하세요.");
        $("#phone_input input").focus();
        return;
      }

      if (
        cert_code == "E" &&
        ($("#email_input input")
          .val()
          .trim().length == 0 ||
          $("#email_input select").val() == "")
      ) {
        alert("이메일을 입력하세요.");
        $("#email_input input").focus();
        return;
      }
      if (cert_code == "Z") {
        alert("본인 인증을 해주세요.");
        return;
      }
      if ($("#number_input input").val() != cert_num) {
        alert("인증번호가 틀렸습니다. 다시 입력해주세요.");
        $("#number_input input").focus();
        return;
      }
      if (rule_length < 4) {
        alert("약관에 동의해주세요.");
        return;
      }

      if (cert_code == "P") {
        $("#regist_phone_input input").val(
          $("#phone_input input")
            .val()
            .trim()
        );
        $("#regist_phone_input input").prop("readonly", true);
        $("#regist_email_input input").addClass("cancel_input");
      } else {
        $("#regist_email_input input").val(
          $("#email_input input")
            .val()
            .trim()
        );
        $("#regist_email_input input").prop("readonly", true);
        $("#regist_email_input select").prop("disabled", true);
        $("#regist_phone_input input").addClass("cancel_input");

        for (
          var i = 0;
          i < $("#regist_email_input select option").size();
          i++
        ) {
          if (
            $("#regist_email_input select option")
              .eq(i)
              .attr("value") == $("#email_input select").val()
          ) {
            $("#regist_email_input select option")
              .eq(i)
              .prop("selected", "selected");
            break;
          }
        }
      }
      $("#regist_name_input input").val(
        $("#name_input input")
          .val()
          .trim()
      );
    } else if (regist_step == 2 && $(this).index() == 2) {
      var cert_code = cert_num.substring(0, 1);

      if (
        $("#passwd_input input")
          .val()
          .trim().length < 5
      ) {
        alert("비밀번호는 5자리 이상으로 해주세요.");
        $("#step_changer div")
          .eq(0)
          .trigger("click");
        $("#passwd_input input").focus();
        return;
      }
      if (
        $("#passwd_conf_input input")
          .val()
          .trim() !=
        $("#passwd_input input")
          .val()
          .trim()
      ) {
        alert("비밀번호가 일치하지 않습니다.");
        $("#step_changer div")
          .eq(0)
          .trigger("click");
        $("#passwd_conf_input input").focus();
        return;
      }
      if (
        cert_code == "E" &&
        $("#regist_phone_input input")
          .val()
          .trim().length < 11
      ) {
        alert("휴대폰 번호를 다시 입력하세요.");
        $("#step_changer div")
          .eq(0)
          .trigger("click");
        $("#regist_phone_input input").focus();
        return;
      } else if (
        cert_code == "E" &&
        $("#regist_phone_input input")
          .val()
          .trim().length == 11
      ) {
        var result = true;

        $.ajax({
          url: "RegistProc.jsp",
          type: "post",
          async: false,
          crossDomain: true,
          data: {
            requestType: "phone_check",
            phone: $("#regist_phone_input input")
              .val()
              .trim()
          },
          success: function(data) {
            if (data.trim() == "fail") {
              $("#regist_phone_input input").focus();
              $("#step_changer div")
                .eq(0)
                .trigger("click");
              alert("이미 해당 휴대폰 번호의 계정이 존재합니다.");
              result = false;
              return;
            }
          }
        });
        if (!result) return;
      }
      if (
        cert_code == "P" &&
        ($("#regist_email_input input")
          .val()
          .trim().length == 0 ||
          $("#regist_email_input select").val() == "")
      ) {
        alert("이메일을 다시 입력하세요.");
        $("#step_changer div")
          .eq(0)
          .trigger("click");
        $("#regist_email_input input").focus();
        return;
      } else if (
        cert_code == "P" &&
        $("#regist_email_input input")
          .val()
          .trim().length > 0 &&
        $("#regist_email_input select").val() != ""
      ) {
        var result = true;

        $.ajax({
          url: "RegistProc.jsp",
          type: "post",
          async: false,
          crossDomain: true,
          data: {
            requestType: "email_check",
            email:
              $("#regist_email_input input")
                .val()
                .trim() + $("#regist_email_input select").val()
          },
          success: function(data) {
            if (data.trim() == "fail") {
              $("#step_changer div")
                .eq(0)
                .trigger("click");
              $("#regist_email_input input").focus();
              alert("이미 해당 이메일의 계정이 존재합니다.");
              result = false;
              return;
            }
          }
        });
        if (!result) return;
      }

      if (!isIdCheck) {
        alert("아이디 중복 확인을 하세요.");
        $("#step_changer div")
          .eq(0)
          .trigger("click");
        $("#id_input input").focus();
        return;
      }

      if (!isNicknameCheck) {
        alert("닉네임 중복 확인을 하세요.");
        $("#step_changer div")
          .eq(0)
          .trigger("click");
        $("#nickname_input input").focus();
        return;
      }
      $("#regist_email_input select").prop("disabled", false);
      $("#regist_form").submit();
      return;
    }

    window.scrollTo(0, 0); // 페이지 가장 위로

    if ($(this).index() == 0) regist_step--;
    else if ($(this).index() == 1) regist_step++;
    else {
      if (regist_step == 2) {
        // regist_form.submit();
      } else if (regist_step == 3) {
        if (
          $(this)
            .find("span")
            .text() == "닫기"
        ) {
          parent.registHide();
          return;
        }
        $(this)
          .find("span")
          .text("닫기");
      }
    }

    if (regist_step == 0 || regist_step == 1) {
      $("#step_changer div").hide();
      $("#step_changer div")
        .eq(1)
        .show();
    } else if (regist_step == 2) {
      $("#step_changer div").show();
      $("#step_changer div")
        .eq(1)
        .hide();
    } else if (regist_step == 3) {
      $("#step_changer div").hide();
      $("#step_changer div")
        .eq(2)
        .show();
    }
    $("#step div").removeClass("selected_step");
    $("#step div").addClass("non_selected_step");
    $("#step div")
      .eq(regist_step)
      .removeClass("non_selected_step");
    $("#step div")
      .eq(regist_step)
      .addClass("selected_step");

    var step_name = [
      "I. 본인인증 및 약관",
      "II. 필수 사항 입력",
      "III. 선택 사항 입력",
      "IV. 가입 완료"
    ];

    for (var i = 0; i < step_name.length; i++) {
      if (i != regist_step) {
        step_name[i] = step_name[i].split(".")[0];

        if (i < regist_step)
          $("#step div")
            .eq(i)
            .css("left", i * 50 + "px");
        else
          $("#step div")
            .eq(i)
            .css("left", i * 50 + 300 + "px");
      } else
        $("#step div")
          .eq(i)
          .css("left", i * 50 + "px");
      $("#step div span")
        .eq(i)
        .text(step_name[i]);
    }

    $(".content_body").css("display", "none");
    $(".content_body")
      .eq(regist_step)
      .css("display", "block");
  });

  $("#passwd_view").click(function() {
    if ($("#passwd_input input").attr("type") == "password")
      $("#passwd_input input").attr("type", "text");
    else $("#passwd_input input").attr("type", "password");
  });

  $("#passwd_conf_view").click(function() {
    if ($("#passwd_conf_input input").attr("type") == "password")
      $("#passwd_conf_input input").attr("type", "text");
    else $("#passwd_conf_input input").attr("type", "password");
  });
});

$(document).on("keyup", ".cancel_input", function() {
  if ($(this).val().length > 0)
    $(this)
      .siblings(".cancel_btn")
      .css("display", "block");
  else
    $(this)
      .siblings(".cancel_btn")
      .css("display", "none");
});

function makeCertificationNumber() {
  var lower_case_alphabet = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ];
  var upper_case_alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  var number = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

  var lower_case_alphabet_cnt1 = Math.floor(
    Math.random() * lower_case_alphabet.length
  );
  var number_cnt1 = Math.floor(Math.random() * number.length);
  var lower_case_alphabet_cnt2 = Math.floor(
    Math.random() * lower_case_alphabet.length
  );
  var upper_case_alphabet_cnt2 = Math.floor(
    Math.random() * upper_case_alphabet.length
  );
  var number_cnt2 = Math.floor(Math.random() * number.length);

  var certification_number =
    lower_case_alphabet[lower_case_alphabet_cnt1] +
    number[number_cnt1] +
    lower_case_alphabet[lower_case_alphabet_cnt2] +
    number[number_cnt2] +
    upper_case_alphabet[upper_case_alphabet_cnt2];

  if (
    $("#cert_method a")
      .eq(0)
      .hasClass("selected_method")
  )
    certification_number = "P" + certification_number;
  else certification_number = "E" + certification_number;

  return certification_number;
}

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
      $("#preview_image img").attr("src", e.target.result);
    };
    reader.readAsDataURL(file);
  }
}

function onlyNumber(obj) {
  $(obj).keyup(function() {
    $(this).val(
      $(this)
        .val()
        .replace(/[^0-9]/g, "")
    );
  });
}
