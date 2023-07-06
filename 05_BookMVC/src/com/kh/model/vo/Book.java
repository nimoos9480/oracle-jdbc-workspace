package com.kh.model.vo;

// 테이블 : TB_BOOK / 컬럼 : bk_no, bk_title, bk_author

public class Book {
	
	private int bkNo;
	private String bkTitle;
	private String bkAuthor;
	
	public Book(String title, String author) {
		this.bkTitle = title;
		this.bkAuthor = author;
	}

	public Book(int bkNo, String bkTitle, String bkAuthor) {
		this.bkNo = bkNo;
		this.bkTitle = bkTitle;
		this.bkAuthor = bkAuthor;
	}

	public Book(int no) {
		this.bkNo = no;
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