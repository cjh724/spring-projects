package org.zerock.interceptor;

import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.ui.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.handler.*;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) != null) {
			logger.info("clear login data before");
			session.removeAttribute(LOGIN);
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object userVO = modelMap.get("userVO");
		
		if(userVO != null) {
			logger.info("new login success");
			session.setAttribute(LOGIN, userVO);
			response.sendRedirect("/");
		}
	}
	
}
