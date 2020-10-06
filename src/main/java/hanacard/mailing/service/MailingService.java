package hanacard.mailing.service;

import java.util.List;

import hanacard.mailing.vo.MailingVO;
import hanacard.mailing.vo.UserVO;

public interface MailingService {

	List<MailingVO> selectMajorUseBusiness(String cid);
	List<MailingVO> selectClusterUsedCard(String cid);
	List<MailingVO> selectPaidBetweenMonth(UserVO userVO);
	List<MailingVO> selectPayingHistory(String cid);
	List<MailingVO>	selectRemainHistory(String cid);
	UserVO selectUserVO(UserVO userVO);
}
