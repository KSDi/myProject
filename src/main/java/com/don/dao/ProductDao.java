package com.don.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.don.domain.Product;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSession session;

	public List<Product> selectList(Map<String,String> map) {
	
		return session.selectList("product.selectListByCategory",map);
	}

	public Product selectOneByModel(String model) {
		return session.selectOne("selectOneByModel",model);
	}

	public List<String> selectCategoryList() {
		return session.selectList("product.selectCategoryList");
	}
	public int categoryCount(String category) {
		return session.selectOne(
				"product.categoryCount",category);
	}

	public void categoryInsert(String category) {
		session.insert("product.categoryInsert", category);
	}
	public void deleteCategory(String category) {
		session.delete("product.deleteCategory", category);
	}

	public void updateCategory(Map<String,String> map) {
		session.update("product.updateCategory", map);
		
	}
	
	public int productCount(String model) {
		return session.selectOne("product.productCount"
						          ,model);
	}
	
	public void insert(Product product) {
		session.insert("product.insert",product);
	}

	public List<Product> selectProductList(Map<String, Object> map) {
		return session.selectList("product.selectProductList",map);
	}

	public int getTotalCount(String category) {
		return session.selectOne("product.getTotalCount",category);
	}
}
