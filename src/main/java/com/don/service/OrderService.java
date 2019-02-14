package com.don.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.OrderDao;
import com.don.domain.Order;

@Service
public class OrderService {
	
	@Autowired
	private OrderDao orderDao;

	public void insertOrder(Order order) {
		
		orderDao.insertOrder(order);
		
		}

	public void insertOrderProduct(String u_id, String model, String opt, int count) {
		Map<String,Object> map = new HashMap<>();
		map.put("u_id", u_id);
		map.put("product_id", model);
		map.put("product_opt", opt);
		map.put("count", count);
		
		orderDao.insertOrderProduct(map);
	}

	public Map<String,Integer> getStatus(List<Order> orderList) {
		Map<String,Integer> map = new HashMap<>();
		int waiting=0;
		int delivery=0;
		int complete=0;
		
		for(Order order : orderList) {
			if("배송준비".equals(order.getStatus())) {
				waiting++;
			}else if("배송중".equals(order.getStatus())) {
				delivery++;
			}else {
				complete++;
			}
		}

		map.put("waiting", waiting);
		map.put("delivery", delivery);
		map.put("complete", complete);
		return map;
	}

	public List<Order> selectList(String id) {
		return orderDao.selectList(id);
		
	}

	public List<Order> getTodayOrders() {
		return orderDao.getTodayOrders();
	}

	public List<Order> selectListByStat(String stat) {
		
		return orderDao.selectListByStat(stat);
	}

	public int getTodayRevenue(List<Order> todayOrdersList) {
		int total = 0;
		for(Order todayOrder : todayOrdersList) {
			total += todayOrder.getCost();
		}
		return total;
	}

	
	
}
