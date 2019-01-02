package com.kakao.controller;
	
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kakao.domain.Chat;
import com.kakao.domain.Chat2;
import com.kakao.domain.FriendVO;
import com.kakao.domain.KakaoVO;
import com.kakao.service.KakaoService;
import com.mongodb.WriteResult;

import lombok.AllArgsConstructor;

@RestController
//JSP와 달리 순수한 데이터를 반환하는 형태이므로 다양한 포멧 데이터를 전송할수 있다. 주로 JSON, XML등을 사용한다.
@RequestMapping("/kakao/")
@AllArgsConstructor
public class kakaoCtr {

	private KakaoService service;
	
	//등록작업==============================================================
	private static final Logger logger = LoggerFactory.getLogger(kakaoCtr.class);
	
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
			public ResponseEntity<String> create(@RequestBody KakaoVO vo){
		
		 int insertCount = service.register(vo);
		 
		 return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//목록조회===========================================================================
	@GetMapping(value="/list/{mno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<KakaoVO>> getList(@PathVariable("mno") Long mno) {
		
		logger.info("get List............................");
	return new ResponseEntity<>(service.getList(mno), HttpStatus.OK);
	
	}

	
	//조회작업==================================================================
	@GetMapping(value="/{mno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<KakaoVO> get(@PathVariable("mno") Long mno){
	System.out.println(service.get(mno));
		return new ResponseEntity<>(service.get(mno), HttpStatus.OK);
	}	

	
	//삭제작업====================================================================================
	@DeleteMapping(value = "/{mno}",
			produces = {MediaType.TEXT_PLAIN_VALUE})
			public ResponseEntity<String> remove(@PathVariable("mno") Long mno){
		
		WriteResult insertCount = service.remove(mno);
	
		
		 return insertCount.getUpsertedId() == null ? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	
		
		}

	//수정작업=======================================================================================
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
		value="/{mno}",
		consumes = "application/json",
		produces = {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> modify(
				@RequestBody KakaoVO vo,
				@PathVariable("mno") Long mno) {
			
		WriteResult insertCount = service.modify(vo);
			
			return insertCount.getUpsertedId() == null
					? new ResponseEntity<>("success", HttpStatus.OK)
							: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
				
		}
	
	//친구추가작업==============================================================
	
	@PostMapping(value = "/new2",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
			public ResponseEntity<String> add(@RequestBody FriendVO vo,  HttpSession session){
		System.out.println("친구추가작업이 시작됩니다.");
		
		 int insertCount = service.add(vo, session.getAttribute("mno"));
		 
		 return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//채팅내용s 조회===========================================================================
	@GetMapping(value="/list2/{cno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<Chat2>> getList2(@PathVariable("cno") Long cno) {
		
		logger.info("get List............................");
		return new ResponseEntity<>(service.getList2(cno), HttpStatus.OK);
		
	}
	//채팅내용저장 ===========================================================================
	
	@PostMapping(value = "/new3",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
			public ResponseEntity<String> add2(@RequestBody Chat vo){
		System.out.println("채팅입력추가작업이 시작됩니다.");
		
		System.out.println(vo);
		int insertCount = service.add2(vo);
		 
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//수신 확인 데이터처리 ===========================================================================
	
	@PostMapping(value = "/confirm",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
			public ResponseEntity<String> confirm(@RequestBody Chat vo){
		System.out.println("수신상태를 true로 바꿀것이다.");
		System.out.println(vo);
		WriteResult confirm = service.confirm(vo);
		 
		return confirm.getUpsertedId() == null ? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}