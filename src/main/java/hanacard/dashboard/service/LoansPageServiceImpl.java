package hanacard.dashboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hanacard.dashboard.dao.LoansPageDAO;
import hanacard.dashboard.vo.DefaultVO;
import hanacard.dashboard.vo.LoansVO;

@Service
public class LoansPageServiceImpl implements LoansPageService {
	
	@Autowired
	private LoansPageDAO loansPageDAO;
	
	public List<LoansVO> selectLoansData() {
		List<LoansVO> loansList = loansPageDAO.selectLoansData();
		return loansList;
	}
	
	public List<DefaultVO> selectDefaultCnt() {
		List<DefaultVO> defaultList = loansPageDAO.selectDefaultCnt();
		return defaultList;
	}

	public List<LoansVO> selectDueDateClient() {
		List<LoansVO> loansList = loansPageDAO.selectDueDateClient();
		return loansList;
	}

}
