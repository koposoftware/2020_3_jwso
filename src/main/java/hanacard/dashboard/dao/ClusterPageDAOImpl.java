package hanacard.dashboard.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hanacard.dashboard.vo.ClusterVO;

@Repository
public class ClusterPageDAOImpl implements ClusterPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<ClusterVO> selectClusterRadar() {
		List<ClusterVO> clusterRadarList = sqlSession.selectList("dashboard.dao.ClusterPageDAO.selectClusterRadar");
		return clusterRadarList;
	}

	public List<ClusterVO> selectClusterExplain() {
		List<ClusterVO> clusterExplainList = sqlSession.selectList("dashboard.dao.ClusterPageDAO.selectClusterExplain");
		return clusterExplainList;
	}

}
