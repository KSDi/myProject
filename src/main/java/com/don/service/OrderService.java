package com.don.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.OrderDao;
import com.don.domain.Order;
import com.don.domain.OrderProduct;

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

	public List<Map<String, Integer>> selectOrderProductCount() {
		return orderDao.selectOrderProductCount();
	}

	public int getMonthRevenue() {
		return orderDao.getMonthRevenue();
	}

	public Map<String, Integer> selectCategoryCostList() {
		List<Order> orderList = orderDao.selectList("admin");
		int outer = 0;
		int pants = 0;
		int acc = 0;
		int top = 0;
	
		for(Order order : orderList) {
			for(OrderProduct orderProduct : order.getProducts()) {
				String productCategory = orderProduct.getProduct().getCategory();
				if(productCategory.equals("outer")){
					outer += orderProduct.getCount() * orderProduct.getProduct().getPrice() * (1- orderProduct.getProduct().getDiscount());
				}else if(productCategory.equals("acc")) {
					acc += orderProduct.getCount() * orderProduct.getProduct().getPrice() * (1- orderProduct.getProduct().getDiscount());
				}else if(productCategory.equals("pants")) {
					pants += orderProduct.getCount() * orderProduct.getProduct().getPrice() * (1- orderProduct.getProduct().getDiscount());
				}else if(productCategory.equals("top")) {
					top += orderProduct.getCount() * orderProduct.getProduct().getPrice() * (1- orderProduct.getProduct().getDiscount());
				}
			}
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("outer", outer);
		map.put("acc", acc);
		map.put("pants", pants);
		map.put("top", top);
		
		return map;
	}

	
	
}
