package hanacard.employee.vo;

public class EmployeeVO {

	private String empno;
	private String ename;
	private int dept_code;
	private String pw;
	
	public EmployeeVO() {
		
	}
	
	public EmployeeVO(String empno, String ename, int dept_code, String pw) {
		super();
		this.empno = empno;
		this.ename = ename;
		this.dept_code = dept_code;
		this.pw = pw;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public int getDept_code() {
		return dept_code;
	}

	public void setDept_code(int dept_code) {
		this.dept_code = dept_code;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	@Override
	public String toString() {
		return "EmployeeVO [empno=" + empno + ", ename=" + ename + ", dept_code=" + dept_code + ", pw=" + pw
				+ "]";
	}
	
	
	
}
