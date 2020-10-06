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
    <title>하나카드 대시보드 로그인</title>

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

  </head>

  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form action="${pageContext.request.contextPath}/login" method="POST">
              <h1>관리자 로그인</h1>
              <div>
                <input type="text" name="empno" class="form-control" placeholder="사원번호" required="required" value="099003513"/>
              </div>
              <div>
                <input type="password" name="pw" class="form-control" placeholder="비밀번호" required="required" value="11111111"/>
              </div>
              <div>
                <input type="submit" value="로그인" class="btn btn-default submit" style="margin-left:135px">
              </div>
				
              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">
                  <a href="#signup" class="to_register">대시보드 접근권한 신청하기</a>
                  <a class="to_register" href="#">비밀번호를 잊으셨나요?</a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i>&nbsp; 하나카드 관리자 대시보드 </h1>
                  <p>©2020 Jaewon So All Rights Reserved. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form action="/resister" method="POST">
              <h1>접근 권한 신청</h1>
              <div>
                <input type="text" class="form-control" placeholder="사원명" required="required"/>
              </div>
              <div>
                <input type="text" class="form-control" placeholder="사원번호" required="required"/>
              </div>
              <div>
                <input type="password" class="form-control" placeholder="비밀번호" required="required"/>
              </div>
              <div>
                <a class="btn btn-default submit" href="index.html">Submit</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">이미 권한이 있으신가요?
                  <a href="#signin" class="to_register"><strong> 로그인  </strong></a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i>&nbsp; 하나카드 관리자 대시보드 </h1>
                  <p>©2020 Jaewon So All Rights Reserved. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
  </body>
</html>
