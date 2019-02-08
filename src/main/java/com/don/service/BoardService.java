package com.don.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.BoardDao;
import com.don.domain.Question;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;

	public List<Question> selectQuestionList(String id) {
		return boardDao.selectQuestionList(id);
	}
	
}
