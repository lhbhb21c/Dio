package com.kakao.domain;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document(collection="chat")
public class Chat {
	
	@Id
	private Long cno;
	private List<Chat2> chat2;
}


