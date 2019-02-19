package com.don.domain;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class Answer {
	
	private int id,qna_id;
	
	private String regdate;
	
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
	public int getQna_id() {
		return qna_id;
	}
	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}
	@Override
	public String toString() {
		return "Answer [id=" + id + ", qna_id=" + qna_id + ", regdate=" + regdate + ", title=" + title + ", content="
				+ content + "]";
	}
	

	
}
