package com.don.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class OrderDao {
	
	@Autowired
	private SqlSession session;

	public void insertOrder(Map<String, Object> map) {
		session.insert("order.insertOrder",map);
		
	}

	public void insertOrderProduct(Map<String, Object> map) {
		session.insert("order.insertOrderProduct",map);
		
	}
	
	

}
