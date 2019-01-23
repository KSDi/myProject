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

import com.don.domain.Product;
import com.don.domain.User;
import com.don.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value="/product/view",method=RequestMethod.GET)
	public String viewProduct(@RequestParam String model,Model md) {
		Product product = productService.selectOneByModel(model);
		md.addAttribute("product",product);
		return "product/view";
	}
	
	@RequestMapping(value={"/"}, method=RequestMethod.GET)
	public String index(Model model) {
		List<Product> productList =
				productService.getProductList(new HashMap<>());
		model.addAttribute("productList", productList);
		return "index";
	}
	
	@RequestMapping(value={"/product/list"}, method=RequestMethod.GET)
	public String list(
		@RequestParam(required=false) String category,
		@RequestParam(required=false) String order,
		@RequestParam(required=false) String base,
		Model model) {
		
		Map<String, String> map = new HashMap<>();
		map.put("category", category);
		map.put("order",order);
		map.put("base", base);
		
		List<Product> productList =
				productService.getProductList(map);
		model.addAttribute("productList", productList);
		
		return "product/list";
	}
	
}
