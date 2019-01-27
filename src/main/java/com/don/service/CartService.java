package com.don.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.don.dao.CartDao;
import com.don.dao.ProductDao;
import com.don.domain.Cart;
import com.don.domain.Product;
import com.don.exception.AlreadyExistCartException;
import com.don.exception.ProductValidationException;

@Service
public class CartService {
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private ProductDao productDao;
	
	public void insert(Cart cart) throws ProductValidationException, AlreadyExistCartException {
		Product remainProduct = productDao.selectOneByModel(cart.getModel());
		if(remainProduct == null) {
			throw new ProductValidationException();
		}
		Cart remainCart = cartDao.selectOne(cart);
		if(remainCart != null) {
			throw new AlreadyExistCartException();
		}
		
		cartDao.insert(cart);
	}

	public List<Cart> selectList(String id) {

		return cartDao.selectList(id);
	}

	public int getTotal(List<Cart> cartList) {
		int total = 0;
		for(Cart cart : cartList) {
			total += (cart.getProduct().getPrice() * ( 1- cart.getProduct().getDiscount())) * cart.getCount();
		}
		return total;
	}

	public void update(int id, int count) {
		Map<String,Integer> map = new HashMap<>();
		map.put("id", id);
		map.put("count", count);
		cartDao.update(map);
		
	}

	public Cart selectOne(int id) {
		return cartDao.selectOne(id);
		
	}

	public void delete(int id) {
		cartDao.delete(id);
		
	}
	
}
