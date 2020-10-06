package hanacard.memo.service;

import java.util.List;

import hanacard.memo.vo.MemoVO;

public interface MemoService {
	
	public void insertMemo(MemoVO memo);
	public List<MemoVO> selectMemo(int empno);
	public void deleteMemo(List<Integer> delList);
}
