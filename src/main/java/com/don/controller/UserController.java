package com.don.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
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

import com.don.dao.UserDao;
import com.don.domain.Cart;
import com.don.domain.Order;
import com.don.domain.Question;
import com.don.domain.User;
import com.don.service.BoardService;
import com.don.service.CartService;
import com.don.service.OrderService;
import com.don.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private HttpSession session;
	
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
	
	
	@RequestMapping(value = { "/user/checkEmail" }, method = RequestMethod.POST)
	@ResponseBody
	public String checkEmail(@RequestParam String email) {
		if(!userService.checkValidEmail(email)) {
			return "unvalidEmail";
		}
		if(userService.dupCheckEmail(email) ) {
			return "duplicatedEmail";
		}
		String emailCode ="";
		try {
			emailCode = userService.sendCertifyEmail(email);
		} catch (Exception e) {
			return "error";
		}
		
		session.setAttribute("email", email);
		session.setAttribute("emailCode", emailCode);
		return "success";
	}
	
	@RequestMapping(value = { "/user/checkEmailCode" }, method = RequestMethod.POST)
	@ResponseBody
	public String checkEmailCode(@AuthenticationPrincipal User user,@RequestParam String email, @RequestParam String emailCode) {
		
		if(!((String)session.getAttribute("email")).equals(email)) {
			return "notSameEmail";
		}else if(!((String)session.getAttribute("emailCode")).equals(emailCode)) {
			return "notSameEmailCode";
		}
		
		user.setEmail((String)session.getAttribute("email"));
		System.out.println(user);
		userService.updateEmail(user);
		session.invalidate();
		
		return "success";
		
	}
	
	@RequestMapping(value = { "/user/mypage" }, method = RequestMethod.GET)
	public String mypage(@AuthenticationPrincipal User user,Model model) {
		model.addAttribute("user",user);
		List<Order> orderList = orderService.selectList(user.getId());
		model.addAttribute("status", orderService.getStatus(orderList));
		model.addAttribute("orderList",orderList);
		
		return "user/mypage";
	}
	
	@RequestMapping(value = { "/user/modify" }, method = RequestMethod.GET)
	public String modify(@AuthenticationPrincipal User user,Model model) {
		model.addAttribute("user",user);
		if(session.getAttribute("checkPassword") == null) {
			return "user/checkpassword";
		}
		/*session.invalidate();*/
		return "user/modify";
	}
	
	@RequestMapping(value = { "/user/modify" }, method = RequestMethod.POST)
	public String modify(@AuthenticationPrincipal User user,@ModelAttribute User modUser,@RequestParam String currntPw,Model model) {
		System.out.println(modUser);
		System.out.println(currntPw);
		if(!currntPw.equals(user.getPassword())) {
			model.addAttribute("user",user);
			model.addAttribute("msg","현재 비밀번호를 재확인하세요.");
			model.addAttribute("url","/user/modify");
			return "etc/result";
		}
		if(modUser.getPassword()==null ||modUser.getCheckPassword()==null ||modUser.getPassword().equals(user.getPassword())|| !modUser.getCheckPassword().equals(modUser.getPassword())) {
			model.addAttribute("user",user);
			model.addAttribute("msg","신규 비밀번호를 재확인하세요.");
			model.addAttribute("url","/user/modify");
			return "etc/result";
		}
		modUser.setId(user.getId());
		userService.updatePassword(modUser);
		model.addAttribute("msg","비밀번호 변경이 완료 되었습니다. 재 로그인해주십시오.");
		model.addAttribute("url","/user/signout");
		return "etc/result";
	}
	
	
	@RequestMapping(value = { "/user/checkpassword" }, method = RequestMethod.POST)
	@ResponseBody
	public String checkPassword(@AuthenticationPrincipal User user,@RequestParam String password) {
		if(!password.equals(userService.selectOneById(user.getId()).getPassword())){
			return "notSamePassword";
		}
		session.setAttribute("checkPassword", true);
		return "success";
	}
	
	@RequestMapping(value = { "/user/checkRealPw" }, method = RequestMethod.POST)
	@ResponseBody
	public String checkRealPw(@AuthenticationPrincipal User user, @RequestParam String pw) {
		if(!user.getPassword().equals(pw)) {
			return "unmatch";
		}
		return "match";
	}
	

}
