package com.kakao.domain;

import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document(collection="kakao")
public class KakaoVO {
	
	@Id
	private Long mno;
	private Long bno;
	
	private String userid;	
	private String userpw;

	private String uid;
	private String userName;

	private Date regdate;
	private Date updateDate;

	private String address;
	private int code;
	private String state;
	
	private List<FriendVO> friendsVO;
	private List<ChatVO> chatVO;
	
	
	    }
	
