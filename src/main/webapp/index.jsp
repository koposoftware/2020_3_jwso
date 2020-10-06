<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>하나카드 대시보드</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">

  <!-- Favicons -->
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/hana_img/hana_logo.ico">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900|Raleway:400,300,700,900" rel="stylesheet">
  <!-- Bootstrap CSS File -->
  <link href="${pageContext.request.contextPath}/resources/index/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Libraries CSS Files -->
  <link href="${pageContext.request.contextPath}/resources/index/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- Main Stylesheet File -->
  <link href="${pageContext.request.contextPath}/resources/index/css/style.css" rel="stylesheet">

</head>

<style>
@font-face {
	   font-family: 'hana-font';
	   src: url('${pageContext.request.contextPath}/resources/hana_font/HanaM.ttf');
	}
	
.loading span {
  display: inline-block;
  margin: 0.03em;
  animation: loading .8s infinite alternate;
}
.loading span:nth-child(2) {
  animation-delay: .1s;
}
.loading span:nth-child(3) {
  animation-delay: .2s;
}
.loading span:nth-child(4) {
  animation-delay: .3s;
}
.loading span:nth-child(5) {
  animation-delay: .4s;
}
.loading span:nth-child(6) {
  animation-delay: .5s;
}
.loading span:nth-child(7) {
  animation-delay: .6s;
}
.loading span:nth-child(8) {
  animation-delay: .7s;
}

@keyframes loading {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(0.8);
  }
}

span{
	font-family : hana-font;
	font-size:70px;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"></script>
<body data-spy="scroll" data-offset="80" data-target="#thenavbar">

  <div id="hello">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-lg-offset-2 centered">
         <div class="loading">
			  <span>하</span>
			  <span>나</span>
			  <span>카</span>
			  <span>드</span>
			  &nbsp;&nbsp;
			  <span>대</span>
			  <span>시</span>
			  <span>보</span>
			  <span>드</span>
	    </div>

          <br>
          <br>
          <a href="${pageContext.request.contextPath}/login">
          	<img src="${pageContext.request.contextPath}/resources/hana_img/hana_logo.png" style="width:140px; height:130px;">
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- JavaScript Libraries -->
  <script src="${pageContext.request.contextPath}/resources/index/lib/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/index/lib/bootstrap/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/index/lib/php-mail-form/validate.js"></script>
  <script src="${pageContext.request.contextPath}/resources/index/lib/easing/easing.min.js"></script>
  <!-- Datatables -->
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/jszip/dist/jszip.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/pdfmake/build/pdfmake.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/vendors/pdfmake/build/vfs_fonts.js"></script>

</body>
</html>
