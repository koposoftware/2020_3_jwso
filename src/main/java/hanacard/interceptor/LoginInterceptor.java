package hanacard.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import hanacard.employee.vo.EmployeeVO;

/*
 * AOP로 채가자!
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		//어느 클래스에서 어떤 메소드가 호출될 때 사용되고 있는지 확인
		if (handler instanceof HandlerMethod) {
			HandlerMethod method = (HandlerMethod) handler;
		}
		//로그인 여부 체크
		HttpSession session = request.getSession();
		EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
		
		if(employeeVO == null) {
			
			String uri = request.getRequestURI(); // 요청이 들어온 페이지에서 로그인을 한 후 다시 그 페이지로 돌려보낸다.
			uri = uri.substring(request.getContextPath().length());
			// ?no=12 이런식으로 뒤에 들어오는 쿼리스트링
			String query = request.getQueryString();
			System.out.println(query);
			
			if(query != null && query.length() != 0) { // ?나 ?no=11 이 경우 둘다 제어
				uri = uri + "?" + query;
			}
			session.setAttribute("dest", uri);
			response.sendRedirect(request.getContextPath()+"/login");
			
			//로그인 되어있지 않으면 바로 로그인으로 리다이렉트, 리턴 false인 경우 화면 출력 X
			return false;
		}
		return true;
	}
}
