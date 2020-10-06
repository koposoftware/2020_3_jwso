package hanacard.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hanacard.employee.dao.EmployeeDAO;
import hanacard.employee.vo.EmployeeVO;

@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	private EmployeeDAO employeeDAO;

	public EmployeeVO login(EmployeeVO employeeVO) {
		return employeeDAO.login(employeeVO);
	}

	

}

