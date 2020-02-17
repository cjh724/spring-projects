package org.zerock.controller;

import org.slf4j.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

@ControllerAdvice
public class CommonExceptionAdvice {
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	@ExceptionHandler(Exception.class)
	public ModelAndView errorModelAndView(Exception ex) {
		// logger.info(e.toString());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/error_common");
		modelAndView.addObject("exception", ex);
		
		return modelAndView;
	}
}
