package com.kakao.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kakao.domain.KakaoVO;
import com.kakao.service.KakaoService;
import com.mongodb.WriteResult;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/app")
@AllArgsConstructor
public class appCtr {

	private static final Logger logger = LoggerFactory.getLogger(appCtr.class);
	private KakaoService service;

	@RequestMapping("/joinform")
	public void joinform() {
	}
	@RequestMapping("/admin")
	public void admin() {

	}
	
	//로그인 폼
	@RequestMapping("/loginform")
	public void loginform() {
	}
	//로그인하기==================================================================================
	@PostMapping("/login")
	public ModelAndView login(String userid, String userpw, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		logger.info("입력 아이디 패스워드" +userid +"/"+ userpw);
		boolean result = service.get(userid, userpw, request);
		logger.info("Login service success......." +userid +"/"+ userpw);
		System.out.println(result);
		if(result == true) {
			mav.setViewName("app/friends");
			mav.addObject("msg", "success");
		} else {
			mav.setViewName("app/loginform");
			mav.addObject("msg", "false");
		}
		return mav;

	}

	@RequestMapping("/find")
	public void find() {
	}
	@RequestMapping("/more")
	public void more() {
	}
	//친구목록 폼=============================================================================
	@RequestMapping("/friends")
	public void friends() {

	}

	//회원가입==================================================================================
	@PostMapping("/new")
	public String create(KakaoVO vo, RedirectAttributes rttr){

		int insertCount = service.join(vo);

		rttr.addFlashAttribute("result", vo.getMno());
		if(insertCount == 1) {
			return "app/loginform"; 
		} else {
			return "redirect:joinform";	
		}
	}
	//프로필 조회========================================================================
	@GetMapping({"/profile","/reprofile"})
	public void profile(@RequestParam("mno") Long mno, Model model) {
		System.out.println(mno);

		model.addAttribute("kakao", service.get(mno));

	}	
	//프로필 수정========================================================================
	@PostMapping("/reprofile")
	public String reprofile(KakaoVO vo, RedirectAttributes rttr) {

		WriteResult insertCount = service.modify(vo);
		rttr.addFlashAttribute("result", vo.getMno());

		rttr.addFlashAttribute("result", vo.getMno());
		if(insertCount.getUpsertedId() == null) {
			return "app/friends"; 
		} else {
			return "redirect:joinform";	
		}

	}
	@RequestMapping("/chats")
	public void chats() {
	}
	@GetMapping("/chat")
	public void chat(@RequestParam("mno") Long mno, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		KakaoVO vo = service.get(mno);
		model.addAttribute("cchat", service.get3(mno));
		model.addAttribute("cchat2", service.get3(session.getAttribute("mno")));
		//두사람의 cno(채팅방 넘버를 넘긴다.)
		model.addAttribute("incno", service.get4(session.getAttribute("mno"),vo));
	
		
		
	}
	//채팅방 만들기==============================================================================
	@PostMapping("/crechat")
	public ModelAndView crechat(Long mno, RedirectAttributes rttr, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(true);
		
		KakaoVO vo = service.get(mno);
		//채팅방을 만들기전 기존에 만든 채팅방이 있는지 없는지 확인합니다.
		boolean result = service.get2(session.getAttribute("mno"), vo);
		if(result) {
			//기존에 있는 방이니 기존방으로 이동합니다.
			mav.addObject("cchat", service.get3(mno));
			mav.addObject("cchat2", service.get3(session.getAttribute("mno")));
			//두사람의 cno(채팅방 넘버를 넘긴다.)
			mav.addObject("incno", service.get4(session.getAttribute("mno"),vo));			
			mav.setViewName("app/chat");
			
		}else {
			//없는 채팅방이니 새로 만들어 입장
			mav.addObject("cchat", service.create(session.getAttribute("mno"), mno)); 
			//두사람의 cno(채팅방 넘버를 넘긴다.)
			mav.addObject("incno", service.get4(session.getAttribute("mno"),vo));
			mav.setViewName("app/chat");
			
		}
		
		return mav;
	}
/*	
	@PostMapping("/register")
	public String register(KakaoVO vo, RedirectAttributes rttr) {

		service.register(vo);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
	}
	
	
	*/
	
}	
