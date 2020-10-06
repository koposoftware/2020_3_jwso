<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>하나카드 소비 리포트</title>
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
<link href="${pageContext.request.contextPath}/resources/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet" />
<!-- bootstrap-daterangepicker -->
<link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="${pageContext.request.contextPath}/resources/build/css/custom.min.css" rel="stylesheet">

<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>

<style>
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

$(document).ready(function() {
 
	//손님이 한 달간 사용한 금액 / 지난 달 사용한 금액 / 같은 연령대의 평균소비금액 조회
	$.ajax({
			url : "${pageContext.request.contextPath}/selectPaidBetweenMonth",
			type : 'POST',
			success : function(data) {
				data = JSON.parse(data);
				$('#total').css("visibility", "visible");
				$('#totalText').css("visibility", "visible");
				
				$('#totalPaying').append(data[0].sumThisLastAgeGroup.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+ "원")
				let percentage = '';
				//증가
				if (data[0].sumThisLastAgeGroup - data[1].sumThisLastAgeGroup > 0) {
					percentage = (((data[0].sumThisLastAgeGroup - data[1].sumThisLastAgeGroup) / data[1].sumThisLastAgeGroup) * 100).toFixed();
					$('#compareUp').append(percentage + '%')
					$('#count_1').css("display", "inline");
					$('#compareUp').css("display", "inline");
					$('#compareUpText').css("display", "inline");
				//감소
				} else {
					percentage = (((data[0].sumThisLastAgeGroup - data[1].sumThisLastAgeGroup) / data[1].sumThisLastAgeGroup) * 100).toFixed();
					percentage = percentage.replace("-", "");
					$('#compareDown').append(percentage + '%')
					$('#count_1').css("display", "inline");
					$('#compareDown').css("display", "inline");
					$('#compareDownText').css("display", "inline");
				}

				if (data[0].sumThisLastAgeGroup	- data[2].sumThisLastAgeGroup > 0) {
					$('#sameAgeGroupPaying').append(data[2].sumThisLastAgeGroup.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원")
					$('#ageCompareUp').append((data[0].sumThisLastAgeGroup - data[2].sumThisLastAgeGroup).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))
					$('#count_2').css("display", "inline");
					$('#ageCompareUp').css("display", "inline");
					$('#ageCompareUpText').css("display", "inline");
				} else {
					$('#sameAgeGroupPaying').append(data[2].sumThisLastAgeGroup.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))
					$('#ageCompareDown').append((data[2].sumThisLastAgeGroup - data[0].sumThisLastAgeGroup).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))
					$('#count_2').css("display", "inline");
					$('#ageCompareDown').css("display", "inline");
					$('#ageCompareDownText').css("display", "inline");
				}
				
				
				
			},
			error : function() {
				alert('실패');
			}
		})

	// 주로 사용한 업종
	$.ajax({
			url : "${pageContext.request.contextPath}/selectMajorUseBusiness/${userVO.cid}",
			type : 'POST',
			success : function(data) {
				data = JSON.parse(data);
				var myChart = echarts
						.init(document.getElementById('majorUseBusiness'));
				var option = {
					tooltip : {
						trigger : 'item',
						formatter : '{a} <br/>{b}: {c} ({d}%)'
					},
					legend : {
						orient : 'horizontal',
						x : 'center',
						y : 'bottom',
						data : [ data[0].businessInfo,
								data[1].businessInfo,
								data[2].businessInfo,
								data[3].businessInfo,
								data[4].businessInfo ]
					},
					series : [ {
						name : '사용 업종 중분류',
						type : 'pie',
						center : [ '50%', '40%' ],
						radius : [ '20%', '60%' ],
						avoidLabelOverlap : false,
						itemStyle : {
				                normal : {
				                   label : {
				                      show : false
				                   },
				                   labelLine : {
				                      show : false
				                   }
				                }
				        },
						label : {
							show : false,
							position : 'center'
						},
						emphasis : {
							label : {
								show : false,
								fontSize : '30',
								fontWeight : 'bold'
							}
						},
						labelLine : {
							show : false
						},
						data : [ {
							value : data[0].sumPayment,
							name : data[0].businessInfo
						}, {
							value : data[1].sumPayment,
							name : data[1].businessInfo
						}, {
							value : data[2].sumPayment,
							name : data[2].businessInfo
						}, {
							value : data[3].sumPayment,
							name : data[3].businessInfo
						}, {
							value : data[4].sumPayment,
							name : data[4].businessInfo
						} ],
					} ]
				,color : ["#386158", "#30907E", "#4CC39B", "#B6E3D7", "#A4BCC3"]
				};
				myChart.setOption(option);
			},
			error : function() {
				alert('실패');
			}
		});

	// 주로 사용한 업종
	$.ajax({
			url : "${pageContext.request.contextPath}/selectClusterUsedCard/${userVO.cid}",
			type : 'POST',
			success : function(data) {
				data = JSON.parse(data);
				console.log(data);
				var myChart = echarts.init(document.getElementById('cardMaxCntPieChart'));
				var option = {
					tooltip : {
						trigger : 'item',
						formatter : '{a} <br/>{b}: {c} ({d}%)'
					},
					legend : {
						orient : 'horizontal',
						x : 'center',
						y : 'bottom',
						data : [ data[0].cardName,
								data[1].cardName,
								data[2].cardName,
								data[3].cardName ]
					},
					series : [ {
						name : '비슷한 사람들이 사용한 카드',
						type : 'pie',
						center : [ '50%', '40%' ],
						radius : [ '20%', '60%' ],
						avoidLabelOverlap : false,
						label : {
							show : false,
							position : 'center'
						},
						itemStyle : {
				                normal : {
				                   label : {
				                      show : false
				                   },
				                   labelLine : {
				                      show : false
				                   }
				                }
				        },
						emphasis : {
							label : {
								show : false,
								fontSize : '30',
								fontWeight : 'bold'
							}
						},
						labelLine : {
							show : false
						},
						data : [
								{
									value : data[0].cardUsedCnt,
									name : data[0].cardName
								},
								{
									value : data[1].cardUsedCnt,
									name : data[1].cardName
								},
								{
									value : data[2].cardUsedCnt,
									name : data[2].cardName
								},
								{
									value : data[3].cardUsedCnt,
									name : data[3].cardName
								},
								{
									value : data[4].cardUsedCnt,
									name : data[4].cardName
								} ],
					} ]
				,color : ["#386158", "#30907E", "#4CC39B", "#B6E3D7", "#A4BCC3"]
				};
				myChart.setOption(option);
			},
			error : function() {
				alert('실패');
			}
		});
});

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
						<a class="site_title"> <img src="${pageContext.request.contextPath}/resources/hana_img/hana_logo.png" style="width: 50px; height: 45px;"> 
						<span style="margin-top: 80px; padding-left:10px;">하나카드</span>
						</a>
					</div>
					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile clearfix">
						<div class="profile_pic">
							<img src="${pageContext.request.contextPath}/resources/mask.png" class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<small style="color:white">반갑습니다. ${userVO.cid} 손님! <br/>
													       함께한 시간 +${userVO.regPeriod}일</small><br/>
						</div>
					</div>
					<!-- /menu profile quick info -->
					<br />


					<!-- /menu footer buttons -->
					<div class="sidebar-footer hidden-small">
						<a data-toggle="tooltip" data-placement="top" title="Settings">
							<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="FullScreen">
							<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Lock"> <span
							class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Logout" href="${pageContext.request.contextPath}/clientLogout"> 
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
							<a id="menu_toggle"><i class="fa fa-bars"></i></a> <br>
						</div>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<!-- top tiles -->
				<div class="row tile_count">
				
					<div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
						<span class="count_top"><i class="fa fa-user"></i>이번 달 청구 금액</span>
						<div class="count green" id="total" style="visibility : hidden">
							<c:set var="last" value="0"/>
								<c:forEach var="hist" items="${history}" varStatus="status">
									<c:choose>
									<c:when test="${hist.instPlan ne 0}"> 
											<c:set var="last" value="${last + hist.dailyPayment/hist.instPlan}"/>
									</c:when> 
									<c:otherwise> 
											<c:set var="last" value="${last + hist.dailyPayment}"/>
									</c:otherwise>
									</c:choose>
								</c:forEach>
								
							<c:set var="remain" value="0"/>
								<c:forEach var="remainHist" items="${remainHistory}" varStatus="status">
									<c:set var="remain" value="${remain + remainHist.dailyPayment/remainHist.instPlan}"/>
								</c:forEach>
								
							<fmt:formatNumber value="${last + remain}" pattern="#,###"/>원
						</div>
						<span class="count_bottom" style="visibility : hidden" id="totalText">결제기간동안 사용한 금액(할부+일시불) + 남은 할부 사용금액</span>
					</div>
				
					<div class="col-md-4 col-sm-3 col-xs-2 tile_stats_count">
						<span class="count_top" ><i class="fa fa-user"></i>사용하신 금액 </span>
						<div class="count green" id="totalPaying"></div>
						<span class="count_bottom" id="count_1" style="display: none;">손님의 이전 결제일 금액보다 
							<i class="red" id="compareUp" style="display: none;"></i> 
							<span class="count_bottom" id="compareUpText" style="display: none;">증가했습니다!</span>
							<i class="green" id="compareDown"></i> 
							<span class="count_bottom" id="compareDownText" style="display: none;">감소했습니다!</span>
						</span>
					</div>
					<br>
					<div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
						<span class="count_top"><i class="fa fa-user"></i>손님과 동일한 연령대, 성별의 평균 결제금액 </span>
						<div class="count green" id="sameAgeGroupPaying"></div>
						<span class="count_bottom" id="count_2" style="display: none;">손님은 
							<i class="red" id="ageCompareUp"></i> 
							<span class="ageCompareUpText" id="ageCompareUpText" style="display: none;">원 더 사용했습니다!</span> 
							<i class="green" id="ageCompareDown"></i> 
							<span class="count_bottom" id="ageCompareDownText" style="display: none;">원 덜 사용했습니다!</span>
						</span>
					</div>
				
				</div>
				<!-- /top tiles -->

				<!-- 한 달간 소비내역 -->
				<div class="row" style="margin-bottom: 46px;">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>
									결제내역 <small>지난 달 1일 ~ 말일까지 결제한 내역입니다.</small>
								</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<table class="table table-bordered table-striped mb-0">
									<thead>
										<tr>
											<th>날짜</th>
											<th>카드명</th>
											<th>사용지역</th>
											<th>사용처</th>
											<th>금액</th>
											<th>할부개월수</th>
											<th>잔여할부개월수</th>
										</tr>
									</thead>
									<tbody id="content">
										<c:set var="sum" value="0" scope="session"/>
										<c:forEach var="hist" items="${history}" varStatus="status">
											<tr>
												<td>${hist.transactionDate}</td>
										        <td>${hist.usingCardName}</td>
												<td>${hist.paymentArea}</td>
												<td>${hist.businessType}</td>
												<td><fmt:formatNumber value="${hist.dailyPayment}" pattern="#,###"/>원</td>
											<c:choose> 
											<c:when test="${hist.instPlan ne 0}"> 
													<c:set var="sum" value="${sum + hist.dailyPayment/hist.instPlan}"/>
													<td>${hist.instPlan}개월</td>
													<td>${hist.instPlan - 1} 개월</td>
											</c:when> 
											<c:otherwise> 
													<c:set var="sum" value="${sum + hist.dailyPayment}"/>
													<td>일시불</td>
													<td>해당없음</td>
											</c:otherwise>
											</c:choose> 
											</tr>
												<c:if test="${status.last}">
												<tr>
											   		<td colspan="3"></td>
											   		<td><strong>이번 달 청구금액</strong></td>
											      	<td><strong><fmt:formatNumber value="${sum}" pattern="#,###"/>원</strong></td>
											      	<td colspan="2"></td>
												</tr>
												</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<br />
					
					<%-- 잔여 할부 --%>
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>
									잔여 할부내역 <small>이번 결제일 내역 이전에 결제된 거래 중, 아직 할부가 남은 결제의 내역입니다.</small>
								</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<table class="table table-bordered table-striped mb-0">
									<thead>
										<tr>
											<th>날짜</th>
											<th>카드명</th>
											<th>사용지역</th>
											<th>사용처</th>
											<th>금액</th>
											<th>할부개월수</th>
											<th>잔여할부개월수</th>
										</tr>
									</thead>
									<tbody id="remainContent">
										<c:set var="remainSum" value="0" scope="session"/>
										<c:forEach var="remainHist" items="${remainHistory}" varStatus="status">
											<c:set var="remainSum" value="${remainSum + remainHist.dailyPayment/remainHist.instPlan}"/>
											<tr>
												<td>${remainHist.transactionDate}</td>
										        <td>${remainHist.usingCardName}</td>
												<td>${remainHist.paymentArea}</td>
												<td>${remainHist.businessType}</td>
												<td><fmt:formatNumber value="${remainHist.dailyPayment}" pattern="#,###"/>원</td>
												<td>${remainHist.instPlan}개월</td>
												<td>${remainHist.remainInst}개월</td>
											</tr>
											<c:if test="${status.last}">
											<tr>
												<td colspan="3"></td>
												<td><strong>이번 달 청구금액</strong></td>
												<td><strong><fmt:formatNumber value="${remainSum}" pattern="#,###"/>원</strong></td>
												<td colspan="2"></td>
											</tr>
											</c:if>
										</c:forEach>					
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<br />
					<!-- 손님과 동일한 집단(군집)이 많이 사용하는 카드  -->
					<div class="col-md-4 col-sm-4 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>나와 비슷한 사람들이 사용한 카드</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        				<ul class="dropdown-menu" role="menu">
                          					<li><a href="#">Settings 1</a></li>
                         					<li><a href="#">Settings 2</a></li>
                        				</ul>
                      				</li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div id="cardMaxCntPieChart" style="height: 340px; width: 100%;"></div>
						</div>
					</div>
					<!-- 업종 별 소비금액 -->
					<div class="col-md-4 col-sm-4 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>나의 업종 별 소비금액</h2>
								<ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<i class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">

								<div id="majorUseBusiness" style="height: 330px;"></div>

							</div>
						</div>
					</div>
					<!-- /업종 별 소비금액 -->
              
              <!-- 진행중인 이벤트 -->
              <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="x_panel" style="height:413px;">
                  <div class="x_title">
                    <h2><strong>진행중인 이벤트</strong></h2>
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
					        <th scope="col">진행중인 이벤트</th>
					      </tr>
					    </thead>
					    <tbody>
					    <tr>
					        <th scope="row">
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5207">
					        <span style="color: orange;">모두의 건강 카드 출시 기념 이벤트!</span>
					        </a>
					        </th>
					    </tr> 
					    <tr>  
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5227">
					        <span style="color: orange;">추석 특집 독일 명품 아울렛 쇼핑 꿀팁!</span>
					        </a>
					        </th>
					    </tr>    
					    <tr>
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5220">
					        <span style="color: orange;">부킹닷컴 최대 10% 캐쉬백 이벤트!</span>
					        </a>
					        </th>
					    </tr>
					    <tr>    
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5259">
					        <span style="color: orange;">오직 하나카드만 가능! 항공, 숙박 할인 받고 경품까지!</span>
					        </a>
					        </th>
					    </tr>
					    <tr>    
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5256">
					        <span style="color: orange;">생활요금 자동납부 X 10월은 독서의 계절</span>
					        </a>
					        </th>
					    </tr>
					    <tr>    
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5267">
					        <span style="color: orange;">자동차 구매 오토캐쉬백 이벤트</span>
					        </a>
					        </th>
					    </tr>
					    <tr>    
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5228">
					        <span style="color: orange;">코웨이 렌탈하면 최대 25만 하나머니 적립!</span>
					        </a>
					        </th>
					    </tr>
					    <tr>    
					        <th>
					        <a href="https://www.hanacard.co.kr/OPP35000001D.web?schID=ncd&mID=OPP35000001D&EVN_SEQ=5134">
					        <span style="color: orange;">하나은행으로 결제계좌 변경 시, 스타벅스 아메리카노 6잔!</span>
					        </a>
					        </th>
					    </tr>
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

	<!-- footer content -->
	<footer>
		<div class="pull-right">©2020 Jaewon So, Super! All Rights Reserved.</div>
		<div class="clearfix"></div>
	</footer>
	<!-- /footer content -->

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="${pageContext.request.contextPath}/resources/vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.js"></script>
	<!-- Chart.js -->
	<script src="${pageContext.request.contextPath}/resources/vendors/Chart.js/dist/Chart.min.js"></script>
	<!-- iCheck -->
	<script src="${pageContext.request.contextPath}/resources/vendors/iCheck/icheck.min.js"></script>
	<!-- Skycons -->
	<script src="${pageContext.request.contextPath}/resources/vendors/skycons/skycons.js"></script>
	<!-- DateJS -->
	<script src="${pageContext.request.contextPath}/resources/vendors/DateJS/build/date.js"></script>
	<!-- JQVMap -->
	<script src="${pageContext.request.contextPath}/resources/vendors/jqvmap/dist/jquery.vmap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
	<!-- Custom Theme Scripts -->
	<script src="${pageContext.request.contextPath}/resources/build/js/custom.min.js"></script>
	<!-- ECharts -->
	<script src="${pageContext.request.contextPath}/resources/vendors/echarts/dist/echarts.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/echarts/map/js/world.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/echarts/dist/echarts.js"></script>

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
