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

	
}
