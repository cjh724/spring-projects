package org.zerock.controller;

import java.net.*;
import java.util.*;

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
		InetAddress local;
		
		try {
			local = InetAddress.getLocalHost();
			String ip = local.getHostAddress();
			
			System.out.println("local ip : " + ip);
		} catch(UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/loginPost", method=RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {
		UserVO vo = service.login(dto);
		
		if(vo == null) {
			return;
		}
		
		model.addAttribute("userVO", vo);
		
		if(dto.isUseCookie()) {
			int amount = 60 * 60 * 24 * 7;
			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
			
			service.keepLogin(vo.getUid(), session.getId(), sessionLimit);
		}
	}
	
}
