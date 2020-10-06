package hanacard.dashboard.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hanacard.dashboard.vo.ClientVO;
import hanacard.dashboard.vo.PaymentVO;

@Repository
public class PaymentPageDAOImpl implements PaymentPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ClientVO selectClientCnt() {
		ClientVO clientVO = sqlSession.selectOne("dashboard.dao.PaymentPageDAO.selectClientCnt");
		return clientVO;
	}

	public List<PaymentVO> selectPayment() {
		List<PaymentVO> paymentList = sqlSession.selectList("dashboard.dao.PaymentPageDAO.selectPayment");
		return paymentList;
	}

	public PaymentVO selectPaymentClf() {
		PaymentVO paymentVO = sqlSession.selectOne("dashboard.dao.PaymentPageDAO.selectPaymentClf");
		return paymentVO;
	}

	public List<PaymentVO> selectCardCnt() {
		List<PaymentVO> cardRankCnt= sqlSession.selectList("dashboard.dao.PaymentPageDAO.selectCardCnt");
		return cardRankCnt;
	}

	public List<PaymentVO> paidSumByAge() {
		List<PaymentVO> paymentList = sqlSession.selectList("dashboard.dao.PaymentPageDAO.paidSumByAge");
		return paymentList;
	}

	public List<PaymentVO> cntBusiness() {
		List<PaymentVO> businessList = sqlSession.selectList("dashboard.dao.PaymentPageDAO.cntBusiness");
		return businessList;
	}

	public List<PaymentVO> sumByRegion() {
		List<PaymentVO> sumList = sqlSession.selectList("dashboard.dao.PaymentPageDAO.sumByRegion");
		return sumList;
	}
	
	public ClientVO selectYesterdayClientCnt() {
		ClientVO yesterdayClientCnt = sqlSession.selectOne("dashboard.dao.PaymentPageDAO.selectYesterdayClientCnt");
		return yesterdayClientCnt;
	}
	
	public PaymentVO selectTopCard() {
		PaymentVO topCards = sqlSession.selectOne("dashboard.dao.PaymentPageDAO.selectTopCard");
		return topCards;
	}
}
