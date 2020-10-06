package hanacard.dashboard.dao;

import java.util.List;

import hanacard.dashboard.vo.DefaultVO;
import hanacard.dashboard.vo.LoansVO;


public interface LoansPageDAO {
	
	/**
	 * 데이터의 시작일인 2020-01-01일부터 현재일까지의 날짜별 대출서비스의 집계 
	 * @param todayDate
	 * @return
	 */
	List<LoansVO> selectLoansData();
	
	
	/**
	 * 데이터의 시작일인 2020-01-01일부터 현재일까지의 날짜별 연체자 수 집계 
	 * @param todayDate
	 * @return
	 */
	List<DefaultVO> selectDefaultCnt();
	
	/**
	 * 단기, 장기카드대출의 만기가 7일 이내인 손님의 대출정보 조회
	 * @return
	 */
	List<LoansVO> selectDueDateClient();

}
