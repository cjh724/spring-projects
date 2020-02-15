package org.zerock.web;

import org.slf4j.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class SampleController2 {
	private static final Logger logger = LoggerFactory.getLogger(SampleController2.class);
	
	@RequestMapping("doC")
	public String doC(@ModelAttribute("msg") String msg) {
		logger.info("doC called....................");
		
		return "result";
	}
}
