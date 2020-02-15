package org.zerock.web;

import org.slf4j.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.*;

@Controller
public class SampleController3 {
	private static final Logger logger = LoggerFactory.getLogger(SampleController3.class);
	
	@RequestMapping("/doD")
	public String doD(Model model) {
		// make sample data
		ProductVO product = new ProductVO("Sample Product", 10000);
		logger.info("doD");
		model.addAttribute(product);
		return "productDetail";
	}
}
