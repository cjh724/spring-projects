package org.zerock.web;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.*;

@Controller
public class SampleController5 {
	@RequestMapping("/doJSON")
	public @ResponseBody ProductVO doJSON() {
		ProductVO vo = new ProductVO("샘플상품", 30000);
		return vo;
	}
}
