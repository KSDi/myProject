package com.don.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.ProductDao;
import com.don.domain.Product;
import com.don.util.Pager;

@Service
public class ProductService {
	
	@Autowired
	private ProductDao productDao;

	public Product selectOneByModel(String model) {
		return productDao.selectOneByModel(model);
	}

	public List<Product> getProductList(Map<String, String> map) {
		return productDao.selectList(map);
	}

	public void insert(Product product) {
		productDao.insert(product);
	}

	public List<Product> selectProductList(int page,String category) {
		int start = (page - 1) * Pager.BOARDS + 1;
		int end = start + Pager.BOARDS - 1;
		
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);
		List<Product> boardList = productDao.selectProductList(map);
		
		return boardList;
	}

	public Object getPaging(int page,String category) {
		int total = productDao.getTotalCount(category);
		return Pager.paging(page, total);
	}
	
	
}
