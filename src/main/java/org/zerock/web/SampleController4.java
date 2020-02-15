package org.zerock.web;

import org.slf4j.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

@Controller
public class SampleController4 {
	private static final Logger logger = LoggerFactory.getLogger(SampleController4.class);
	
	@RequestMapping("/doE")
	public String doE(RedirectAttributes rttr) {
		logger.info("doE called but redirect to /doF...................");
		
		rttr.addFlashAttribute("msg", "This is the Message!!! with redirected");
		return "redirect:/doF";
	}
	
	@RequestMapping("/doF")
	public void doF(@ModelAttribute String msg) {
		logger.info("doF called................." + msg);
	}
}
