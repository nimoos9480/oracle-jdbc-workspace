package com.kh.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.print.attribute.standard.JobKOctets;

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
		try {
			return dao.printBookAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean registerBook(Book book) {
		try {
			if(dao.registerBook(book)==1) return true;  // 1 : 실행이 1번 됐다는 뜻
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean sellBook(int no) {
		try {
			if(dao.sellBook(no) == 1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean registerMember(Member member) {
		// id, name, password
		
		try {
			if(dao.registerMember(member)==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public Member login(String id, String password) {
		try {
			member = dao.login(id, password);
			return member;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return null;
	}
	
	public boolean deleteMember() {
		try {
			if(dao.deleteMember(member.getMemberId(), member.getMemberPwd())==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return false;
	}
	
	
	public boolean rentBook(int no) {
		try {
		if(dao.rentBook(new Rent(new Member(member.getMemberNo()), new Book(no))) == 1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	public boolean deleteRent(int no) {
		
		try {
			if(dao.deleteRent(no)==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
		
	}
	public ArrayList<Rent> printRentBook() {
		try {
			return dao.printRentBook(member.getMemberId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
