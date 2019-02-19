package com.don.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.don.domain.Order;
@Repository
public class OrderDao {
	
	@Autowired
	private SqlSession session;

	public void insertOrder(Order order) {
		session.insert("order.insertOrder",order);
		
	}

	public void insertOrderProduct(Map<String, Object> map) {
		session.insert("order.insertOrderProduct",map);
		
	}

	public List<Order> selectList(String id) {
		return session.selectList("order.selectList",id);
	}

	public List<Order> getTodayOrders() {
		return session.selectList("order.getTodayOrders");
	}

	public List<Order> selectListByStat(String stat) {
		return session.selectList("order.selectListByStat",stat);
		
	}

	public List<Map<String, Integer>> selectOrderProductCount() {
		return session.selectList("order.selectOrderProductCount");
	}

	public int getMonthRevenue() {
		return session.selectOne("order.getMonthRevenue");
	}

	public Order selectOrderByUid(String u_id) {
		return session.selectOne("order.selectOrderByUid",u_id);
	}

	public void updateStatus(Map<String, String> map) {
		session.update("order.updateStatus",map);
		
	}


	

}
