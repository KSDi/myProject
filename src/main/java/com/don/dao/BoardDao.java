package com.don.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.don.domain.Question;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession session;

	public List<Question> selectQuestionList(String id) {
		return session.selectList("board.selectQuestionList",id);
	}
	
	
	
}
