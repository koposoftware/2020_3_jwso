<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <title>하나카드 관리자 대시보드</title>
     <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/resources/build/css/custom.min.css" rel="stylesheet">
    <!-- morris.js -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
    <!-- PNotify -->
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

<style>
.echart {
	min-height: 150px;
	width: 100%;
}

h3 {
	color: #46BA9B !important;
	font-weight: bold;
}

.my-custom-scrollbar {
position: relative;
height: 200px;
overflow: auto;
}
.table-wrapper-scroll-y {
display: block;
}

.loader {
	position : fixed;
	top : 50%;
	left : 50%;
	transform:translate(-50%, -50%);
	z-index : 9999;
}

#mask {
      position:absolute;
      z-index:98;
      background-color: lightgray ;
      display:none;
      left:0;
      top:0;
}

</style>
   
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.4.js"></script>
<script>

$(document).ready(function() {
	
	var maskHeight = $(document).height();
    var maskWidth = $(window).width();  

    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});  
    $('#mask').hide();
	$('.loader').hide(); //첫 시작시 로딩바를 숨겨준다.
	
	
	$(document).ajaxStart(function () {
		$('#mask').show();
		$('#mask').fadeTo('slow', 0.8);
		$('.loader').show();
	}); 
	
	$(document).ajaxStop(function () {
		$('#mask').fadeOut(1000);
		$('.loader').fadeOut(1000);
	});
	
});

function send() {
	$.ajax({
		url : "${pageContext.request.contextPath}/mail",
		type : "GET",
		success : function() {
			alert('성공')
		},
		error : function () {
			alert('성공');
		}
	})
}
function saveMemo() {

	$.ajax({
		url : "${pageContext.request.contextPath}/insertMemo/${employeeVO.empno}",
		type : "POST",
		data : {content : $('#memo').val()},
		success : function(data) {
			new PNotify({
                title: '성공',
                text: '성공적으로 저장되었습니다!',
                type: 'success',
                styling: 'bootstrap3'
            });
			$('.modal').modal('hide');
			$('body').removeClass('modal-open');
			$('.modal-backdrop').remove(); 
		},
		error : function() {
			new PNotify({
                title: '실패',
                text: '메모 저장에 실패했습니다.',
                type: 'error',
                styling: 'bootstrap3'
            });
			$('.modal').modal('hide');
			$('body').removeClass('modal-open');
			$('.modal-backdrop').remove();
		}
	})	
}

var dt = '';
var defaultDt = '';
function formatDate(date) {
	var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
			+ d.getDate(), year = d.getFullYear();
	if (month.length < 2)
		month = '0' + month;
	if (day.length < 2)
		day = '0' + day;
	return [ year, month, day ].join('-');
}

$(document).ready( function() {
	
	<%-- 사용자 메모 조회를 미리 해두어서 데이터테이블에 정상 적용되도록 함--%>
	$.ajax({
		url : "${pageContext.request.contextPath}/selectMemo/${employeeVO.empno}",
		type : "POST",
		success : function(data) {
		},
		error : function() {
			alert('실패');
		}
	})
	
	<%-- defaultData / Daily --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/defaultCnt",
		type: 'POST',
		async : false,
		success : function(data) {
			data = JSON.parse(data);
			defaultDt = data;
			console.log(defaultDt);
			$('#defaultCount').text(data[0].defaultCnt);
		},
		error : function() {
			alert('실패')
		}
	});
	
	<%-- loansData / 7 Days / Line Chart / Bar Graph --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/selectLoansData",
		type: 'POST',
		async : false,
		success : function(data) {
				data = JSON.parse(data);
				console.log(data);
				dt = data;
				<%-- Top tiles --%>
				$('#revolvingCount').text(data[0].revolvingCnt);
				$('#stLoansCount').text(data[1].shortTermLoansCnt);
				$('#ltLoansCount').text(data[2].longTermLoansCnt); 
		},
		error : function() {
			alert('실패')
		}
	});
})

window.onload = function(){
	
	var str = "<script>";
		str += "new Morris.Line({";
		str += "		element: loansLineChart,";
		str += "		data: [";
				for (let i = 0; i <= 6; i++) {
					if (i <= 5) {
		str += '		{ "날짜":"' + dt[i].loanDate.substr(5, 10) + '","리볼빙":' +  dt[i].revolvingCnt + ',"현금서비스":' + dt[i].shortTermLoansCnt + ',"카드론":' + dt[i].longTermLoansCnt  + "},";     						
					} else {
		str += '		{ "날짜":"' + dt[i].loanDate.substr(5, 10) + '","리볼빙":' +  dt[i].revolvingCnt + ',"현금서비스":' + dt[i].shortTermLoansCnt + ',"카드론":' + dt[i].longTermLoansCnt  + "}";     							
					}
				}
		str += '		],';
		str += '        resize : true,';
		str += '        hideHover : "auto",';
		str += '		xkey: "날짜", parseTime: false,';
		str += '		ykeys: ["리볼빙", "현금서비스", "카드론"], ';
		str += '		labels: ["리볼빙", "현금서비스", "카드론"],';
		str += '        lineColors : ["#386158", "#30907E", "#4CC39B"]';
		str += '		}); </';
		str += 'script>'; 
		
		$('#loansLineChart').append(str);
		
	var str = "<script>";
		str += "new Morris.Line({";
		str += "		element: lineChart,";
		str += "		data: [";
				for (let i = 0; i <= 6; i++) {
					if (i <= 5) {
		str += '		{ "날짜":"' + defaultDt[i].defaultDate.substr(5, 10) + '","연체발생 수":' +  defaultDt[i].defaultCnt +  "},";     						
					} else {
		str += '		{ "날짜":"' + defaultDt[i].defaultDate.substr(5, 10) + '","연체발생 수":' +  defaultDt[i].defaultCnt +  "}";     							
					}
				}
		str += '		],';
		str += '        resize : true,';
		str += '        hideHover : "auto",';
		str += '		xkey: "날짜", parseTime: false,';
		str += '		ykeys: ["연체발생 수"], ';
		str += '		labels: ["연체발생 수"],';
		str += '        lineColors : ["#46BA9B"]';
		str += '		}); </';
		str += 'script>'; 	
		
		$('#lineChart').append(str);
		
		Morris.Bar({
			  element: 'bar_chart',
			  data: [
				  
			    { "날짜" : formatDate(dt[0].loanDate).substr(5,10), '리볼빙' : dt[0].revolvingSum, '현금서비스' : dt[0].shortTermLoansSum, '카드론' : dt[0].longTermLoansSum},
			    { "날짜" : formatDate(dt[1].loanDate).substr(5,10), '리볼빙' : dt[1].revolvingSum, '현금서비스' : dt[1].shortTermLoansSum, '카드론' : dt[1].longTermLoansSum},
			    { "날짜" : formatDate(dt[2].loanDate).substr(5,10), '리볼빙' : dt[2].revolvingSum, '현금서비스' : dt[2].shortTermLoansSum, '카드론' : dt[2].longTermLoansSum},
			    { "날짜" : formatDate(dt[3].loanDate).substr(5,10), '리볼빙' : dt[3].revolvingSum, '현금서비스' : dt[3].shortTermLoansSum, '카드론' : dt[3].longTermLoansSum},
			    { "날짜" : formatDate(dt[4].loanDate).substr(5,10), '리볼빙' : dt[4].revolvingSum, '현금서비스' : dt[4].shortTermLoansSum, '카드론' : dt[4].longTermLoansSum},
			    { "날짜" : formatDate(dt[5].loanDate).substr(5,10), '리볼빙' : dt[5].revolvingSum, '현금서비스' : dt[5].shortTermLoansSum, '카드론' : dt[5].longTermLoansSum},
			    { "날짜" : formatDate(dt[6].loanDate).substr(5,10), '리볼빙' : dt[6].revolvingSum, '현금서비스' : dt[6].shortTermLoansSum, '카드론' : dt[6].longTermLoansSum}  
			  ],
			  xkey: "날짜", 
			  parseTime: false,
			  ykeys: ['리볼빙', '현금서비스', '카드론'],
			  labels: ['리볼빙', '현금서비스', '카드론'],
			  barColors: ["#386158", "#30907E", "#4CC39B"],
			  resize : true,
			  hideHover : "auto"
		});

}

</script>

<%-- 카카오톡 알림 메세지 보내기 --%>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>

Kakao.init('<!--키-->');

function sendTo() {
	Kakao.Auth.login({
		// 로그인 할 때 요청할 Scope
		scope: "TALK_MESSAGE",
		success : function(res) {
			Kakao.API.request({
				url : '/v2/api/talk/memo/send',
				data : {
					template_id : 37144, 							  // Kakao Developers에서 만든 Feed Template ID 지정
					args : '{"name": "소재원", "service" : "장기카드대출"}' // 매개변수로 지정한 name, service에 json 타입으로 전달.
				},
				success : function(res) {
					console.log(res);
				},
				fail : function(error) {
					console.log(error);
				}
			})
		},
		fail : function(error) {
			console.log(error)
		}
	})
}
</script>

  </head>
  
  <body class="nav-md footer_fixed">
  
	<div id="mask"></div>
	<div class="loader"><img src="${pageContext.request.contextPath}/resources/hana_img/loading.svg"/></div>
	  
  
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a class="site_title">
              <img src="${pageContext.request.contextPath}/resources/hana_img/hana_logo.png" style="width:50px; height:45px;">
              <span style="padding-top: 50px">&nbsp;&nbsp;Dashboard</span>
              </a>
            </div>
            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="${pageContext.request.contextPath}/resources/mask.png" class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>반갑습니다.</span>
                <h2>${employeeVO.ename} 님</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->
            <br/>

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-area-chart"></i> View Data <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="${pageContext.request.contextPath}/LoanData">Loan & Default Data</a></li>
                      <li><a href="${pageContext.request.contextPath}/PaymentData">Payment Data</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-group"></i> Cluster Data <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="${pageContext.request.contextPath}/ClusterData">Client Cluster Data</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-file-text-o"></i> My Memo <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">             
                      <li><a href="${pageContext.request.contextPath}/ShowMemo">Show Notebook</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-code"></i> Zeppelin Notebook<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="http://192.168.88.128:8089">Zeppelin Server</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-file-text-o"></i> Mailing Page <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li>&nbsp;&nbsp;&nbsp;<input type="button" value="정기 메일 송부" onclick="send()"></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="${pageContext.request.contextPath}/logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>
        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                <br>
                  <form class="form-horizontal">
                    <fieldset>
                      <div class="control-group">
                        <div class="controls">
                          <div class="input-prepend input-group">
                               
                          	</div>
                        	</div>
                      </div>
                    </fieldset>
                  </form>
              </div>  
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
	
        <!-- page content -->
        <div class="right_col" role="main" style="margin-bottom: 45px;">
            <div class="row top_tiles">
              <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon"><i class="fa fa-caret-square-o-right"></i></div>
                  <div class="count" id="revolvingCount"></div>
                  <h3>리볼빙</h3>
                  <p>신규 리볼빙 실행건수</p>
                </div>
              </div>
              <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon"><i class="fa fa-comments-o"></i></div>
                  <div class="count" id="stLoansCount"></div>
                  <h3>현금서비스</h3>
                  <p>신규 현금서비스 실행건수</p>
                </div>
              </div>
              <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon"><i class="fa fa-sort-amount-desc"></i></div>
                  <div class="count" id="ltLoansCount"></div>
                  <h3>카드론</h3>
                  <p>신규 카드론 실행건수</p>
                </div>
              </div>
              <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon"><i class="fa fa-check-square-o"></i></div>
                  <div class="count" id="defaultCount"></div>
                  <h3>연체</h3>
                  <p>신규 연체 발생건수</p>
                </div>
              </div>
            </div>            
            
 		<div class="clearfix"></div>
		<div class="row">
              <!-- line graph -->
              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>신규 대출서비스 이용 추이 <small>직전 7일 기준</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content2">
                    <div id="loansLineChart" style="width:100%; height:230px;" class="echart">       

                    </div>
                  </div>
                </div>
              </div>
              <!-- /line graph -->
              
              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>연체 발생 추이<small>직전 7일 기준</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                 	
                  <div id="lineChart" style="height:220px; witdh:100%;" class="echart"></div>
                  </div>
                </div>
              </div>
             </div>
             <div class="row">
              <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>대출 금액 합계</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <div id="bar_chart" style="width:100%; height:220px; "></div>

                  </div>
                </div>
             </div>
              
              <!-- /graph area -->         
              <%-- 단기/장기카드대출 만기 7일 이내의 손님 --%>
              <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>단기/장기카드대출 만기 7일 이내인 손님
                    	<button type="button" class="btn btn-success" style="border-radius: 20px; margin-left:65px" onclick="sendTo()">안내 발송 </button></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <div class="table-wrapper-scroll-y my-custom-scrollbar">
					  <table class="table table-bordered table-striped mb-0">
					    <thead>
					      <tr>
					        <th scope="col">아이디</th>
					        <th scope="col">대출종류</th>
					        <th scope="col">대출일</th>
					        <th scope="col">대출만기일</th>
					        <th scope="col">잔금</th>
					      </tr>
					    </thead>
					    <tbody>
					    <c:forEach var="client" items="${loansDueClient}">
					      <tr>
					        <th scope="row">${client.cid}</th>
					        <td>${client.loanClf}</td>
					        <td>${client.loanDate}</td>
					        <td>${client.loanDueDate}</td>
					        <td><fmt:formatNumber value="${client.loanBalance}" pattern="#,###"/>원</td>
					      </tr>
						</c:forEach>
					    </tbody>
					  </table>
					</div>

                 </div>
                </div>
              </div>
              </div>
             </div>
             </div>
             </div>
  
		
        <!-- /page content -->

	<c:import url="/include/footer.jsp"/>

    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="${pageContext.request.contextPath}/resources/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.js"></script>
    <!-- morris.js -->
    <script src="${pageContext.request.contextPath}/resources/vendors/raphael/raphael.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendors/morris.js/morris.min.js"></script>
	<!--  Echarts -->
	<script src="${pageContext.request.contextPath}/resources/vendors/echarts/dist/echarts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="${pageContext.request.contextPath}/resources/build/js/custom.min.js"></script>
	<!-- PNotify -->
    <script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.js"></script>
	
	<button type="button" data-toggle="modal" data-target=".bs-example-modal-lg" style="position:fixed; bottom:50px; right:20px; border:none;"> 
 		<img src="${pageContext.request.contextPath}/resources/memo.png" style="width:50px; height:50px;">
 	</button>
 	
    <div class="modal bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
       <div class="modal-dialog modal-lg">
         <div class="modal-content">
        	<div class="modal-body">
         	 <h4>메모지</h4>
         	 <label for="message">내용</label>
             <textarea id="memo" required="required" class="form-control" name="memo" data-parsley-trigger="keyup"></textarea>
			 </div>
		 </div>
         <div class="modal-footer">
             <button type="button" id="cancel" class="btn btn-default" data-dismiss="modal">취소</button>
             <button type="submit" class="btn btn-default source" onclick="saveMemo()">저장</button>
         </div>
      </div>
   </div>
  </body>
</html>