package com.don.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.ProductDao;
import com.don.exception.CategoryDuplicatedException;

@Service
public class ManageService {
	
	@Autowired
	private ProductDao productDao;

	public void delete(String category) {
		productDao.deleteCategory(category);
	}

	public void update(String category, String newCategory) {
		Map<String, String> map = new HashMap<>();
		map.put("category", category);
		map.put("newCategory", newCategory);
		productDao.updateCategory(map);
		
	}

	public void insertCategory(String category) 
				throws CategoryDuplicatedException {
		int count = productDao.categoryCount(category);
		if(count == 1) {
			throw new CategoryDuplicatedException();
		}
		
		productDao.categoryInsert(category);
		 
	}
	public int dualcheck(String model) {
		return productDao.productCount(model);
	}
}






