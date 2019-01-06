package com.kakao.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeCtr {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeCtr.class);
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("프로젝트트를 위한 톰캣서버 개시 및 시작", locale);
		
		return "home";
	}
	
	@RequestMapping("/qna")
	public String Qna() {
		
		return "qna/qna";
	}
}
