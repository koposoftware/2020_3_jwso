package hanacard.mailing.vo;

public class MailingVO {
	
	private String businessInfo;
	private int	sumPayment;
	private String cardName;
	private int cardUsedCnt;
	private int sumThisLastAgeGroup;
	private String transactionDate;
	private String paymentArea;
	private int dailyPayment;
	private String usingCardName;
	private String businessType;
	private int instPlan;
	private int remainInst;
	
	public MailingVO() {
	
	}
	public String getBusinessInfo() {
		return businessInfo;
	}
	public void setBusinessInfo(String businessInfo) {
		this.businessInfo = businessInfo;
	}
	public int getSumPayment() {
		return sumPayment;
	}
	public void setSumPayment(int sumPayment) {
		this.sumPayment = sumPayment;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public int getCardUsedCnt() {
		return cardUsedCnt;
	}
	public void setCardUsedCnt(int cardUsedCnt) {
		this.cardUsedCnt = cardUsedCnt;
	}
	public int getSumThisLastAgeGroup() {
		return sumThisLastAgeGroup;
	}
	public void setSumThisLastAgeGroup(int sumThisLastAgeGroup) {
		this.sumThisLastAgeGroup = sumThisLastAgeGroup;
	}
	public String getTransactionDate() {
		return transactionDate;
	}
	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}
	public String getPaymentArea() {
		return paymentArea;
	}
	public void setPaymentArea(String paymentArea) {
		this.paymentArea = paymentArea;
	}
	public int getDailyPayment() {
		return dailyPayment;
	}
	public void setDailyPayment(int dailyPayment) {
		this.dailyPayment = dailyPayment;
	}
	public String getUsingCardName() {
		return usingCardName;
	}
	public void setUsingCardName(String usingCardName) {
		this.usingCardName = usingCardName;
	}
	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public int getInstPlan() {
		return instPlan;
	}
	public void setInstPlan(int instPlan) {
		this.instPlan = instPlan;
	}
	public int getRemainInst() {
		return remainInst;
	}
	public void setRemainInst(int remainInst) {
		this.remainInst = remainInst;
	}
	
}
