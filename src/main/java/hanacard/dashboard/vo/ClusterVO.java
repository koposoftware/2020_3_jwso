package hanacard.dashboard.vo;

public class ClusterVO {

	private int clusterNo;
	private String codeInfo;
	private int useCnt;
	private int maxCnt;
	private int population;
	private int avgMonthlyIncome;
	private double avgInst;
	private int avgPayment;
	private double avgAge;
	private String cardName;
	private int cardUsageCnt;
	
	public ClusterVO() {
	}
	public int getClusterNo() {
		return clusterNo;
	}
	public void setClusterNo(int clusterNo) {
		this.clusterNo = clusterNo;
	}
	public String getCodeInfo() {
		return codeInfo;
	}
	public void setCodeInfo(String codeInfo) {
		this.codeInfo = codeInfo;
	}
	public int getUseCnt() {
		return useCnt;
	}
	public void setUseCnt(int useCnt) {
		this.useCnt = useCnt;
	}
	public int getMaxCnt() {
		return maxCnt;
	}
	public void setMaxCnt(int maxCnt) {
		this.maxCnt = maxCnt;
	}
	public int getPopulation() {
		return population;
	}
	public void setPopulation(int population) {
		this.population = population;
	}
	public int getAvgMonthlyIncome() {
		return avgMonthlyIncome;
	}
	public void setAvgMonthlyIncome(int avgMonthlyIncome) {
		this.avgMonthlyIncome = avgMonthlyIncome;
	}
	public double getAvgInst() {
		return avgInst;
	}
	public void setAvgInst(double avgInst) {
		this.avgInst = avgInst;
	}
	public int getAvgPayment() {
		return avgPayment;
	}
	public void setAvgPayment(int avgPayment) {
		this.avgPayment = avgPayment;
	}
	public double getAvgAge() {
		return avgAge;
	}
	public void setAvgAge(double avgAge) {
		this.avgAge = avgAge;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public int getCardUsageCnt() {
		return cardUsageCnt;
	}
	public void setCardUsageCnt(int cardUsageCnt) {
		this.cardUsageCnt = cardUsageCnt;
	}
	

}
