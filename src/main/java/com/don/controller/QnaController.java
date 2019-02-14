package com.don.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@RequestMapping(value = { "/user/qna/insert" }, method = RequestMethod.POST)
	public String qnaInsert(@ModelAttribute @Valid Question question, BindingResult br,@AuthenticationPrincipal User user) {
		System.out.println(question.getContent());
		if("".equals(question.getContent())){
			br.addError(new FieldError("emptyContent", "content",null,false,new String[] {"emptyContent"},null, "내용을 입력해주세요"));
		}
		if(br.hasErrors()) {
			return "qna/insert";
		}
		question.setUsers_id(user.getId());
		question.setStatus("답변대기");
		boardService.insertQna(question);
		
		return "redirect:/user/qna";
	}
	
}
