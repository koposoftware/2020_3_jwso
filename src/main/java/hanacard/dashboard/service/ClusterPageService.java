package hanacard.dashboard.service;

import java.util.List;

import hanacard.dashboard.vo.ClusterVO;

public interface ClusterPageService {

	List<ClusterVO> selectClusterRadar();
	
	List<ClusterVO> selectClusterExplain();
}
