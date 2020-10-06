package hanacard.dashboard.dao;

import java.util.List;

import hanacard.dashboard.vo.ClientVO;
import hanacard.dashboard.vo.PaymentVO;

public interface PaymentPageDAO {

	/**
	 * 고객정보에 대한 기초통계를 조회 (고객 수, 남/여/연령대별 수)
	 * @return
	 */
	ClientVO selectClientCnt();
	
	/**
	 * 7일간의 데이터와 그 전주의 카드 사용내역을 조회
	 * @return
	 */
	List<PaymentVO> selectPayment();
	
	/**
	 * 카드 결제방식(온/오프라인, 국내/해외, 일시불/할부)의 합계를 조회
	 * @return
	 */
	PaymentVO selectPaymentClf();
	
	/**
	 * 7일간 가장 많이 사용된 카드 조회
	 * @return
	 */
	List<PaymentVO> selectCardCnt();
	
	/**
	 * 전일의 연령대별 결제금액을 조회
	 * @return
	 */
	List<PaymentVO> paidSumByAge();
	
	/**
	 * 7일간 가장 많이 사용된 사용처 조회
	 * @return
	 */
	List<PaymentVO> cntBusiness();
	
	/**
	 * 7일간 지역별 사용금액 조회
	 * @return
	 */
	List<PaymentVO> sumByRegion();
	
	/**
	 * 전일의 가입자 수, 성별/연령대별 수 조회
	 * @return
	 */
	ClientVO selectYesterdayClientCnt();
	
	/**
	 * 전일의 국내, 해외, 온라인, 오프라인, 일시불, 할부 결제에 가장 많이 쓰인 카드 조회
	 * @return
	 */
	PaymentVO selectTopCard();

}
