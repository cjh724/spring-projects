package org.zerock.interceptor;

import java.lang.reflect.*;

import javax.servlet.http.*;

import org.springframework.web.method.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.handler.*;

public class SampleInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		// return super.preHandle(request, response, handler);
		System.out.println("==========================================================================");
		System.out.println("pre handle...............");
		
		HandlerMethod method = (HandlerMethod) handler;
		Method methodObj = method.getMethod();
		
		System.out.println("Bean : " + method.getBean());
		System.out.println("Method : " + methodObj);
		System.out.println("==========================================================================");
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		// super.postHandle(request, response, handler, modelAndView);
		System.out.println("==========================================================================");
		System.out.println("post handle...............");
		
		Object result = modelAndView.getModel().get("result");
		
		if(result != null) {
			request.getSession().setAttribute("result", result);
			response.sendRedirect("/doA");
		}
		System.out.println("==========================================================================");
	}
	
}
