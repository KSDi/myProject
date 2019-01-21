package com.don.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.ProductDao;
import com.don.domain.Product;

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

	
	
	
}
