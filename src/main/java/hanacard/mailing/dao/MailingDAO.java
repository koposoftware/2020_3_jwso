package hanacard.mailing.dao;

import java.util.List;

import hanacard.mailing.vo.MailingVO;
import hanacard.mailing.vo.UserVO;

public interface MailingDAO {

	/**
	 * 한달 간 고객이 사용한 사용처 별 사용 금액 합계 조회
	 * @param userId 
	 * @return
	 */
	List<MailingVO> selectMajorUseBusiness(String cid);
	
	/**
	 * 한달 간 고객과 같은 군집이 사용했던 카드 조회
	 * @return
	 */
	List<MailingVO> selectClusterUsedCard(String cid);
	
	/**
	 * 지난 달 , 지지난 달 사용한 금액, 연령대의 평균사용금액 조회
	 * @return
	 */
	List<MailingVO> selectPaidBetweenMonth(UserVO userVO);
	
	/**
	 * 지난 달의 사용 내역을 조회
	 * @return
	 */
	List<MailingVO> selectPayingHistory(String cid);
	
	/**
	 * 아직 할부 개월 수가 남은 결제 내역 조회
	 * @param cid
	 * @return
	 */
	List<MailingVO> selectRemainHistory(String cid);

	/**
	 * 서비스에 로그인한 사용자의 정보 조회
	 * @param userVO
	 * @return
	 */
	UserVO selectUserVO(UserVO userVO);
	
	
}
