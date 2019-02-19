package com.don.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.BoardDao;
import com.don.domain.Answer;
import com.don.domain.Question;
import com.don.util.Pager;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;

	
	
	public List<Question> selectQuestionList(int page,String id) {
		
		int start = (page - 1) * Pager.BOARDS + 1;
		int end = start + Pager.BOARDS - 1;
		
		Map<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		List<Question> qnaList = boardDao.selectQuestionListP(map);
		
		return qnaList;
	}

	public void insertQna(Question question) {
		
		boardDao.insertQna(question);
	}

	public String getPaging(int page) {
		int total = boardDao.getQnaTotalCount();
		return Pager.paging(page, total);
	}

	public List<Question> selectQuestionList(String id) {
		
		return boardDao.selectQuestionList(id);
	}

	public Question selectQuestion(int id) {
		return boardDao.selectQuestion(id);
	}

	public void insertAnswer(Answer answer) {
		boardDao.insertAnswer(answer);
		boardDao.updateStatus(answer.getQna_id());
	}
}
