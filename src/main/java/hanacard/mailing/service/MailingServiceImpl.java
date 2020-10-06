package hanacard.mailing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hanacard.mailing.dao.MailingDAO;
import hanacard.mailing.vo.MailingVO;
import hanacard.mailing.vo.UserVO;


@Service
public class MailingServiceImpl implements MailingService {
	
	@Autowired
	private MailingDAO mailingDAO;

	public List<MailingVO> selectMajorUseBusiness(String cid) {
		List<MailingVO> majorUseBusinessList = mailingDAO.selectMajorUseBusiness(cid);
			return majorUseBusinessList;
	}

	public List<MailingVO> selectClusterUsedCard(String cid) {
		List<MailingVO> clusterUsedCardList = mailingDAO.selectClusterUsedCard(cid);
			return clusterUsedCardList;
	}

	public List<MailingVO> selectPaidBetweenMonth(UserVO userVO) {
		List<MailingVO> paidBetweenMonthList = mailingDAO.selectPaidBetweenMonth(userVO);
		return paidBetweenMonthList;
	}

	public List<MailingVO> selectPayingHistory(String cid) {
		List<MailingVO> payingHistoryList = mailingDAO.selectPayingHistory(cid);
		return payingHistoryList;
	}

	public List<MailingVO> selectRemainHistory(String cid) {
		List<MailingVO> remainList = mailingDAO.selectRemainHistory(cid);
		return remainList;
	}

	public UserVO selectUserVO(UserVO userVO) {
		UserVO user = mailingDAO.selectUserVO(userVO);
		return user;
	}

}
