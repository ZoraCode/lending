$(document).ready(function(){
	$(".hp,#HP2,#HP3").on("keyup", function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
});

function SubmitConfirm() {
		if (form0.NAME.value == "") {
			alert("필수항목 : 이름을 입력해주세요.");
			form0.NAME.focus();
			return false;
		}
		else if (form0.HP2.value == "") {
			alert("필수항목 : 연락가능한 핸드폰번호를 입력해주세요.");
			form0.HP2.focus();
			return false;
		}
		else if (form0.HP3.value == "") {
			alert("필수항목 : 연락가능한 핸드폰번호를 입력해주세요.");
			form0.HP3.focus();
			return false;
		}
		else if ($("input:checkbox[name=chk1]").is(":checked") == false) {
			alert("개인정보보호정책 및 마케팅 동의하셔야 합니다.");
			form0.chk1.focus();
			return false;
		}
		else {
			if(confirm('확인 버튼을 클릭하시면 상담 신청이 완료됩니다.\n\n방문해 주셔서 감사합니다.')){
				form0.submit();
			}
		}
        return true;
}

function SubmitConfirm1() {

	if (form1.NAME.value == "") {
		alert("필수항목 : 이름을 입력해주세요.");
		form1.NAME.focus();
		return false;
	}
	else if (form1.hp.value == "") {
		alert("필수항목 : 연락가능한 핸드폰번호를 입력해주세요.");
		form1.hp.focus();
		return false;
	}
	else if ($("input:checkbox[name=chk2]").is(":checked") == false) {
		alert("개인정보보호정책 및 마케팅 동의하셔야 합니다.");
		form1.chk2.focus();
		return false;
	}
	else {
		if(confirm('확인 버튼을 클릭하시면 상담 신청이 완료됩니다.\n\n방문해 주셔서 감사합니다.')){
			form1.submit();
		}
	}
	return true;
}

function inputTelNumber(obj) {

    var number = obj.value.replace(/[^0-9]/g, "");
    var tel = "";

    // 서울 지역번호(02)가 들어오는 경우
    if(number.substring(0, 2).indexOf('02') == 0) {
        if(number.length < 3) {
            return number;
        } else if(number.length < 6) {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2);
        } else if(number.length < 10) {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2, 3);
            tel += "-";
            tel += number.substr(5);
        } else {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2, 4);
            tel += "-";
            tel += number.substr(6);
        }
    
    // 서울 지역번호(02)가 아닌경우
    } else {
        if(number.length < 4) {
            return number;
        } else if(number.length < 7) {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3);
        } else if(number.length < 11) {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3, 3);
            tel += "-";
            tel += number.substr(6);
        } else {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3, 4);
            tel += "-";
            tel += number.substr(7);
        }
    }

    obj.value = tel;
}