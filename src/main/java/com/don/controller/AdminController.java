package com.don.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.don.domain.Order;
import com.don.domain.Product;
import com.don.domain.User;
import com.don.exception.CategoryDuplicatedException;
import com.don.service.FileService;
import com.don.service.ManageService;
import com.don.service.OrderService;
import com.don.service.ProductService;
import com.don.service.UserService;

@Controller
public class AdminController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ManageService manageService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private ProductService productService;
	
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
	
	@RequestMapping(value="/admin/category",method=RequestMethod.GET)
	public String categories(@AuthenticationPrincipal User user ,Model model) {
		model.addAttribute("user",user);
		return "admin/category";
	}
	
	
	@RequestMapping(value="/admin/category/delete", 
			method=RequestMethod.GET)
	public String categoryDelete(
		@RequestParam String category) {
	manageService.delete(category);
	return "redirect:/admin/category";
	}
	
	@RequestMapping(value="/admin/category/update", 
				method=RequestMethod.GET)
	public String categoryUpdate(
		@RequestParam String category,
		@RequestParam(value="new") String newCategory) {
	
	manageService.update(category, newCategory);
	return "redirect:/admin/category";
	}
	
	@RequestMapping(value="/admin/category/insert",
				method=RequestMethod.POST)
	public String insert(@RequestParam String category,
					 Model model) {
	
	try {
		manageService.insertCategory(category);
		model.addAttribute("msg", "등록에 성공했습니다.");
		System.out.println("g");
	} catch (CategoryDuplicatedException e) {
		model.addAttribute("msg", "이미 존재하는 카테고리입니다.");
	}
	model.addAttribute("url", "/admin/category");
	System.out.println("gg");
	
	return "etc/result";
	
	}
	
	@RequestMapping(value="/admin/product/dualcheck", 
			method=RequestMethod.POST)
	@ResponseBody
	public String dualcheck(@RequestParam String model) {
		int count = manageService.dualcheck(model);
		if(count == 0) {
			return "notdulplicated";
		}else {
			return "duplicated";
		}
	}
	
	@RequestMapping(value="/admin/product/insert", 
	        method=RequestMethod.POST)
	public String insert(@ModelAttribute Product product,
					 HttpServletRequest request) {
	String path = 
			request.getServletContext().getRealPath(
					"/WEB-INF/public/image");
	String filename = 
			fileService.saveFile(
					path, product.getImage_file());
	product.setImage(filename);
	productService.insert(product);
	
	return "redirect:/admin/product";

	}
	
	@RequestMapping(value = { "/admin/product" }, method = RequestMethod.GET)
	public String product(@AuthenticationPrincipal User user,@RequestParam(defaultValue="all") String category,@RequestParam(defaultValue="1") int page,Model model) {
		model.addAttribute("pageHTML", 
				productService.getPaging(page,category));
		
		model.addAttribute("productList",productService.selectProductList(page,category));
		model.addAttribute("user",user);
		return "admin/product";
	}
	@RequestMapping(value = { "/admin/product/update" }, method = RequestMethod.GET)
	public String productUpdate(Model model,@RequestParam String name) {
		model.addAttribute("product",productService.selectOneByModel(name));
		return "admin/update";
	}
}
