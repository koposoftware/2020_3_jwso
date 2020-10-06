package hanacard.memo.dao;

import java.util.List;

import hanacard.memo.vo.MemoVO;

public interface MemoDAO {

	/**
	 * 작성한 메모를 저장
	 * @param memo
	 */
	public void insertMemo(MemoVO memo);
	
	/**
	 * 자신의 메모 목록을 조회
	 * @param empno
	 * @return
	 */
	public List<MemoVO> selectMemo(int empno);
	
	/**
	 * 선택한 메모를 삭제
	 * @param empno
	 */
	public void deleteMemo(List<Integer> delList);
	
	
}
