package com.don.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.don.domain.Cart;
import com.don.domain.Order;
import com.don.domain.User;
import com.don.service.CartService;
import com.don.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value = { "/order/insert" }, method = RequestMethod.POST, produces="text/html; charset=utf-8")
	@ResponseBody
	public String purchase(@RequestParam String u_id, @RequestParam int cost,
									   @RequestParam String buyer_addr,@RequestParam String delivery_name,
									   @AuthenticationPrincipal User user) {
		
		Order order = new Order();
		order.setU_id(u_id);
		order.setBuyer_id(user.getId());
		order.setAddr(buyer_addr);
		order.setCost(cost);
		order.setDelivery_name(delivery_name);
		order.setStatus("배송준비");
		
		orderService.insertOrder(order);
		
		List<Cart> cartList = cartService.selectList(user.getId());
		for(Cart cart : cartList) {
			orderService.insertOrderProduct(u_id,cart.getModel(),cart.getOpt(),cart.getCount());
		}
		cartService.deleteCart(user.getId());
		return "success";
	}
}
