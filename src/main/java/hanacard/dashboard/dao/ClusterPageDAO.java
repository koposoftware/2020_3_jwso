package hanacard.dashboard.dao;

import java.util.List;

import hanacard.dashboard.vo.ClusterVO;

public interface ClusterPageDAO {
	
	/**
	 * 군집별 많이 사용된 사용처 TOP 6를 조회하는 쿼리문
	 * @return
	 */
	List<ClusterVO> selectClusterRadar();
	
	/**
	 * 군집별 기조통계자료를 조회
	 * @return
	 */
	List<ClusterVO> selectClusterExplain();
	
	

}
