package com.don.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.don.domain.Order;
import com.don.domain.User;
import com.don.service.OrderService;
import com.don.service.UserService;

@Controller
public class AdminController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value = { "/admin/dashboard" }, method = RequestMethod.GET)
	public String manage(@AuthenticationPrincipal User user ,Model model) {
		List<Order> todayOrdersList = orderService.getTodayOrders();
		
		model.addAttribute("orderList",orderService.selectList("all"));
		model.addAttribute("todayOrders",todayOrdersList.size());
		model.addAttribute("todayRevenue",orderService.getTodayRevenue(todayOrdersList));
		model.addAttribute("monthRevenue",orderService.getMonthRevenue());
		model.addAttribute("categoryCostMap",orderService.selectCategoryCostList());
		model.addAttribute("wait",orderService.selectListByStat("wait").size());
		model.addAttribute("delivery",orderService.selectListByStat("delivery").size());
		model.addAttribute("newUsers",userService.selectNewUser());
		model.addAttribute("orderProducts",orderService.selectOrderProductCount());
		model.addAttribute("user",user);
		
		return "admin/dashboard";
	}
	
	@RequestMapping(value="/admin/categories",method=RequestMethod.GET)
	public String categories(@AuthenticationPrincipal User user ,Model model) {
		model.addAttribute("user",user);
		return "admin/category";
	}
	
}
