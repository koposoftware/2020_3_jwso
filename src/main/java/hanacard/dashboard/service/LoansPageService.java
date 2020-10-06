package hanacard.dashboard.service;

import java.util.List;

import hanacard.dashboard.vo.DefaultVO;
import hanacard.dashboard.vo.LoansVO;

public interface LoansPageService {

	List<LoansVO> selectLoansData();
	List<DefaultVO> selectDefaultCnt();
	List<LoansVO> selectDueDateClient();
}
