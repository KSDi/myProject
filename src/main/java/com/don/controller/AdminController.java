package com.don.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.don.domain.Order;
import com.don.service.OrderService;
import com.don.service.UserService;

@Controller
public class AdminController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = { "/admin/manage" }, method = RequestMethod.GET)
	public String manage(Model model) {
		
		List<Order> todayOrdersList = orderService.getTodayOrders();
		
		model.addAttribute("todayOrders",todayOrdersList.size());
		model.addAttribute("todayRevenue",orderService.getTodayRevenue(todayOrdersList));
		model.addAttribute("wait",orderService.selectListByStat("wait").size());
		model.addAttribute("delivery",orderService.selectListByStat("delivery").size());
		model.addAttribute("newUsers",userService.selectNewUser());
		
		
		return "admin/manage";
	}
	
}