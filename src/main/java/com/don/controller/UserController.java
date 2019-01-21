package com.don.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.don.domain.Cart;
import com.don.domain.User;
import com.don.service.CartService;
import com.don.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CartService cartService;
	
	
	@RequestMapping(value= {"/user/signup"},method =RequestMethod.GET)
	public String signup(Model model) {
		model.addAttribute("user",new User());
		return "/user/signup";
	}
	
	@RequestMapping(value= {"/user/signin"},method =RequestMethod.GET)
	public String signup() {
		return "/user/signin";
	}
	
	@RequestMapping(value="/user/signup",method=RequestMethod.POST)
	public String signup(@ModelAttribute @Valid User user,BindingResult bindingresult,Model model) {
		if(userService.selectOneById(user.getId()) != null) {
			bindingresult.addError(new FieldError("existUser","id",user.getId(),false,new String[] {"existUser"},null,"이미 가입된 아이디입니다"));
		}
		if(!user.getPassword().equals(user.getCheckPassword())) {
			bindingresult.addError(new FieldError("notSamePassword", "password",null,false,new String[] {"notSamePassword1"},null, "비밀번호와 비밀번호확인 불일치"));
			bindingresult.addError(new FieldError("notSamePassword", "CheckPassword",null,false,new String[] {"notSamePassword2"},null, "비밀번호와 비밀번호확인 불일치"));
		}
		if(bindingresult.hasErrors()) {
			return "/user/signup";
		}
		userService.insertUser(user);
		userService.setAuthority(user.getId());
		model.addAttribute("msg","회원가입이 완료되었습니다");
		model.addAttribute("url","redirect:/index");
		return "/etc/result";
	}
	
	@RequestMapping(value="/user/dupCheck",method=RequestMethod.GET)
	@ResponseBody
	public String dupCheck(@RequestParam String id) {
		if("".equals(id)) {
			return "null";
		}
		if(id.length()<6) {
			return "short";
		}
		if(id.length()>15) {
			return "long";
		}
		User user = userService.selectOneById(id);
		if(user != null) {
			return "exist";
		}else {
			return "notexist";
		}
	}
	
	@RequestMapping(value={"/user/basket"},method=RequestMethod.GET)
	public String basket(@AuthenticationPrincipal User user,Model model){
		List<Cart> cartList = cartService.selectList(user.getId());
		model.addAttribute("cartList",cartList);
		model.addAttribute("total",cartService.getTotal(cartList));
		return "/user/basket";
	}
	
	@RequestMapping(value = { "/user/purchase" }, method = RequestMethod.GET)
	public String purchase(@AuthenticationPrincipal User user, Model model) {
		List<Cart> cartList = cartService.selectList(user.getId());
		model.addAttribute("cartList",cartList);
		model.addAttribute("total",cartService.getTotal(cartList));
		model.addAttribute("user",user);
		return "/user/purchase";
	}
}
