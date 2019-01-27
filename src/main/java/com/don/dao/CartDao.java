package com.don.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.don.domain.Cart;
@Repository
public class CartDao {
	
	@Autowired
	private SqlSession session;
	
	public void insert(Cart cart) {
		session.insert("cart.insert",cart);
	}

	public Cart selectOne(Cart cart) {
		return session.selectOne("cart.selectOne",cart);
	}

	public List<Cart> selectList(String id) {
		return session.selectList("cart.selectList",id);
	}

	public void update(Map<String, Integer> map) {
		session.update("cart.update",map);
	}

	public Cart selectOne(int id) {
		return session.selectOne("cart.selectOneById",id);
	}

	public void delete(int id) {
		session.delete("cart.delete",id);
		
	}
	
}
