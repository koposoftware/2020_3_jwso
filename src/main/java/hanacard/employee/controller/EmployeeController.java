package hanacard.employee.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import hanacard.employee.service.EmployeeService;
import hanacard.employee.vo.EmployeeVO;

@SessionAttributes("employeeVO")
@Controller
public class EmployeeController {
	
	@Autowired 
	EmployeeService employeeService;
	
	@GetMapping("/login")
	public String loginForm() {
		return "/loginAndJoin";		
	}
	
	@PostMapping("/login")
	public ModelAndView login(EmployeeVO employee, HttpSession session) {
		EmployeeVO employeeVO = employeeService.login(employee);
		ModelAndView mav = new ModelAndView();
		
		if (employeeVO == null) {
			mav.setViewName("redirect:/login");
			
		} else {
			
			String dest = (String) session.getAttribute("dest");
			if (dest == null) {
				// login 페이지의 프리핸들러를 거치지 않았으면
				mav.setViewName("redirect:/LoanData");
			} else {
				mav.setViewName("redirect:/" + dest);
				session.removeAttribute("dest");
			}
			mav.addObject("employeeVO", employeeVO);
		}
		return mav;
	}

	@RequestMapping("/logout")
	public String logout(SessionStatus status, HttpSession session) {
		status.setComplete(); //세션 attribute에 저장되있는 애들을 다 지워! 라는 뜻.
		session.invalidate();
		return "redirect:/";
	}
	
}
