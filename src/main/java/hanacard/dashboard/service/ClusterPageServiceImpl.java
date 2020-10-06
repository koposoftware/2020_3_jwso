package hanacard.dashboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hanacard.dashboard.dao.ClusterPageDAO;
import hanacard.dashboard.vo.ClusterVO;

@Service
public class ClusterPageServiceImpl implements ClusterPageService {
	
	@Autowired
	private ClusterPageDAO clusterPageDAO;
	
	public List<ClusterVO> selectClusterRadar() {
		List<ClusterVO> clusterRadarList = clusterPageDAO.selectClusterRadar();
		return clusterRadarList;
	}

	public List<ClusterVO> selectClusterExplain() {
		List<ClusterVO> clusterExplainList = clusterPageDAO.selectClusterExplain();
		return clusterExplainList;
	}

}
