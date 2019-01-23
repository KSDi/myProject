package com.don.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.OrderDao;

@Service
public class OrderService {
	
	@Autowired
	private OrderDao orderDao;

	public void insertOrder(String u_id, String id, String buyer_addr, int cost) {
		Map<String,Object> map = new HashMap<>();
		map.put("u_id", u_id);
		map.put("buyer_id", id);
		map.put("addr", buyer_addr);
		map.put("cost", cost);
		
		orderDao.insertOrder(map);
		
		}

	public void insertOrderProduct(String u_id, String model, String opt, int count) {
		Map<String,Object> map = new HashMap<>();
		map.put("u_id", u_id);
		map.put("product_id", model);
		map.put("product_opt", opt);
		map.put("count", count);
		
		orderDao.insertOrderProduct(map);
	}

	
	
}
