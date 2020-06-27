package org.zerock.controller;

import java.text.*;
import java.util.*;

import org.slf4j.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public void ajaxTest() {
		
	}
	
	@RequestMapping(value="/test1", method=RequestMethod.GET)
	public String test1(Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("name", "CR7");
		map.put("club", "MU");
		map.put("intArr", new int[]{1, 2, 3, 4, 5});
		
		model.addAttribute("age", 18);
		model.addAllAttributes(map);
		
		return "test/test1";
	}
	
	@RequestMapping(value="/doA", method=RequestMethod.GET)
	public String doA(Locale locale, Model model) {
		System.out.println("doA..................");
		
		return "home2";
	}
	
	@RequestMapping(value="/doB", method=RequestMethod.GET)
	public String doB(Locale locale, Model model) {
		System.out.println("doB..................");
		
		model.addAttribute("result", "DOB RESULT");
		
		return "home2";
	}
	
}
