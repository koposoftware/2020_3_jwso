package hanacard.mailing.vo;

public class UserVO {

	private String cid;
	private int gender;
	private int ageGroup;
	private int clusterNo;
	private int pw;
	private String regDate;
	private int regPeriod;
	
	public UserVO() {
		
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public int getPw() {
		return pw;
	}
	public void setPw(int pw) {
		this.pw = pw;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getClusterNo() {
		return clusterNo;
	}
	public void setClusterNo(int clusterNo) {
		this.clusterNo = clusterNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getAgeGroup() {
		return ageGroup;
	}
	public void setAgeGroup(int ageGroup) {
		this.ageGroup = ageGroup;
	}
	public int getRegPeriod() {
		return regPeriod;
	}
	public void setRegPeriod(int regPeriod) {
		this.regPeriod = regPeriod;
	}
}
