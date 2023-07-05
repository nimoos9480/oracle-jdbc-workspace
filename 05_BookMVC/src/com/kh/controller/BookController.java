package com.kh.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.model.dao.BookDAO;
import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

public class BookController {
	
	private BookDAO dao = new BookDAO();
	private Member member = new Member();
	
	public ArrayList<Book> printBookAll() {
		
		// SQL문 : SELECT, 테이블 : TB_BOOK
		// ArrayList에 추가할 때 add ㅁㅔ서드!
		// rs.getString("bk_title")
		dao.printBookAll();
		return null;
	}
	
	public boolean registerBook(Book book) {
		
		return false;
	}
	
	public boolean sellBook(int no) {
		return false;
	}
	
	public boolean registerMember(Member member) {
		// id, name, password
		return false;
	}
	
	public Member login(String id, String password) {
		
		// char rs.getString("status".charAt(0)
		return null;
	}
	
	public boolean deleteMember() {
		// 업데이트 쓰기 
		// status가 n이면 회원 유지, y면 회원 탈퇴
		// N인 경우만 업데이트
		return false;
	}
	
	
	public boolean rentBook(int no) {
		// 책 대여 기능! INSERT ~~TB_RENT
		return false;
	}
	
	
	public boolean deleteRent(int no) {
		return false;
		
	}
	public ArrayList<Rent> printRentBook() {
		return null;
	}
	
	
}
