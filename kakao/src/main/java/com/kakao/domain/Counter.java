package com.kakao.domain;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document(collection="counters")

public class Counter {
	private String hosting;
	private Long seq;
}
