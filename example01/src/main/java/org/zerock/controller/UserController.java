package org.zerock.controller;

import javax.inject.*;
import javax.servlet.http.*;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.*;
import org.zerock.dto.*;
import org.zerock.service.*;

@Controller
@RequestMapping("/user")
public class UserController {
	@Inject
	private UserService service;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {
		
	}
	
	@RequestMapping(value="/loginPost", method=RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {
		UserVO vo = service.login(dto);
		
		if(vo == null) {
			return;
		}
		
		model.addAttribute("userVO", vo);
	}
	
}
