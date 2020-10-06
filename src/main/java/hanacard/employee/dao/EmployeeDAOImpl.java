package hanacard.employee.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hanacard.employee.vo.EmployeeVO;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public EmployeeVO login(EmployeeVO employeeVO) {
		
		EmployeeVO loginVO = sqlSession.selectOne("EmployeeDAO.login", employeeVO);
		return loginVO;
	}

}
