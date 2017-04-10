package com.trajectory.pojo;

@SuppressWarnings("serial")
public class Painting implements java.io.Serializable{
	
	private int id;
	private String title;
	private String descript;
	private String author;
	private PaintingType paintingType;
	
	private String paintingTime;
	
	private String createTime;
	private String updateTime;
	
	private float originalPrice;
	private float discountPrice;
	
	private String imageUrl;
	private String state;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescript() {
		return descript;
	}
	public void setDescript(String descript) {
		this.descript = descript;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	
	public PaintingType getPaintingType() {
		return paintingType;
	}
	public void setPaintingType(PaintingType paintingType) {
		this.paintingType = paintingType;
	}
	
	public String getPaintingTime() {
		return paintingTime;
	}
	public void setPaintingTime(String paintingTime) {
		this.paintingTime = paintingTime;
	}
	
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	public float getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(float originalPrice) {
		this.originalPrice = originalPrice;
	}
	public float getDiscountPrice() {
		return discountPrice;
	}
	public void setDiscountPrice(float discountPrice) {
		this.discountPrice = discountPrice;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

}
