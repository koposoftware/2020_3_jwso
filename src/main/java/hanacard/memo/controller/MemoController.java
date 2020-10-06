package hanacard.memo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hanacard.memo.service.MemoService;
import hanacard.memo.vo.MemoVO;

@Controller
public class MemoController {
	
	@Autowired
	MemoService memoService;
	
	@PostMapping("/deleteMemo")
	@ResponseBody
	public void deleteMemo(@RequestParam("lists[]") List<Integer> delList) {
		memoService.deleteMemo(delList);
	}
	
	@PostMapping("/insertMemo/{empno}")
	@ResponseBody
	public void insertMemo(@PathVariable int empno, @RequestParam("content") String data, HttpSession session) {
		MemoVO memo = new MemoVO();
		memo.setEmpno(empno);
		memo.setMemo(data);
		memoService.insertMemo(memo);
		List<MemoVO> memoList = memoService.selectMemo(empno);
		session.removeAttribute("memoList");
		session.setAttribute("memoList", memoList);
	}
	
	@PostMapping("/selectMemo/{empno}")
	@ResponseBody
	public List<MemoVO> selectMemo(@PathVariable int empno, HttpSession session) {
		List<MemoVO> memoList = memoService.selectMemo(empno);
		session.removeAttribute("memoList");
		session.setAttribute("memoList", memoList);
		return memoList;
	}
}
