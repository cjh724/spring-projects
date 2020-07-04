package org.zerock.interceptor;

import javax.inject.*;
import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.web.servlet.handler.*;
import org.springframework.web.util.*;
import org.zerock.domain.*;
import org.zerock.service.*;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Inject
	private UserService service;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		System.out.println(">>>> " + session.getAttribute("login"));
		
		if(session.getAttribute("login") == null) {
			logger.info("current user is not logined");
			
			saveDest(request);		// 사용자가 원하는 URI 저장
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				UserVO userVO = service.checkLoginBefore(loginCookie.getValue());
				
				logger.info("userVO : " + userVO);
				
				if(userVO != null) {
					session.setAttribute("login", userVO);
					return true;
				}
			}
			
			response.sendRedirect("/user/login");
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
