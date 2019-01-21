package com.don.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.don.domain.Cart;
import com.don.domain.User;
import com.don.exception.AlreadyExistCartException;
import com.don.exception.ProductValidationException;
import com.don.service.CartService;

@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value="/cart/insert",method=RequestMethod.GET, produces="text/html; charset=utf-8")
	@ResponseBody
	public String insert(@RequestParam String model,@RequestParam String opt,
								  @AuthenticationPrincipal User user) {
		Cart cart = new Cart();
		cart.setUser_id(user.getId());
		cart.setModel(model);
		cart.setOpt(opt);
		
		try {
			cartService.insert(cart);
		} catch (ProductValidationException e) {
			StringBuffer html = new StringBuffer();
			html.append("<script>");
			html.append("alert('존재하지 않는 상품입니다.');");
			html.append("location.href='/product/list';");
			html.append("</script>");
			return html.toString();
		} catch (AlreadyExistCartException e) {
			StringBuffer html = new StringBuffer();
			html.append("<script>");
			html.append("var check = confirm('이미 존재하는 상품입니다.\\n 장바구니로 이동하시겠습니까?');");
			html.append("if(check){ location.href='/user/basket' }");
			html.append("</script>");
			return html.toString();
		}
		
		StringBuffer html = new StringBuffer();
		html.append("<script>");
		html.append("var check = confirm('장바구니로 이동하시겠습니까?');");
		html.append("if(check){ location.href='/user/basket' }");
		html.append("else{ location.href='/product/list' }");
		html.append("</script>");
		
		return html.toString();
	}
	
	
	@RequestMapping(value = { "/cart/update" }, method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Integer> cartUpdate(@RequestParam int id,@RequestParam int count,@AuthenticationPrincipal User user) {
		cartService.update(id, count);
		
		Map<String,Integer> map = new HashMap<>();
		Cart cart = cartService.selectOne(id);
		List<Cart> cartList = cartService.selectList(user.getId());
		
		map.put("price", (int) ((cart.getProduct().getPrice()*(1-cart.getProduct().getDiscount()))*cart.getCount()));
		map.put("total", cartService.getTotal(cartList));
		
		return map;
	}
	
}
