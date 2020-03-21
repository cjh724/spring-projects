package org.zerock.controller;

import java.util.*;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.*;

@RestController
@RequestMapping("/sample")
public class SampleController {
	
	@RequestMapping("/hello")
	public String sayHello() {
		return "Hello World";
	}
	
	@RequestMapping("/sendVO")
	public SampleVO sendVO() {
		SampleVO vo = new SampleVO();
		vo.setFirstName("흥민");
		vo.setLastName("손");
		vo.setMno(7);
		
		return vo;
	}
	
	@RequestMapping("/sendList")
	public List<SampleVO> sendList() {
		List<SampleVO> list = new ArrayList<>();
		SampleVO vo = new SampleVO();
		
		for(int i=0; i<10; i++) {
			vo.setFirstName("메시");
			vo.setLastName("리오넬");
			vo.setMno(10);
			list.add(vo);
		}
		
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<Integer, SampleVO> sendMap() {
		Map<Integer, SampleVO> map = new HashMap<>();
		SampleVO vo = new SampleVO();
		
		for(int i=0; i<10; i++) {
			vo.setFirstName("루피");
			vo.setLastName("몽키");
			vo.setMno(9);
			map.put(i, vo);
		}
		
		return map;
	}
	
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth() {
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);		// 400 Bad Request
	}
	
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<SampleVO>> sendListNot() {
		List<SampleVO> list = new ArrayList<>();
		SampleVO vo = new SampleVO();
		
		for(int i=0; i<10; i++) {
			vo.setFirstName("사춘기");
			vo.setLastName("볼빨간");
			vo.setMno(10);
			list.add(vo);
		}
		
		return new ResponseEntity<>(list, HttpStatus.NOT_FOUND);	// 404 Not Found
	}
}
