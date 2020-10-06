package hanacard.dashboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hanacard.dashboard.dao.PaymentPageDAO;
import hanacard.dashboard.vo.ClientVO;
import hanacard.dashboard.vo.PaymentVO;

@Service
public class PaymentPageServiceImpl implements PaymentPageService {

	@Autowired
	private PaymentPageDAO paymentPageDAO;
	
	public ClientVO selectClientCnt() {
		
		ClientVO clientVO = paymentPageDAO.selectClientCnt();
		return clientVO;
	}

	public List<PaymentVO> selectPayment() {
		List<PaymentVO> paymentList = paymentPageDAO.selectPayment();
		return paymentList;
	}

	public PaymentVO selectPaymentClf() {
		PaymentVO paymentVO = paymentPageDAO.selectPaymentClf();
		return paymentVO;
	}

	public List<PaymentVO> selectCardCnt() {
		List<PaymentVO> cardRankCnt = paymentPageDAO.selectCardCnt();
		return cardRankCnt;
	}

	public List<PaymentVO> paidSumByAge() {
		List<PaymentVO> paidSumByAge = paymentPageDAO.paidSumByAge();
		return paidSumByAge;
	}

	public List<PaymentVO> cntBusiness() {
		List<PaymentVO> businessList = paymentPageDAO.cntBusiness();
		return businessList;
	}

	public List<PaymentVO> sumByRegion() {
		List<PaymentVO> sumList = paymentPageDAO.sumByRegion();
		return sumList;
	}

	public ClientVO selectYesterdayClientCnt() {
		ClientVO yesterdayClientCnt = paymentPageDAO.selectYesterdayClientCnt();
		return yesterdayClientCnt;
	}

	public PaymentVO selectTopCard() {
		PaymentVO topCards = paymentPageDAO.selectTopCard();
		return topCards;
	}

}
