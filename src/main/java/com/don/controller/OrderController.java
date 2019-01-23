package com.don.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.don.domain.Cart;
import com.don.domain.User;
import com.don.service.CartService;
import com.don.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value = { "/order/insert" }, method = RequestMethod.POST)
	public String purchase(@RequestParam String u_id, @RequestParam int cost,
									   @RequestParam String Buyer_tel, @RequestParam String buyer_addr,
									   @AuthenticationPrincipal User user) {
		
		
		orderService.insertOrder(u_id,user.getId(),buyer_addr,cost);
		
		List<Cart> cartList = cartService.selectList(user.getId());
		for(Cart cart : cartList) {
			orderService.insertOrderProduct(u_id,cart.getModel(),cart.getOpt(),cart.getCount());
		}
		
		return "";
	}
}
