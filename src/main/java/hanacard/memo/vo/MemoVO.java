package hanacard.memo.vo;

import java.io.Serializable;

public class MemoVO implements Serializable {

	private int no;
	private int empno;
	private String memoDate;
	private String Memo;
	
	public MemoVO() {
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getMemoDate() {
		return memoDate;
	}
	public void setMemoDate(String memoDate) {
		this.memoDate = memoDate;
	}
	public String getMemo() {
		return Memo;
	}
	public void setMemo(String memo) {
		Memo = memo;
	}

}
