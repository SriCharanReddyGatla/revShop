package com.revShop.models;

public class Product {
	private int id;
    private String name;
    private String description;
    private double price;
    private double discountPrice;
    private String category;
    private byte[] image;
    private int stockQuantity;
    private int sellerId;

  public Product()
  {
	  
  }
	

	public Product(int id, String name, String description, byte[] image,double price, double discountPrice, String category,
		 int stockQuantity,int sellerId) {
	super();
	this.id = id;
	this.name = name;
	this.description = description;
	this.price = price;
	this.discountPrice = discountPrice;
	this.category = category;
	this.image = image;
	this.stockQuantity = stockQuantity;
	this.sellerId=sellerId;
}


	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getDiscountPrice() {
		return discountPrice;
	}
	public void setDiscountPrice(double discountPrice) {
		this.discountPrice = discountPrice;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public int getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}


	public int getSellerId() {
		return sellerId;
	}


	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}
	
    // Getters and Setters
}
