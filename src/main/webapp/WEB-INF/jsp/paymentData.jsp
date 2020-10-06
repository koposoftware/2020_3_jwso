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
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- bootstrap-progressbar -->
    <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="${pageContext.request.contextPath}/resources/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/resources/build/css/custom.min.css" rel="stylesheet">
    <!-- PNotify -->
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
<style>
#overlayChart {
	width:100% !important; 
	height:370px !important;
}
#container {
	width : 500px;
	height : 730px;
}
#states path {
    fill: #585858;
    stroke: #000000;
    stroke-width: 1.0px;
}

#states path:hover {
    fill: #009300;
}

#states .active {
    fill: #00b700;
}

#states .activeDetail {
    fill: #00b700;
}

#states path {
    cursor: pointer;
}

#states text {
    cursor: pointer;
    font-size: 12px;
    fill: #000000;
}

 rect #background{
	color:white;
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
<script src=https://cdnjs.cloudflare.com/ajax/libs/d3/3.1.7/d3.js></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/d3/js/d3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/d3/js/korea.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script>
$(document).ready(function(){
	  $('[data-toggle="tooltip"]').tooltip();   
	});
	
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

var sca = '01';
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
$(document).ready( function() {
	<%-- 온라인/오프라인/할부/일시불/국내/해외결제에 가장 많이 쓰인 카드 --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/selectTopCard",
		type : 'POST',
		success : function(data) {
			data = JSON.parse(data);
			console.log(data);
				
			$('#topOnline').text(data.topOnline);
			$('#onlineCnt').text(data.maxOnlineCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회");
			$('#topOffline').text(data.topOffline);
			$('#offlineCnt').text(data.maxOfflineCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회");
			$('#topInst').text(data.topInst);
			$('#instCnt').text(data.maxInstCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회");
			$('#topLumbSum').text(data.topLumbSum);
			$('#lumbSumCnt').text(data.maxLumbSumCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회");
			$('#topDom').text(data.topDom);
			$('#domCnt').text(data.maxDomCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회");
			$('#topOverseas').text(data.topOverseas);
			$('#overseasCnt').text(data.maxOverseasCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회");
		},
		error : function() {
			alert('실패');
		}
	});
	
	<%-- Select Client Data --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/clientData",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data)
 			$('#totCnt').text((data.totCnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#maleCnt').text((data.maleCnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명 (" + ( (data.maleCnt / data.totCnt) * 100).toFixed(1) + ")%");
			$('#femaleCnt').text((data.femaleCnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명 (" + ((data.femaleCnt / data.totCnt) * 100).toFixed(1) + ")%");
			$('#group20Cnt').text(((data.group20Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#group30Cnt').text(((data.group30Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#group40Cnt').text(((data.group40Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#group50Cnt').text(((data.group50Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#group60Cnt').text(((data.group60Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#group70Cnt').text(((data.group70Cnt / data.totCnt) * 100).toFixed(1) + "%");
		},
		error : function() {
			alert('실패')
		}
	});
	
	<%-- Select Client Data --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/selectYesterdayClientCnt",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data)
			console.log(data);
 			$('#yesterdayTotCnt').text((data.totCnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#yesterdayMaleCnt').text((data.maleCnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명 (" + ( (data.maleCnt / data.totCnt) * 100).toFixed(1) + ")%");
			$('#yesterdayFemaleCnt').text((data.femaleCnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명 (" + ((data.femaleCnt / data.totCnt) * 100).toFixed(1) + ")%");
			$('#yesterdayGroup20Cnt').text(((data.group20Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#yesterdayGroup30Cnt').text(((data.group30Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#yesterdayGroup40Cnt').text(((data.group40Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#yesterdayGroup50Cnt').text(((data.group50Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#yesterdayGroup60Cnt').text(((data.group60Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#yesterdayGroup70Cnt').text(((data.group70Cnt / data.totCnt) * 100).toFixed(1) + "%");
			$('#yesterdayGroup20Cnti').text("전체 가입자수 중 " + (data.group20Cnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#yesterdayGroup30Cnti').text("전체 가입자수 중 " + (data.group30Cnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#yesterdayGroup40Cnti').text("전체 가입자수 중 " + (data.group40Cnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#yesterdayGroup50Cnti').text("전체 가입자수 중 " + (data.group50Cnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#yesterdayGroup60Cnti').text("전체 가입자수 중 " + (data.group60Cnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
			$('#yesterdayGroup70Cnti').text("전체 가입자수 중 " + (data.group70Cnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "명");
		},
		error : function() {
			alert('실패')
		}
	});

	<%-- select payment data --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/paymentData",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
				
			var oChart = $('#overlayChart');
			var myLineChart = new Chart(oChart, {
				type: 'line',
				data : {
					labels : [
						data[7].transactionDate, data[8].transactionDate, data[9].transactionDate, data[10].transactionDate, 
						data[11].transactionDate, data[12].transactionDate, data[13].transactionDate
					],
					datasets :[
						{
							label : [
								data[7].transactionDate, data[8].transactionDate, data[9].transactionDate, data[10].transactionDate, 
								data[11].transactionDate, data[12].transactionDate, data[13].transactionDate	
							],
							data : [
								data[7].paymentSum, data[8].paymentSum, data[9].paymentSum, data[10].paymentSum, 
								data[11].paymentSum, data[12].paymentSum, data[13].paymentSum
							],
							borderColor: "rgba(70, 186, 155, 0.9)",
				            backgroundColor: "rgba(70, 186, 155, 0.7)",
				            showLine: false,
				            borderWidth : 1,
				            pointRadius : 0
						},
						{
							label : [
								data[0].transactionDate, data[1].transactionDate, data[2].transactionDate, data[3].transactionDate, 
								data[4].transactionDate, data[5].transactionDate, data[6].transactionDate	
							],
							data : [
								data[0].paymentSum, data[1].paymentSum, data[2].paymentSum, data[3].paymentSum, 
								data[4].paymentSum, data[5].paymentSum, data[6].paymentSum	
							],
							borderColor: "rgba(118, 135, 156, 0.5)",
				            backgroundColor: "rgba(118, 135, 156, 0.4)",
				            showLine: false,
				            borderWidth : 1,
				            pointRadius : 0
						}
					]
				},
				options: {
					responsive: true,
					scales : {
						yAxes : [{
							ticks : {
			                 	display: true,
			                	callback: function (value, index, values) {
			                       		value=value.toString();
			                       		value=value.split(/(?=(?:...)*$)/);
			                       		value=value.join(',');
			                       		return value;
			                  	},
								fontSize : 11
							}
						}],
						xAxes: [{
							ticks:{
								fontSize : 11
							}
						}],
						labels : {
							fontSize : 11
						}
					}
				}
			})
		},
		error : function() {
			alert('실패')
		}
	});
	
	$.ajax({
		url : "${pageContext.request.contextPath}/selectPaymentClf",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
			
			var str = 
				' <div class="progress progress_sm" style="width: 76%;" id="lumbSumCnt">' +
				'<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="' +
				(((data.totCnt - data.instCnt) / data.totCnt) * 100).toFixed() + 
				'" aria-valuenow="58" style="width:' +
				(((data.totCnt - data.instCnt) / data.totCnt) * 100).toFixed() + '%;"></div></div>'
		    $('.lumbSumCnt').append(str);
		    $('#lumbSumCntP').append((((data.totCnt - data.instCnt) / data.totCnt) * 100).toFixed() + "%");
		    
		    var str = 
				' <div class="progress progress_sm" style="width: 76%;" id="instCnt">' +
				'<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="' +
				((data.instCnt / data.totCnt) * 100).toFixed() + 
				'" aria-valuenow="58" style="width:' +
				((data.instCnt / data.totCnt) * 100).toFixed() + '%;"></div></div>'
		    $('.instCnt').append(str);
		    $('#instCntP').append(((data.instCnt / data.totCnt) * 100).toFixed() + "%");
		    
		    var str = 
				' <div class="progress progress_sm" style="width: 76%;" id="overseasCnt">' +
				'<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="' +
				(((data.totCnt - data.domCnt) / data.totCnt) * 100).toFixed() + 
				'" aria-valuenow="58" style="width:' +
				(((data.totCnt - data.domCnt) / data.totCnt) * 100).toFixed() + '%;"></div></div>'
		    $('.overseasCnt').append(str);
		    $('#overseasCntP').append((((data.totCnt - data.domCnt) / data.totCnt) * 100).toFixed() + "%");
		    
		    var str = 
				' <div class="progress progress_sm" style="width: 76%;" id="domCnt">' +
				'<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="' +
				((data.domCnt / data.totCnt) * 100).toFixed() +
				'" aria-valuenow="58" style="width:' +
				((data.domCnt / data.totCnt) * 100).toFixed() + '%;"></div></div>'
		    $('.domCnt').append(str);
		    $('#domCntP').append(((data.domCnt / data.totCnt) * 100).toFixed() + "%");
		    
		    var str = 
				' <div class="progress progress_sm" style="width: 76%;" id="onlineCnt">' +
				'<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="' +
				((data.onlineCnt / data.totCnt) * 100).toFixed() +
				'" aria-valuenow="58" style="width:' +
				((data.onlineCnt / data.totCnt) * 100).toFixed() + '%;"></div></div>'
		    $('.onlineCnt').append(str);
		    $('#onlineCntP').append(((data.onlineCnt / data.totCnt) * 100).toFixed() + "%");
		    
		    var str = 
				' <div class="progress progress_sm" style="width: 76%;" id="offlineCnt">' +
				'<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="' +
				(((data.totCnt - data.onlieCnt) / data.totCnt) * 100).toFixed() +
				'" aria-valuenow="58" style="width:' +
				(((data.totCnt - data.onlineCnt) / data.totCnt) * 100).toFixed() + '%;"></div></div>'
		    $('.offlineCnt').append(str);
		    $('#offlineCntP').append( (((data.totCnt - data.onlineCnt) / data.totCnt) * 100).toFixed() + "%");

		},
		error : function() {
			alert('실패')
		}
	});
	
	$.ajax({
		url : "${pageContext.request.contextPath}/selectCardCnt",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
			var myChart = echarts.init(document.getElementById('cardMaxCntPieChart'));
			var option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        x : 'center',
			        y : 'bottom',
			        data:[ data[0].cardName, data[1].cardName, data[2].cardName, data[3].cardName, data[4].cardName ],
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            magicType : {
			                show: true,
			                type: ['pie', 'funnel']
			            },
			        }
			    },
			    calculable : true,
			    series : [
			        {
			            name:'카드사용 비율',
			            type:'pie',
			            radius : [20, 110],
			            center: ['50%', '38%'],
			            roseType : 'area',
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
			            data:[
			                {value:data[0].cardPaidCnt + 24000, name: data[0].cardName},
			                {value:data[1].cardPaidCnt + 15000, name: data[1].cardName},
			                {value:data[2].cardPaidCnt + 3300, name: data[2].cardName},
			                {value:data[3].cardPaidCnt, name: data[3].cardName},
			                {value:data[4].cardPaidCnt, name: data[4].cardName}
			            ]
			        }
			    ]
			    ,color : ["#4CC39B", "#386158", "#30907E", "#B6E3D7", "#A4BCC3"]
			};

			myChart.setOption(option);

		},
		error : function() {
			alert('실패');
		}
	});

	$.ajax({
		url : "${pageContext.request.contextPath}/paidSumByAge",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
		    var myChart = echarts.init(document.getElementById('paidSumByAgeGroupPieChart'));
			var option = {
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        x : 'center',
				        y : 'bottom',
				        data:["40대", "50대", "30대", "20대", "60대", "70대" ]
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            magicType : {
				                show: true,
				                type: ['pie', 'funnel']
				            },
				        }
				    },
				    calculable : true,
				    series : [
				        {
				            name:'연령대별 카드결제금액',
				            type:'pie',
				            radius : [20, 110],
				            center: ['50%', '38%'],
				            roseType : 'area',
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
				            data:[
				                {value:data[2].paidSum, name: data[2].groups},
				                {value:data[3].paidSum, name: data[3].groups},
				                {value:data[1].paidSum, name: data[1].groups},
				                {value:data[0].paidSum, name: data[0].groups},
				                {value:data[4].paidSum, name: data[4].groups},
				                {value:data[5].paidSum, name: data[5].groups},
				            ]
				        }
				    ]
				    ,color : ["#4CC39B", "#386158", "#30907E", "#B6E3D7", "#A4BCC3"]
				};
				myChart.setOption(option);
			},
		error : function() {
			alert('실패');
		}
	});

	
	$.ajax({
		url : "${pageContext.request.contextPath}/cntBusiness",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
		    var myChart = echarts.init(document.getElementById('majorBusiness'));
			var option = {
				    tooltip: {
				        trigger: 'item',
				        formatter: '{a} <br/>{b}: {c} ({d}%)'
				    },
				    legend: {
				        orient: 'horizontal',
				        x : 'center',
				        y : 'bottom',
				        data: [ data[0].codeInfo, data[1].codeInfo, data[2].codeInfo, data[3].codeInfo,
				        		data[4].codeInfo, data[5].codeInfo]
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            magicType : {
				                show: true,
				                type: ['pie', 'funnel']
				            },
				        }
				    },
				    series: [
				        {
				        	name: '사용처 중분류',
				            type: 'pie',
				            center: ['50%', '38%'],
				            radius: ['40%', '60%'],
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
				            data: [
				                {value: data[0].useCnt, name: data[0].codeInfo },
				                {value: data[1].useCnt, name: data[1].codeInfo },
				                {value: data[2].useCnt, name: data[2].codeInfo },
				                {value: data[3].useCnt, name: data[3].codeInfo },
				                {value: data[4].useCnt, name: data[4].codeInfo },
				                {value: data[5].useCnt, name: data[5].codeInfo }
				            ],
				        }
				    ],
				    color : ["#4CC39B", "#386158", "#30907E", "#B6E3D7", "#A4BCC3", "#F0F0F0"]
				    
				};	
				myChart.setOption(option);
			},
		error : function() {
			alert('실패');
		}
	});
	
	<%-- 전일 지역별 결제금액 --%>
	$.ajax({
		url : "${pageContext.request.contextPath}/sumByRegion",
		type: 'POST',
		success : function(data) {
			data = JSON.parse(data);
			console.log(data)
			//colors = ['#108757', '#11935F', '#13A268', '#15B374', '#17C47E', '#1AD58A', '#21E496', '#3EE8A4', '#63ED86', '#8BF1C9'] //10개
			
			for (let i = 0; i < data.length; i++) {
				switch(data[i].paymentArea){
				case "서울" :
							if (i < 1) {
								$('path#path-Seoul').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Seoul').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Seoul').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Seoul').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Seoul').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Seoul').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Seoul').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Seoul').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Seoul').css("fill", "#63ED86");
							} else {
								$('path#path-Seoul').css("fill", "#8BF1C9");
							}
							$('path#path-Seoul').on("click", 
														function() {
															$('#information').html( "서울특별시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원    "
																				  				+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회 "   )
														})
							break;
				case "경기" : 
							if(i < 1) {
								$('path#path-Gyeonggi-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Gyeonggi-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Gyeonggi-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Gyeonggi-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Gyeonggi-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Gyeonggi-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Gyeonggi-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Gyeonggi-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Gyeonggi-do').css("fill", "#63ED86");
							} else {
								$('path#path-Gyeonggi-do').css("fill", "#8BF1C9");
							}
							$('path#path-Gyeonggi-do').on("click", 
									function() {
										$('#information').html( "경기도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 							  + data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회"  )
									})
							break;
				case "인천" : 
							if(i < 1) {
								$('path#path-Incheon').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Incheon').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Incheon').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Incheon').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Incheon').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Incheon').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Incheon').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Incheon').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Incheon').css("fill", "#63ED86");
							} else {
								$('path#path-Incheon').css("fill", "#8BF1C9");
							}
							$('path#path-Incheon').on("click", 
									function() {
										$('#information').html( "인천광역시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
									})
						
							break;
				case "부산" : 
							if(i < 1) {
								$('path#path-Busan').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Busan').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Busan').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Busan').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Busan').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Busan').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Busan').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Busan').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Busan').css("fill", "#63ED86");
							} else {
								$('path#path-Busan').css("fill", "#8BF1C9");
							}
							$('path#path-Busan').on("click", 
									function() {
										$('#information').html( "부산광역시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
									})
							break;
				case "강원" : 
							if(i < 1) {
								$('path#path-Gangwon-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Gangwon-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Gangwon-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Gangwon-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Gangwon-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Gangwon-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Gangwon-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Gangwon-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Gangwon-do').css("fill", "#63ED86");
							} else {
								$('path#path-Gangwon-do').css("fill", "#8BF1C9");
							} 
							$('path#path-Gangwon-do').on("click", 
									function() {
										$('#information').html( "강원도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
									})
							break;
				case "충북" : 
							if(i < 1) {
								$('path#path-Chungcheongbuk-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Chungcheongbuk-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Chungcheongbuk-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Chungcheongbuk-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Chungcheongbuk-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Chungcheongbuk-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Chungcheongbuk-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Chungcheongbuk-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Chungcheongbuk-do').css("fill", "#63ED86");
							} else {
								$('path#path-Chungcheongbuk-do').css("fill", "#8BF1C9");
							}
							$('path#path-Chungcheongbuk-do').on("click", 
									function() {
										$('#information').html( "충청북도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "충남" : 
							if(i < 1) {
								$('path#path-Chungcheongnam-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Chungcheongnam-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Chungcheongnam-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Chungcheongnam-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Chungcheongnam-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Chungcheongnam-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Chungcheongnam-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Chungcheongnam-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Chungcheongnam-do').css("fill", "#63ED86");
							} else {
								$('path#path-Chungcheongnam-do').css("fill", "#8BF1C9");
							}
							$('path#path-Chungcheongnam-do').on("click", 
									function() {
										$('#information').html( "충청남도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "대전" : 
							if(i < 1) {
								$('path#path-Daejeon').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Daejeon').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Daejeon').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Daejeon').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Daejeon').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Daejeon').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Daejeon').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Daejeon').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Daejeon').css("fill", "#63ED86");
							} else {
								$('path#path-Daejeon').css("fill", "#8BF1C9");
							} 
							$('path#path-Daejeon').on("click", 
									function() {
										$('#information').html( "대전광역시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "세종" : 
							if(i < 1) {
								$('path#path-Sejong').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Sejong').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Sejong').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Sejong').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Sejong').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Sejong').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Sejong').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Sejong').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Sejong').css("fill", "#63ED86");
							} else {
								$('path#path-Sejong').css("fill", "#8BF1C9");
							}
							$('path#path-Sejong').on("click", 
									function() {
										$('#information').html( "세종특별자치시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "광주" : 
							if(i < 1) {
								$('path#path-Gwangju').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Gwangju').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Gwangju').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Gwangju').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Gwangju').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Gwangju').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Gwangju').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Gwangju').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Gwangju').css("fill", "#63ED86");
							} else {
								$('path#path-Gwangju').css("fill", "#8BF1C9");
							}
							$('path#path-Gwangju').on("click", 
									function() {
										$('#information').html( "광주광역시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "전북" : 
							if(i < 1) {
								$('path#path-Jeollabuk-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Jeollabuk-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Jeollabuk-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Jeollabuk-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Jeollabuk-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Jeollabuk-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Jeollabuk-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Jeollabuk-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Jeollabuk-do').css("fill", "#63ED86");
							} else {
								$('path#path-Jeollabuk-do').css("fill", "#8BF1C9");
							} 
							$('path#path-Jeollabuk-do').on("click", 
									function() {
										$('#information').html( "전라북도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "전남" : 
							if(i < 1) {
								$('path#path-Jeollanam-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Jeollanam-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Jeollanam-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Jeollanam-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Jeollanam-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Jeollanam-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Jeollanam-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Jeollanam-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Jeollanam-do').css("fill", "#63ED86");
							} else {
								$('path#path-Jeollanam-do').css("fill", "#8BF1C9");
							} 
							$('path#path-Jeollanam-do').on("click", 
									function() {
										$('#information').html( "전라남도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "경북" : 
							if(i < 1) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Gyeongsangbuk-do').css("fill", "#63ED86");
							} else {
								$('path#path-Gyeongsangbuk-do').css("fill", "#8BF1C9");
							} 
							$('path#path-Gyeongsangbuk-do').on("click", 
									function() {
										$('#information').html( "경상북도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;							
				case "경남" : 
							if(i < 1) {
								$('path#path-Gyeongsangnam-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Gyeongsangnam-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Gyeongsangnam-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Gyeongsangnam-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Gyeongsangnam-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Gyeongsangnam-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Gyeongsangnam-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Gyeongsangnam-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Gyeongsangnam-do').css("fill", "#63ED86");
							} else {
								$('path#path-Gyeongsangnam-do').css("fill", "#8BF1C9");
							} 
							$('path#path-Gyeongsangnam-do').on("click", 
									function() {
										$('#information').html( "경상남도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;		
				case "대구" : 
							if(i < 1) {
								$('path#path-Daegu').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Daegu').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Daegu').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Daegu').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Daegu').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Daegu').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Daegu').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Daegu').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Daegu').css("fill", "#63ED86");
							} else {
								$('path#path-Daegu').css("fill", "#8BF1C9");
							} 
							$('path#path-Daegu').on("click", 
									function() {
										$('#information').html( "대구광역시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "울산" : 
							if(i < 1) {
								$('path#path-Ulsan').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Ulsan').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Ulsan').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Ulsan').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Ulsan').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Ulsan').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Ulsan').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Ulsan').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Ulsan').css("fill", "#63ED86");
							} else {
								$('path#path-Ulsan').css("fill", "#8BF1C9");
							} 
							$('path#path-Ulsan').on("click", 
									function() {
										$('#information').html( "울산광역시 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;
				case "제주" : 
							if(i < 1) {
								$('path#path-Jeju-do').css("fill", "#108757");
							} else if (i < 2) {
								$('path#path-Jeju-do').css("fill", "#11935F");
							} else if (i < 3) {
								$('path#path-Jeju-do').css("fill", "#13A268");
							} else if (i < 4) {
								$('path#path-Jeju-do').css("fill", "#15B374");
							} else if (i < 6) {
								$('path#path-Jeju-do').css("fill", "#17C47E");
							} else if (i < 8) {
								$('path#path-Jeju-do').css("fill", "#1AD58A");
							} else if (i < 11) {
								$('path#path-Jeju-do').css("fill", "#21E496");
							} else if (i < 13) {
								$('path#path-Jeju-do').css("fill", "#3EE8A4");
							} else if (i < 15) {
								$('path#path-Jeju-do').css("fill", "#63ED86");
							} else {
								$('path#path-Jeju-do').css("fill", "#8BF1C9");
							}
							$('path#path-Jeju-do').on("click", 
									function() {
										$('#information').html( "제주특별자치도 : " + data[i].sumPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원  " 
											 								+ data[i].weekCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "회")
							})
							break;							
				}
			}
			   
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
              </div>  
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
        <!-- page content -->
        <div class="right_col" role="main"  style="margin-bottom: 45px;">
          <%-- 
          <!-- top tiles -->
          <div class="row tile_count">
            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 총 고객 수 </span>
              <div class="count green" id="totCnt"></div>
              <span class="count_bottom"><i class="green">4% </i> From last Week</span>
            </div>
            <br>
            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-male"></i> 남성 수 (비율) </span>
              <div class="count green" id="maleCnt"></div>
              <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>3% </i> From last Week</span>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-female"></i> 여성 수 (비율) </span>
              <div class="count green" id="femaleCnt"></div>
              <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 20대 비율 </span>
              <div class="count" id="group20Cnt"></div>
              <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 30대 비율 </span>
              <div class="count" id="group30Cnt"></div>
              <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 40대 비율 </span>
              <div class="count" id="group40Cnt"></div>
              <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
            </div>     
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 50대 비율 </span>
              <div class="count"id="group50Cnt"></div>
              <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
            </div>   
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 60대 비율 </span>
              <div class="count" id="group60Cnt"></div>
              <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
            </div>  
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 70대 비율 </span>
              <div class="count" id="group70Cnt"></div>
              <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
            </div>     
             --%>


			<!-- top tiles -->
          <div class="row tile_count">
            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"> <i class="fa fa-user"></i> 전일 가입자 수 </span>
              <div class="count green" id="yesterdayTotCnt"></div>
            </div>
            <br>
            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-male"></i> 남성 가입자 수 (비율) </span>
              <div class="count green" id="yesterdayMaleCnt"></div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-female"></i> 여성 가입자 수 (비율) </span>
              <div class="count green" id="yesterdayFemaleCnt"></div>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 20대 비율 </span>
              <div class="count" id="yesterdayGroup20Cnt"></div>
              <span class="count_bottom"><i class="green" id="yesterdayGroup20Cnti"></i></span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 30대 비율 </span>
              <div class="count" id="yesterdayGroup30Cnt"></div>
              <span class="count_bottom"><i class="green" id="yesterdayGroup30Cnti"></i></span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 40대 비율 </span>
              <div class="count" id="yesterdayGroup40Cnt"></div>
              <span class="count_bottom"><i class="green" id="yesterdayGroup40Cnti"></i></span>
            </div>     
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 50대 비율 </span>
              <div class="count"id="yesterdayGroup50Cnt"></div>
              <span class="count_bottom"><i class="green" id="yesterdayGroup50Cnti"></i></span>
            </div>   
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 60대 비율 </span>
              <div class="count" id="yesterdayGroup60Cnt"></div>
              <span class="count_bottom"><i class="green" id="yesterdayGroup60Cnti"></i></span>
            </div>  
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 70대 비율 </span>
              <div class="count" id="yesterdayGroup70Cnt"></div>
              <span class="count_bottom"><i class="green" id="yesterdayGroup70Cnti"></i></span>
            </div>     
          <!-- /top tiles -->  
            <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="dashboard_graph">
                <div class="row x_title">
                  <div class="col-md-6">
                    <h3>전 주 대비 최근 7일 카드결제금액 추이 <small>녹색 : 이번 주</small></h3>
                  </div>
                </div>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <canvas id="overlayChart"></canvas>
                </div>
                <div class="col-md-3 col-sm-3 col-xs-12 bg-white">
                  <div class="x_title">
                    <h2>직전 7일간 결제별 비율</h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="col-md-12 col-sm-12 col-xs-6">
                    <div>
                      <p>일시불결제 비율&nbsp;(<span id="lumbSumCntP"></span>)</p>
                      <div class="lumbSumCnt">
                      </div>
                    </div>
                    <div>
                      <p>할부결제 비율&nbsp;(<span id="instCntP"></span>)</p>
                      <div class="instCnt">
                      </div>
                    </div>
                  </div>
                  <div class="col-md-12 col-sm-12 col-xs-6">
                    <div>
                      <p>해외결제 비율&nbsp;(<span id="overseasCntP"></span>)</p>
                      <div class="overseasCnt">
                      </div>
                    </div>
                    <div>
                      <p>국내결제 비율&nbsp;(<span id="domCntP"></span>)</p>
                      <div class="domCnt">
                      </div>
                    </div>
                    <div>
                      <p>온라인결제 비율&nbsp;(<span id="onlineCntP"></span>)</p>
                      <div class="onlineCnt">
                      </div>
                    </div>
                    <div>
                      <p>오프라인결제 비율&nbsp;(<span id="offlineCntP"></span>)</p>
                      <div class="offlineCnt">
                      </div>
                    </div>
                  </div>
                </div>
                <div class="clearfix"></div>
              </div>
            </div>
          </div>
          <!-- 전일 지역별 7일 간 결제횟수 / 결제금액 -->
 			<div class="col-md-5 col-sm-6 col-xs-6" >
                <div class="x_panel" style="width:104%">
                  <div class="x_title">
                    <h2>전일 지역별 결제액, 결제횟수 </h2>
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
                  <div class="x_content" style="width:100%; heigth:600px;">
                    <div id="container">
                    	<div id="information" style="font-size:15px; font-weight:bold; z-index : 999;"></div>
                    </div>
				 </div>
               </div>          
             </div>
          <!-- 사용 횟수 TOP1 카드  -->
		  <div class="col-md-7 col-sm-3 col-xs-3">
              <div class="x_panel" style="width:50%;">
                 <div class="x_title">
                   <h2>전일 사용 횟수 TOP5 카드</h2>
                   <ul class="nav navbar-right panel_toolbox">
                     <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                     </li>
                     <li class="dropdown">
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>              
                     </li>
                     <li><a class="close-link"><i class="fa fa-close"></i></a>
                     </li>
                   </ul>
                   <div class="clearfix"></div>
                 </div>
               <div id="cardMaxCntPieChart" style="height:329px; width:100%;"></div>
               
            </div>
            <!-- 연령대별 결제금액 -->
             <div class="x_panel" style="width:50%; float:right;">
               <div class="x_title">
                 <h2>전일 연령대별 결제금액</h2>
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
                 <div id="paidSumByAgeGroupPieChart" style="height:318px; width:100%;"></div>
               </div>
             </div>
              <!-- 주요 사용업종 -->
             <div class="x_panel" style="width:50%;">
                  <div class="x_title">
                    <h2>전일 사용횟수 TOP6 업종</h2>
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
                    <div id="majorBusiness" style="height:320px;"></div>
                  </div>
                </div>
                <%-- 전일 결제구분/방식별 많이 쓰인 카드 --%>
		   <div class="x_panel" style="width:50%; float:right;">
                  <div class="x_title">
                    <h2>전일 결제방식별 TOP 카드</h2>
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
                  <div class="x_content container" style="height:326px;">
              
                    <table class="table">
                      <thead>
                        <tr>
                          <th>구분</th>
                          <th>카드명</th>
                          <th>사용횟수</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>온라인결제</td>
                          <td id="topOnline"></td>
                          <td id="onlineCnt"></td>
                        </tr>
                        <tr>
                          <td>오프라인결제</td>
                          <td id="topOffline"></td>
                          <td id="offlineCnt"></td>
                        </tr>
                        <tr>
                          <td>할부결제</td>
                          <td id="topInst"></td>
                          <td id="instCnt"></td>
                        </tr>
                        <tr>
                          <td>일시불결제</td>
                          <td id="topLumbSum"></td>
                          <td id="lumbSumCnt"></td>
                        </tr>
                        <tr>
                          <td>국내결제</td>
                          <td id="topDom"></td>
                          <td id="domCnt"></td>
                        </tr>
                        <tr>
                          <td>해외결제</td>
                          <td id="topOverseas"></td>
                          <td id="overseasCnt"></td>
                        </tr>
                      </tbody>
                    </table>

                  </div>
           </div>
           
           </div>
           
                
           </div>
           </div>
           <!--/ 사용 횟수 TOP1 카드  / 연령대별 겷제금액  /  주요 사용업종 -->

         	</div>
			</div>
		  
        <!-- /page content -->
        
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
    <!-- NProgress -->
    <script src="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="${pageContext.request.contextPath}/resources/vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="${pageContext.request.contextPath}/resources/vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/resources/vendors/iCheck/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="${pageContext.request.contextPath}/resources/vendors/skycons/skycons.js"></script>
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
