package com.don.domain;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class Question {
	
	private int id;
	private String users_id,regdate,status;
	
	@Pattern(regexp="[\\s0-9A-Za-z가-힣ㄱ-ㅎㅏ-ㅣ!@#*_-]{1,50}",
			 message="숫자,알파벳,한글,!@#*-_에 1 ~ 50이하의 문자")
	private String title;
	
	@NotNull(message="내용을 입력해 주세요")
	private String content;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsers_id() {
		return users_id;
	}
	public void setUsers_id(String users_id) {
		this.users_id = users_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	} 

	
}
