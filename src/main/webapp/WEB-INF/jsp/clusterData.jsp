<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-progressbar -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="${pageContext.request.contextPath}/resources/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/resources/build/css/custom.min.css" rel="stylesheet">  
    <!-- PNotify -->
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
function send() {
	$.ajax({
		url : "${pageContext.request.contextPath}/mail",
		type : "GET",
		success : function() {
			alert('성공')
		},
		error : function () {
			alert('실패');
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

var radarData = '';

$.ajax({
	url : "${pageContext.request.contextPath}/selectClusterRadar",
	type: 'POST',
	async : false,
	success : function(data) {
		radarData = JSON.parse(data);
	}, error : function() {
		alert('실패');
	}
});
$.ajax({
	url : "${pageContext.request.contextPath}/selectClusterRadar",
	type: 'POST',
	success : function(data) {
		data = JSON.parse(data);
		var myChart = document.getElementById('clusterRadar0');
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[0].codeInfo, data[1].codeInfo, data[2].codeInfo,
						   data[3].codeInfo, data[4].codeInfo, data[5].codeInfo ],
				datasets : [
					{
						label : 'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[0].useCnt, data[1].useCnt, data[2].useCnt, 
								 data[3].useCnt, data[4].useCnt, data[5].useCnt] 
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar1');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[6].codeInfo, data[7].codeInfo,  data[8].codeInfo,
						   data[9].codeInfo, data[10].codeInfo, data[11].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[6].useCnt, data[7].useCnt, data[8].useCnt, data[9].useCnt, data[10].useCnt, data[11].useCnt ]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar2');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[12].codeInfo, data[13].codeInfo,  data[14].codeInfo,
						   data[15].codeInfo, data[16].codeInfo,  data[17].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[12].useCnt, data[13].useCnt, data[14].useCnt, data[15].useCnt, data[16].useCnt, data[17].useCnt ]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar3');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[18].codeInfo, data[19].codeInfo,  data[20].codeInfo,
						   data[21].codeInfo, data[22].codeInfo,  data[23].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[18].useCnt, data[19].useCnt, data[20].useCnt, data[21].useCnt, data[22].useCnt, data[23].useCnt ]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar4');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[24].codeInfo, data[25].codeInfo,  data[26].codeInfo,
						   data[27].codeInfo, data[28].codeInfo,  data[29].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[24].useCnt, data[25].useCnt,   data[26].useCnt,
							   	 data[27].useCnt, data[28].useCnt, 	 data[29].useCnt]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar5');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[30].codeInfo, data[31].codeInfo,  data[32].codeInfo,
						   data[33].codeInfo, data[34].codeInfo,  data[35].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[30].useCnt, data[31].useCnt,   data[32].useCnt,
							   	 data[33].useCnt, data[34].useCnt, 	 data[35].useCnt]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar6');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[36].codeInfo, data[37].codeInfo,  data[38].codeInfo,
						   data[39].codeInfo, data[40].codeInfo,  data[41].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[36].useCnt, data[37].useCnt,   data[38].useCnt,
							   	 data[39].useCnt, data[40].useCnt, 	 data[41].useCnt]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar7');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[42].codeInfo, data[43].codeInfo,  data[44].codeInfo,
						   data[45].codeInfo, data[46].codeInfo,  data[47].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[42].useCnt, data[43].useCnt,   data[44].useCnt,
							   	 data[45].useCnt, data[46].useCnt, 	 data[47].useCnt]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar8');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				labels : [ data[48].codeInfo, data[49].codeInfo,  data[50].codeInfo,
						   data[51].codeInfo, data[52].codeInfo,  data[53].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[48].useCnt, data[49].useCnt,   data[50].useCnt,
							   	 data[51].useCnt, data[52].useCnt, 	 data[53].useCnt]
					}
				]
			}
		})
		
		var myChart = document.getElementById('clusterRadar9');
		
		var radarChart = new Chart(myChart, {
			type : 'radar', 
			options: {
		        legend: {
		            display: false
		        }
			},
			data : {
				fillOpacity: .3,
				labels : [ data[54].codeInfo, data[55].codeInfo,  data[56].codeInfo,
						   data[57].codeInfo, data[58].codeInfo,  data[59].codeInfo ],
				datasets : [
					{
						label :  'Count',
						backgroundColor : 'rgb(194, 230, 219, 0.6)',
						borderColor : 'rgb(70, 186, 155)',
						borderWidth : 2,
						data : [ data[54].useCnt, data[55].useCnt,   data[56].useCnt,
							   	 data[57].useCnt, data[58].useCnt, 	 data[59].useCnt]
					}
				]
			}
		})
	},
	
	error : function() {
		alert('실패');
	}
});

$(function(){
	$.ajax({
		url : "${pageContext.request.contextPath}/selectClusterExplain",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
			for(var i = 0; i < data.length; i++) {
				let str = "<small style='font-size:13px;'>" + data[i].clusterNo + "번 군집</br>"
					str += "포함된 손님 수          : <strong>" + data[i].population.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</strong>명 </br>";
					str += "평균 연령                 : <strong>" + data[i].avgAge + "</strong>세</br>";
					str += "평균 소득                 : <strong>" + data[i].avgMonthlyIncome.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</strong>원</br>";
					str += "평균 사용금액           : <strong>" + data[i].avgMonthlyIncome.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</strong>원</br>";
					str += "평균 할부 개월 수      : <strong>" + data[i].avgInst + "</strong>개월</br>";
					str += "가장 많이 사용한 카드: <strong>" + data[i].cardName + "카드 (" + data[i].cardUsageCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 회)</strong></br>";
					str += "주 사용처                 : <strong>" + radarData[i*6].codeInfo + ", " + radarData[i*6+1].codeInfo + ", " + radarData[i*6+2].codeInfo + ", " 
										   + radarData[i*6+3].codeInfo + ", " + radarData[i*6+4].codeInfo + ", " + radarData[i*6+5].codeInfo + "</strong></small>" 
					$('#c'+ i).html(str);
			}
		},
		error : function() {
			alert('실패');
		}
	});

})

</script>

  </head>
  
  
  <body class="nav-md footer_fixed">
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
              </div>  
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
        <!-- page content -->
        <div class="right_col" role="main"  style="margin-bottom: 45px;">
		<!-- radar chart -->
        <div class="col-md-4 col-sm-3 col-xs-3">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>0번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar0" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                <div class="x_panel">
                  <div class="x_title">
                    <h2>1번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar1" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                <div class="x_panel">
                  <div class="x_title">
                    <h2>2번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar2" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                <div class="x_panel">
                  <div class="x_title">
                    <h2>3번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar3" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                <div class="x_panel">
                  <div class="x_title">
                    <h2>4번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar4" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                 <div class="x_panel">
                  <div class="x_title">
                    <h2>5번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar5" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                 <div class="x_panel">
                  <div class="x_title">
                    <h2>6번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar6" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                 <div class="x_panel">
                  <div class="x_title">
                    <h2>7번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar7" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                 <div class="x_panel">
                  <div class="x_title">
                    <h2>8번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar8" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
                
                 <div class="x_panel">
                  <div class="x_title">
                    <h2>9번 군집</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="clusterRadar9" style="height:200px; width:100%"></canvas>
                  </div>
                </div>
        </div>
              
        <div class="right_col" role="main">

            <div class="row">
              <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>0번 군집 요약 <small>Summary of No.0 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c0">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
              
			
			<div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>1번 군집 요약 <small>Summary of No.1 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:181px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c1">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>


			  <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>2번 군집 요약 <small>Summary of No.2 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c2">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
              
              
              <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>3번 군집 요약 <small>Summary of No.3 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:179px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c3">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
              
              
              <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>4번 군집 요약 <small>Summary of No.4 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c4">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>

			  <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>5번 군집 요약 <small>Summary of No.5 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c5">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>	

			
			<div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>6번 군집 요약 <small>Summary of No.6 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c6">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>

			 <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>7번 군집 요약 <small>Summary of No.7 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c7">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>


			<div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>8번 군집 요약 <small>Summary of No.8 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c8">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
	
			 <div class="col-md-9">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>9번 군집 요약 <small>Summary of No.9 cluster</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class=".col-xs-11 .col-md-9" style="height:180px !important;">
                      <!-- blockquote -->
                      <blockquote>
                        <p id="c9">
                      </blockquote>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>	
              
			<div>
			
			</div>
		<!-- 요약 -->


            </div>
		 </div>
		 </div>
		 
  		
        <!-- /page content -->
        
        </div>
       </div>
      
        <!-- footer content -->
        <footer>
          <div class="pull-right">
           ©2020 Jaewon So, Super! All Rights Reserved.
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
        
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="${pageContext.request.contextPath}/resources/vendors/fastclick/lib/fastclick.js"></script>
     <!-- Custom Theme Scripts -->
    <script src="${pageContext.request.contextPath}/resources/build/js/custom.min.js"></script>
	<!-- ECharts -->
    <script src="${pageContext.request.contextPath}/resources/vendors/echarts/dist/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendors/echarts/map/js/world.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/echarts/dist/echarts.js"></script>
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
