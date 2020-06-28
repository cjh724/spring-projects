package org.zerock.interceptor;

import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.web.servlet.handler.*;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login") == null) {
			logger.info("current user is not logined");
			response.sendRedirect("/user/login");
			
			saveDest(request);		// 사용자가 원하는 URI 저장
			
			return false;
		}
		
		return true;
	}
	
	private void saveDest(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		if(request.getMethod().equals("GET")) {
			logger.info("dest : " + (uri + query));
			request.getSession().setAttribute("dest", uri + query);
		}
	}
	
}
