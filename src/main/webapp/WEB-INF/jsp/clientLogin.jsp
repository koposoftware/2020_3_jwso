<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicons -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/hana_img/hana_logo.ico">
    <title>로그인</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="${pageContext.request.contextPath}/resources/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/resources/build/css/custom.min.css" rel="stylesheet">
    <!-- PNotify -->
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-progressbar -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">

<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.4.js"></script>	
<script>
function buttonClick() {
	if($("input:checkbox[name=check]").is(":checked") == true) {
		  $('#content').trigger("click");
	}
}

function checkForm(form) {
	
  if(!form.check.checked) {
    alert("결제내역 리포팅 서비스 이용약관을 읽고 동의해야 합니다.");
    form.check.focus();
    return false;
  }
  return true;
}

</script>
  </head>
  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form action="${pageContext.request.contextPath}/mailingService" method="POST" onsubmit="return checkForm(this)">
            <div class="separator"></div>
              <img src="${pageContext.request.contextPath}/resources/hana_img/hanacard.png" style="width:150px; height:40px;"> 
              <%-- Modal --%>
              <br/><br/>
               ID 
                <input type="text" name="cid" class="form-control" placeholder="손님의 ID를 입력하세요." required="required" value="HANA000567090" style="width:40%;
                margin-left:110px; align:center;"/>
               PW
                <input type="password" name="pw" class="form-control" placeholder="손님의 PW를 입력하세요." required="required" value="1111" style="width:40%; margin-left:110px; align:center;"/>
                	
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" style="display: none;" id="content"></button>
              <p class="change_link">
                  <input type="checkbox" name="check" onclick="buttonClick()"/>결제내역 리포팅 서비스 이용을 동의합니다.
              <div>
                <input type="submit" value="로그인" class="btn btn-default submit" style="margin-left:135px">
              </div>    
              <div class="clearfix"></div>
              <div class="separator">
              <div class="clearfix"></div>
              <br/>
              </div>

            </form>
          </section>
        </div>
      </div>
    </div>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="${pageContext.request.contextPath}/resources/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/resources/vendors/iCheck/icheck.min.js"></script>
    <!-- PNotify -->
    <script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="${pageContext.request.contextPath}/resources/build/js/custom.min.js"></script>
  </body>
  
                    <div class="modal bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel">서비스 이용약관</h4>
                        </div>
                        <div class="modal-body">
                          <h4>[ 개인정보 수집 및 이용 안내 ]</h4>

					 	 <p>1. 수집하는 개인정보의 항목</p>
						 <p>가. 하나카드는 결제내역조회를 위해 아래와 같은 개인정보를 수집하고 있습니다.</p>
						 <p>– 개인정보항목 : 고객ID, 이름, 이메일 주소, 카드결제기록, 결제정보</p>
						
						 <p>나. "결제정보"라 함은 "이용자"가 고객사의 상품 및 서비스를 구매하기 위하여 "회사"가 제공하는 "서비스"를 통해 제시한 각 결제수단 별 제반 정보를 의미하며 카드번호, 성명, 휴대폰번호, 승인번호, 고객ID를 말합니다.
						
						 <p>다. 결제수단별 수집하는 개인정보 항목은 다음과 같습니다.
						 <p>(신용카드) 카드번호(3rd-마스킹), 승인시간, 승인번호, 승인금액
						 <p>(휴대폰) 휴대폰번호, 이동통신사정보
						
						 <p>2. 개인정보의 수집 및 이용목적
						 <p>가. 회사는 다음과 같은 목적 하에 "결제내역조회"와 관련한 최소한의 개인정보를 수집합니다.
						 <p>– 신용카드, 계좌이체, 가상계좌, 휴대폰결제, 문화상품권 결제내역 조회
						
						 <p>3. 개인정보의 보유 및 이용기간
						 <p>이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
						 <p>가. 회사 내부 방침에 의한 정보 보유 사유
						 <p>– 본 전자결제서비스 계약상의 권리, 의무의 이행
						 <p>상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.
						 
						 <p>* 대금결제 및 재화 등의 공급에 관한 기록
						 <p>– 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률
						 <p>– 보존 기간 : 5년
						 <p>* 건당 1만원 초과 전자금융거래에 관한 기록
						 <p>– 보존 이유 : 전자금융거래법
						 <p>– 보존 기간 : 5년
						 <p>* 건당 1만원 이하 전자금융거래에 관한 기록
						 <p>– 보존 이유 : 전자금융거래법
						 <p>– 보존 기간 : 1년
						 <p>* 방문에 관한 기록
						 <p>– 보존 근거 : 통신비밀보호법
						 <p>– 보존 기간 : 3년
						
						 <p>4. 개인정보 수집 동의 거부
						 <p>위와 같은 개인정보 수집 동의를 거부할 수 있습니다. 동의를 거부하는 경우 결제내역조회가 제한됩니다.
						 <p>결제내역조회에 필요한 최소한의 개인정보 수집
						
						 <p>그 밖의 사항은 하나카드의 개인정보 처리방침에 따라 처리 합니다.
						</div>
                        <div class="modal-footer">
				             <button type="submit" id="cancel" class="btn btn-default" data-dismiss="modal">확인</button>
				        </div>

                      </div>
                    </div>
                  </div>    
</html>
