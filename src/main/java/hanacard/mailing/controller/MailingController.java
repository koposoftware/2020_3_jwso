package hanacard.mailing.controller;

import java.io.File;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import hanacard.mailing.service.MailingService;
import hanacard.mailing.vo.MailVO;
import hanacard.mailing.vo.MailingVO;
import hanacard.mailing.vo.UserVO;

@SessionAttributes("userVO")
@Controller
public class MailingController {

	@Autowired
	MailingService mailingService;
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@GetMapping("/mail")
	public void mail(HttpServletRequest request) {
		//String id = loginVO.getId();
		//String mail = loginVO.getEmail();
		String toMail = "projaewon2@gmail.com";
		String title = "[하나카드] 고객님의 소비내역서가 도착했습니다.";
		
		MailVO mail = new MailVO();
		//mail.setId(id);
		mail.setToMail(toMail);
		mail.setTitle(title);
		String setFrom = "HANACARD";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			String htmlMsg = "<body>"+
	  						 "<h3> 안녕하세요? 하나카드입니다.<h3><br/>" +
	  						 "<a href='http://localhost:9999/clientLogin'><strong>여기</strong></a>를 눌러서 고객님의 이번 달 소비내역리포트를 확인하세요.</body>";
			message.setContent(htmlMsg, "text/html; charset=UTF-8");
			String contents = message.getContent() + "<img src=\'cid:hanalogo\'>";
			messageHelper.setFrom(setFrom);
			messageHelper.setTo(mail.getToMail());
			messageHelper.setSubject(mail.getTitle());
			messageHelper.setText(contents, true);
			messageHelper.addInline("hanalogo", new FileSystemResource(new File("C:/resources/hana_img/hanacard.png")));
			mailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/mailingService")
	public ModelAndView mailingService(UserVO userVO, HttpSession session) {
		UserVO user = mailingService.selectUserVO(userVO);
		ModelAndView mav = new ModelAndView();
		mav.addObject("userVO", user);
		mav.setViewName("/mailingPage");
		
		List<MailingVO> selectRemainHistory = mailingService.selectRemainHistory(userVO.getCid());
		session.setAttribute("remainHistory", selectRemainHistory);
		
		List<MailingVO> selectPayingHistory = mailingService.selectPayingHistory(userVO.getCid());
		session.setAttribute("history", selectPayingHistory);
		
		return mav;
	}
	
	@GetMapping("/clientLogin")
	public String loginForm() {
		return "/clientLogin";		
	}
	
	@GetMapping("/clientLogout")
	public String logout(HttpSession session, SessionStatus sessionStatus) {
		session.invalidate();
		sessionStatus.setComplete();
		return "/clientLogin";
	}
	//이 부분은 로그인 시에 받아오게 함.
	/*
	 * @PostMapping("/selectRemainHistory/{cid}")
	 * 
	 * @ResponseBody public List<MailingVO> selectRemainHistory(@PathVariable("cid")
	 * String cid, HttpSession session) { List<MailingVO> selectRemainHistory =
	 * mailingService.selectRemainHistory(cid);
	 * session.setAttribute("remainHistory", selectRemainHistory); return
	 * selectRemainHistory; }
	 * 
	 * @PostMapping("/selectPayingHistory/{cid}")
	 * 
	 * @ResponseBody public List<MailingVO> selectPayingHistory(@PathVariable("cid")
	 * String cid, HttpSession session) { List<MailingVO> selectPayingHistory =
	 * mailingService.selectPayingHistory(cid); session.setAttribute("history",
	 * selectPayingHistory); return selectPayingHistory; }
	 */
	
	@PostMapping("/selectPaidBetweenMonth")
	@ResponseBody
	public List<MailingVO> selectPaidBetweenMonth(/* @PathVariable("cid") String cid */ HttpSession session) {
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		List<MailingVO> paidBetweenMonthList = mailingService.selectPaidBetweenMonth(userVO);
		return paidBetweenMonthList;
	}
	
	@PostMapping("/selectMajorUseBusiness/{cid}")
	@ResponseBody
	public List<MailingVO> selectMajorUseBusiness(@PathVariable("cid") String cid) {
		List<MailingVO> majorUseBusinessList = mailingService.selectMajorUseBusiness(cid);
		return majorUseBusinessList;
	}
	
	@PostMapping("/selectClusterUsedCard/{cid}")
	@ResponseBody
	public List<MailingVO> selectClusterUsedCard(@PathVariable("cid") String cid) {
		List<MailingVO> clusterUsedCardList = mailingService.selectClusterUsedCard(cid);
		return clusterUsedCardList;
	}
}
