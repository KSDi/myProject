package com.don.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.don.domain.Answer;
import com.don.domain.Question;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession session;

	public List<Question> selectQuestionList(String id) {
		return session.selectList("qna.selectList",id);
	}

	public void insertQna(Question question) {
		session.insert("qna.insertQna",question);
		
	}

	public int getQnaTotalCount() {
		return session.selectOne("qna.getQnaTotalCount");
	}

	public List<Question> selectQuestionListP(Map<String, Integer> map) {
		return session.selectList("qna.selectQuestionListP",map);
	}

	public Question selectQuestion(int id) {
		return session.selectOne("qna.selectQuestion",id);
	}

	public void insertAnswer(Answer answer) {
		session.insert("qna.insertAnswer",answer);
		
	}

	public void updateStatus(int qna_id) {
		session.update("qna.updateStatus",qna_id);
		
	}
	
	
}
