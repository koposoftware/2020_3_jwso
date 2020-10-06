package hanacard.dashboard.service;

import java.util.List;

import hanacard.dashboard.vo.ClientVO;
import hanacard.dashboard.vo.PaymentVO;

public interface PaymentPageService {
	
	ClientVO selectClientCnt();
	List<PaymentVO> selectPayment();
	PaymentVO selectPaymentClf();
	List<PaymentVO> selectCardCnt();
	List<PaymentVO> paidSumByAge();
	List<PaymentVO> cntBusiness();
	List<PaymentVO> sumByRegion();
	ClientVO selectYesterdayClientCnt();
	PaymentVO selectTopCard();
}
