package com.don.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.don.dao.ProductDao;

@Component
public class CategoryListInterceptor 
					extends HandlerInterceptorAdapter {
	@Autowired
	private ProductDao productDao;
	@Override
	public boolean preHandle(HttpServletRequest request, 
							 HttpServletResponse response, 
							 Object handler)
			throws Exception {
		List<String> categoryList =
				productDao.selectCategoryList();
		request.setAttribute("categoryList", categoryList);
		
		return true; 
	}
	
	
	
	
}
