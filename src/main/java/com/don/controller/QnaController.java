package com.don.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.don.domain.Question;
import com.don.domain.User;
import com.don.service.BoardService;

@Controller
public class QnaController {
	
	@Autowired
	private BoardService boardService;
		
	@RequestMapping(value = { "/user/qna" }, method = RequestMethod.GET)
	public String qna(@AuthenticationPrincipal User user,Model model) {
		List<Question> questionList = boardService.selectQuestionList(user.getId());
		model.addAttribute("questionList",questionList);
		model.addAttribute("user",user);
		return "user/qna";
	}
	
	@RequestMapping(value = { "/user/qna/insert" }, method = RequestMethod.GET)
	public String qnaInsert(Model model) {
		model.addAttribute("question", new Question());
		return "qna/insert";
	}
	
}
