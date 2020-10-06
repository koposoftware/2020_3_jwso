package hanacard.mailing.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hanacard.mailing.vo.MailingVO;
import hanacard.mailing.vo.UserVO;

@Repository
public class MailingDAOImpl implements MailingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<MailingVO> selectMajorUseBusiness(String cid) {
		
		List<MailingVO> majorUseBusinessList = sqlSession.selectList("mailing.dao.MailingDAO.selectMajorUseBusiness", cid);
		return majorUseBusinessList;
	}

	public List<MailingVO> selectClusterUsedCard(String cid) {
		List<MailingVO> clusterUsedCardList = sqlSession.selectList("mailing.dao.MailingDAO.selectClusterUsedCard", cid);
		return clusterUsedCardList;
	}

	public List<MailingVO> selectPaidBetweenMonth(UserVO userVO) {
		List<MailingVO> paidBetweenMonthList = sqlSession.selectList("mailing.dao.MailingDAO.selectPaidBetweenMonth", userVO); //부적합열유형
		return paidBetweenMonthList;
	}

	public List<MailingVO> selectPayingHistory(String cid) {
		List<MailingVO> payingHistoryList = sqlSession.selectList("mailing.dao.MailingDAO.selectPayingHistory", cid);
		return payingHistoryList;
	}

	public List<MailingVO> selectRemainHistory(String cid) {
		List<MailingVO> remainList = sqlSession.selectList("mailing.dao.MailingDAO.selectRemainHistory", cid);
		return remainList;
	}
	
	public UserVO selectUserVO(UserVO userVO) {
		UserVO user = sqlSession.selectOne("mailing.dao.MailingDAO.selectUserVO", userVO);
		return user;
	}
	

}
