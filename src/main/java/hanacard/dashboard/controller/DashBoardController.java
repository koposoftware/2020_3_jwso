package hanacard.dashboard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hanacard.dashboard.service.ClusterPageService;
import hanacard.dashboard.service.LoansPageService;
import hanacard.dashboard.service.PaymentPageService;
import hanacard.dashboard.vo.ClientVO;
import hanacard.dashboard.vo.ClusterVO;
import hanacard.dashboard.vo.DefaultVO;
import hanacard.dashboard.vo.LoansVO;
import hanacard.dashboard.vo.PaymentVO;

@Controller
public class DashBoardController {
	
	@Autowired
	LoansPageService loansPageService;
	@Autowired
	PaymentPageService paymentPageService;
	@Autowired
	ClusterPageService clusterPageService;
	
	
	@PostMapping("/selectTopCard")
	@ResponseBody
	public PaymentVO selectTopCard() {
		PaymentVO topCards = paymentPageService.selectTopCard();
		return topCards;
	}
	
	@PostMapping("/selectYesterdayClientCnt")
	@ResponseBody
	public ClientVO selectYesterdayClientCnt() {
		ClientVO yesterdayClientCnt = paymentPageService.selectYesterdayClientCnt();
		return yesterdayClientCnt;
	}
	
	@PostMapping("/selectDueDateClient")
	@ResponseBody
	public List<LoansVO> selectDueDateClient(HttpSession session) {
		List<LoansVO> loansList = loansPageService.selectDueDateClient();
		session.setAttribute("loansDueClient", loansList);
		return loansList;
	}
	
	@PostMapping("/selectClusterExplain")
	@ResponseBody
	public List<ClusterVO> selectClustserExplain() {
		List<ClusterVO> clusterExplainList = clusterPageService.selectClusterExplain();
		return clusterExplainList;
	}
	
	@PostMapping("/selectClusterRadar")
	@ResponseBody
	public List<ClusterVO> selectClusterRadar() {
		List<ClusterVO> clusterRadarList = clusterPageService.selectClusterRadar();
		return clusterRadarList;
	}
	
	@PostMapping("/clientData")
	@ResponseBody
	public ClientVO selectClientCnt() {
		  ClientVO clientVO = paymentPageService.selectClientCnt();
		  return clientVO;
	}
	
	@PostMapping("/paymentData")
	@ResponseBody
	public List<PaymentVO> selectPayment() {
		List<PaymentVO> paymentList = paymentPageService.selectPayment();
		return paymentList;	
	}
	
	 @PostMapping("/selectPaymentClf")
	 @ResponseBody 
	 public PaymentVO selectPaymentClf() {
		 PaymentVO paymentVO = paymentPageService.selectPaymentClf();
		 return paymentVO;
	}
	
	
	@PostMapping("/selectCardCnt")
	@ResponseBody
	public List<PaymentVO> selectCardCnt() {
		List<PaymentVO> cardRankCnt = paymentPageService.selectCardCnt();
		return cardRankCnt;
	}
	
	@PostMapping("/paidSumByAge")
	@ResponseBody
	public List<PaymentVO> paidSumByAge() {
		List<PaymentVO> paidSumByAge = paymentPageService.paidSumByAge();
		return paidSumByAge;
	}
	
	@PostMapping("/cntBusiness")
	@ResponseBody
	public List<PaymentVO> cntBusiness() {
		List<PaymentVO> businessList = paymentPageService.cntBusiness();
		return businessList;
	}
	
	@PostMapping("/sumByRegion")
	@ResponseBody
	public List<PaymentVO> sumByRegion() {
		List<PaymentVO> sumList = paymentPageService.sumByRegion();
		return sumList;
	}
	
	@PostMapping("/selectLoansData")
	@ResponseBody
	public List<LoansVO> selectLoansData() {
		List<LoansVO> loansList = loansPageService.selectLoansData();
		return loansList;	
	}
	@PostMapping("/defaultCnt")
	@ResponseBody
	public List<DefaultVO> selectDefaultCnt() {
		 List<DefaultVO> defaultList = loansPageService.selectDefaultCnt();
		 return defaultList;
	}
	
	@GetMapping("/LoanData")
	public String loanData(HttpSession session) {
		List<LoansVO> loansList = loansPageService.selectDueDateClient();
		session.setAttribute("loansDueClient", loansList);
		return "/loanData";
	}
	
	@GetMapping("/PaymentData")
	public String paymentData() {
		return "/paymentData";
	}
	
	@GetMapping("/ClusterData")
	public String clusterData() {
		return "/clusterData";
	}
	
	@GetMapping("/ShowMemo")
	public String showMyNoteBook() {
		return "/myMemo";
	}
	
}
