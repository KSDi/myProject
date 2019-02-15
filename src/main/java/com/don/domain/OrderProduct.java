package com.don.domain;

public class OrderProduct {
	
	String product_id, product_opt;
	int count;
	Product product;
	
	

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getProduct_opt() {
		return product_opt;
	}

	public void setProduct_opt(String product_opt) {
		this.product_opt = product_opt;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
	

}
