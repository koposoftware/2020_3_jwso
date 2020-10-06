package hanacard.memo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hanacard.memo.dao.MemoDAO;
import hanacard.memo.vo.MemoVO;

@Service
public class MemoServiceImpl implements MemoService {

	@Autowired
	private MemoDAO memoDAO;

	public void insertMemo(MemoVO memo) {
		memoDAO.insertMemo(memo);
	}

	public List<MemoVO> selectMemo(int empno) {
		List<MemoVO> memoList = memoDAO.selectMemo(empno);
		return memoList;
	}

	public void deleteMemo(List<Integer> delList) {
		memoDAO.deleteMemo(delList);
	}
}
