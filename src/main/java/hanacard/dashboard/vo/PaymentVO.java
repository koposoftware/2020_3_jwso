package hanacard.dashboard.vo;

import java.math.BigInteger;

public class PaymentVO {
	
	
	private String transactionDate;
	private BigInteger paymentSum;
	private int totCnt;
	private int onlineCnt;
	private int instCnt;
	private int domCnt;
	private int cardPaidCnt;
	private String cardName;
	private String groups;
	private BigInteger paidSum;
	private int useCnt;
	private String codeInfo;
	private String transDate;
	private String paymentArea;
	private int sumPayment;
	private int weekCnt;
	private String topOnline;
	private String topOffline;
	private String topInst;
	private String topLumbSum;
	private String topDom;
	private String topOverseas;
	private int maxOnlineCnt;
	private int maxOfflineCnt;
	private int maxInstCnt;
	private int maxLumbSumCnt;
	private int maxDomCnt;
	private int maxOverseasCnt;
	
	public PaymentVO() {
	
	}
	public String getTransactionDate() {
		return transactionDate;
	}
	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}
	public BigInteger getPaymentSum() {
		return paymentSum;
	}
	public void setPaymentSum(BigInteger paymentSum) {
		this.paymentSum = paymentSum;
	}
	public int getOnlineCnt() {
		return onlineCnt;
	}
	public void setOnlineCnt(int onlineCnt) {
		this.onlineCnt = onlineCnt;
	}
	public int getInstCnt() {
		return instCnt;
	}
	public void setInstCnt(int instCnt) {
		this.instCnt = instCnt;
	}
	public int getDomCnt() {
		return domCnt;
	}
	public void setDomCnt(int domCnt) {
		this.domCnt = domCnt;
	}
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}
	public int getCardPaidCnt() {
		return cardPaidCnt;
	}
	public void setCardPaidCnt(int cardPaidCnt) {
		this.cardPaidCnt = cardPaidCnt;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getGroups() {
		return groups;
	}
	public void setGroups(String groups) {
		this.groups = groups;
	}
	public BigInteger getPaidSum() {
		return paidSum;
	}
	public void setPaidSum(BigInteger paidSum) {
		this.paidSum = paidSum;
	}
	public int getUseCnt() {
		return useCnt;
	}
	public void setUseCnt(int useCnt) {
		this.useCnt = useCnt;
	}
	public String getCodeInfo() {
		return codeInfo;
	}
	public void setCodeInfo(String codeInfo) {
		this.codeInfo = codeInfo;
	}
	public String getTransDate() {
		return transDate;
	}
	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}
	public String getPaymentArea() {
		return paymentArea;
	}
	public void setPaymentArea(String paymentArea) {
		this.paymentArea = paymentArea;
	}
	public int getSumPayment() {
		return sumPayment;
	}
	public void setSumPayment(int sumPayment) {
		this.sumPayment = sumPayment;
	}
	public int getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(int weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getTopOnline() {
		return topOnline;
	}
	public void setTopOnline(String topOnline) {
		this.topOnline = topOnline;
	}
	public String getTopOffline() {
		return topOffline;
	}
	public void setTopOffline(String topOffline) {
		this.topOffline = topOffline;
	}
	public String getTopInst() {
		return topInst;
	}
	public void setTopInst(String topInst) {
		this.topInst = topInst;
	}
	public String getTopLumbSum() {
		return topLumbSum;
	}
	public void setTopLumbSum(String topLumbSum) {
		this.topLumbSum = topLumbSum;
	}
	public String getTopDom() {
		return topDom;
	}
	public void setTopDom(String topDom) {
		this.topDom = topDom;
	}
	public String getTopOverseas() {
		return topOverseas;
	}
	public void setTopOverseas(String topOverseas) {
		this.topOverseas = topOverseas;
	}
	public int getMaxOnlineCnt() {
		return maxOnlineCnt;
	}
	public void setMaxOnlineCnt(int maxOnlineCnt) {
		this.maxOnlineCnt = maxOnlineCnt;
	}
	public int getMaxOfflineCnt() {
		return maxOfflineCnt;
	}
	public void setMaxOfflineCnt(int maxOfflineCnt) {
		this.maxOfflineCnt = maxOfflineCnt;
	}
	public int getMaxInstCnt() {
		return maxInstCnt;
	}
	public void setMaxInstCnt(int maxInstCnt) {
		this.maxInstCnt = maxInstCnt;
	}
	public int getMaxLumbSumCnt() {
		return maxLumbSumCnt;
	}
	public void setMaxLumbSumCnt(int maxLumbSumCnt) {
		this.maxLumbSumCnt = maxLumbSumCnt;
	}
	public int getMaxDomCnt() {
		return maxDomCnt;
	}
	public void setMaxDomCnt(int maxDomCnt) {
		this.maxDomCnt = maxDomCnt;
	}
	public int getMaxOverseasCnt() {
		return maxOverseasCnt;
	}
	public void setMaxOverseasCnt(int maxOverseasCnt) {
		this.maxOverseasCnt = maxOverseasCnt;
	}

}
