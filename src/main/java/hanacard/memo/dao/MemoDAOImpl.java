package hanacard.memo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hanacard.memo.vo.MemoVO;

@Repository
public class MemoDAOImpl implements MemoDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	public void insertMemo(MemoVO memo) {
		sqlSession.insert("memo.dao.MemoDAO.insertMemo", memo);
	}

	public List<MemoVO> selectMemo(int empno) {
		List<MemoVO> MemoList = sqlSession.selectList("memo.dao.MemoDAO.selectMemo", empno);
		return MemoList;
	}

	public void deleteMemo(List<Integer> delList) {
		sqlSession.delete("memo.dao.MemoDAO.deleteMemo", delList);
	}

}
