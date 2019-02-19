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
import org.springframework.web.multipart.MultipartFile;

import com.don.domain.Answer;
import com.don.domain.Order;
import com.don.domain.Product;
import com.don.domain.User;
import com.don.exception.CategoryDuplicatedException;
import com.don.service.BoardService;
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
	
	@Autowired
	private BoardService boardService;
	
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
	
	@RequestMapping(value="/admin/product/update", 
	        method=RequestMethod.POST)
	public String productUpdate(@RequestParam String old_model,@RequestParam String model,@RequestParam String category,@RequestParam(required=false) MultipartFile image,@RequestParam(required=false) String content,@RequestParam double discount,@RequestParam int count,@RequestParam int price,
					 HttpServletRequest request) {
	if(content.isEmpty()) {
		content = null;
	}
	Product product = new Product();
	product.setModel(model);
	product.setCategory(category);
	product.setContent(content);
	product.setCount(count);
	product.setDiscount(discount);
	product.setPrice(price);

	if(!image.isEmpty()) {
		String path = 
				request.getServletContext().getRealPath(
						"/WEB-INF/public/image");
		String filename = 
				fileService.saveFile(
						path, image);
		product.setImage(filename);
	}
	
	productService.update(product,old_model);
	
	return "redirect:/admin/product";

	}
	
	@RequestMapping(value = { "/admin/order" }, method = RequestMethod.GET)
	public String order(@AuthenticationPrincipal User user , @RequestParam String status,Model model) {
		model.addAttribute("user",user);
		model.addAttribute("orderList",orderService.selectListByStat(status));
		
		return "admin/order";
	}
	
	@RequestMapping(value= {"/admin/order/view"},method = RequestMethod.GET)
	public String orderView(@AuthenticationPrincipal User user , @RequestParam String order,Model model) {
		Order order1 = orderService.selectOrderByUid(order);
		model.addAttribute("user",user);
		model.addAttribute("order",order1);
		model.addAttribute("orderUser",userService.selectOneById(order1.getBuyer_id()));
		return "admin/orderView";
	}
	@RequestMapping(value= {"/admin/order/status"},method = RequestMethod.GET)
	public String status(@RequestParam String u_id,@RequestParam String change,Model model) {
		orderService.updateStatus(u_id,change);
		
		
		return "redirect:/admin/order/view?order="+u_id;
	}
	
	@RequestMapping(value = { "/admin/qna" }, method = RequestMethod.GET)
	public String adminQna(Model model,@RequestParam(defaultValue="1") int page) {
		model.addAttribute("pageHTML", 
				boardService.getPaging(page));
		
		model.addAttribute("qnaList",boardService.selectQuestionList(page,"admin"));
		return "admin/qna";
	}
	
	@RequestMapping(value = { "/admin/qna/view" }, method = RequestMethod.GET)
	public String qnaView(Model model, @RequestParam int id) {
		model.addAttribute("qna", boardService.selectQuestion(id));
		
		return "admin/qnaView";
	}
	@RequestMapping(value = { "/admin/qna/insert" }, method = RequestMethod.POST)
	public String qnainsert(Model model, @ModelAttribute Answer answer) {
		boardService.insertAnswer(answer);
		model.addAttribute("msg","답변이 등록되었습니다");
		model.addAttribute("url","/admin/qna");
		return "etc/result";
	}
}
