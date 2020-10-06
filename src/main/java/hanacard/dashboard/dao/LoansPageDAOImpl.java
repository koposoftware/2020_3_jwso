package hanacard.dashboard.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hanacard.dashboard.vo.DefaultVO;
import hanacard.dashboard.vo.LoansVO;


@Repository
public class LoansPageDAOImpl implements LoansPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<LoansVO> selectLoansData() {
		List<LoansVO> loansList = sqlSession.selectList("dashboard.dao.LoansPageDAO.selectLoansData");
		return loansList;
	}
	
	public List<DefaultVO> selectDefaultCnt() {
		List<DefaultVO> defaultList = sqlSession.selectList("dashboard.dao.LoansPageDAO.selectDefaultCnt");
		return defaultList;
	}

	public List<LoansVO> selectDueDateClient() {
		List<LoansVO> loansList = sqlSession.selectList("dashboard.dao.LoansPageDAO.selectDueDateClient");
		return loansList;
	}
}
