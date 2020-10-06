package hanacard.dashboard.vo;

import java.io.Serializable;

public class LoansVO implements Serializable {
	
	private String loanDate;
	private int revolvingSum;
	private int revolvingCnt;
	private int shortTermLoansSum;
	private int shortTermLoansCnt;
	private int longTermLoansSum;
	private int longTermLoansCnt;
	private String cid;
	private String loanClf;
	private int loans;
	private String loanDueDate;
	private int loanBalance;

	public LoansVO() {
	}
	public String getLoanDate() {
		return loanDate;
	}
	public void setLoanDate(String loanDate) {
		this.loanDate = loanDate;
	}
	public int getRevolvingSum() {
		return revolvingSum;
	}
	public void setRevolvingSum(int revolvingSum) {
		this.revolvingSum = revolvingSum;
	}
	public int getRevolvingCnt() {
		return revolvingCnt;
	}
	public void setRevolvingCnt(int revolvingCnt) {
		this.revolvingCnt = revolvingCnt;
	}
	public int getShortTermLoansSum() {
		return shortTermLoansSum;
	}
	public void setShortTermLoansSum(int shortTermLoansSum) {
		this.shortTermLoansSum = shortTermLoansSum;
	}
	public int getShortTermLoansCnt() {
		return shortTermLoansCnt;
	}
	public void setShortTermLoansCnt(int shortTermLoansCnt) {
		this.shortTermLoansCnt = shortTermLoansCnt;
	}
	public int getLongTermLoansSum() {
		return longTermLoansSum;
	}
	public void setLongTermLoansSum(int longTermLoansSum) {
		this.longTermLoansSum = longTermLoansSum;
	}
	public int getLongTermLoansCnt() {
		return longTermLoansCnt;
	}
	public void setLongTermLoansCnt(int longTermLoansCnt) {
		this.longTermLoansCnt = longTermLoansCnt;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getLoanClf() {
		return loanClf;
	}
	public void setLoanClf(String loanClf) {
		this.loanClf = loanClf;
	}
	public int getLoans() {
		return loans;
	}
	public void setLoans(int loans) {
		this.loans = loans;
	}
	public String getLoanDueDate() {
		return loanDueDate;
	}
	public void setLoanDueDate(String loanDueDate) {
		this.loanDueDate = loanDueDate;
	}
	public int getLoanBalance() {
		return loanBalance;
	}
	public void setLoanBalance(int loanBalance) {
		this.loanBalance = loanBalance;
	}
	
	
	
}
