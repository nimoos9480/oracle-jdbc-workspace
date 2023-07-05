package com.kh.model.vo;

// 테이블 : TB_BOOK

public class Book {
	
	private int bkNo;
	private String bkTitle;
	private String bkAuthor;
	
	public Book() {
		super();
		
	}

	public Book(String bkTitle, String bkAuthor) {
		super();
		this.bkTitle = bkTitle;
		this.bkAuthor = bkAuthor;
	}

	public int getBkNo() {
		return bkNo;
	}

	public void setBkNo(int bkNo) {
		this.bkNo = bkNo;
	}

	public String getBkTitle() {
		return bkTitle;
	}

	public void setBkTitle(String bkTitle) {
		this.bkTitle = bkTitle;
	}

	public String getBkAuthor() {
		return bkAuthor;
	}

	public void setBkAuthor(String bkAuthor) {
		this.bkAuthor = bkAuthor;
	}

	@Override
	public String toString() {
		return "Book [bkNo=" + bkNo + ", bkTitle=" + bkTitle + ", bkAuthor=" + bkAuthor + "]";
	}

	
	
}
