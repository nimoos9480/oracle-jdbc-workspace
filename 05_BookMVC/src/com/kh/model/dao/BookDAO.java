package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate{
	
	private Properties p = new Properties();
	
	public BookDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();	
		conn.close();
	
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		rs.close();
		closeAll(st, conn);
	}

	@Override
	public ArrayList<Book> printBookAll() throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		
		ArrayList<Book> bookList = new ArrayList<>();	
		
		ResultSet rs = st.executeQuery();
		
		while(rs.next()) {
		Book b = new Book(rs.getString("bk_title"), rs.getString("bk_author"));
		
		
		bookList.add(b);
		
		}
		
		return bookList;
		
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		
		st.setInt(1, book.getBkNo());
		st.setString(2, book.getBkTitle());
		st.setString(3, book.getBkAuthor());

		st.executeUpdate();
		closeAll(st, conn);
		return book.getBkNo();
	
	}

	@Override
	public int sellBook(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		st.setInt(1, no);

		st.executeUpdate();
		closeAll(st, conn);
		return no;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());

		st.executeUpdate();
		closeAll(st, conn);
		return member.getMemberNo();
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		st.setString(1, id);
		st.setString(2, password);

		ResultSet rs = st.executeQuery();
		Member m = null;
		if(rs.next()) { 
			System.out.println("로그인 성공");
			m = new Member(rs.getString("id"), rs.getString("password"), rs.getString("name"));
	
		}

		closeAll(rs, st, conn);
		return m;
		
	}

	@Override
	public int deleteMember(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("updatePassword"));
		st.setString(1, id);
		st.setString(2, password);

		st.executeUpdate();
		closeAll(st, conn);
		return 0;
	}

	@Override
	public int rentBook(Rent rent) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("getMember"));
		st.setInt(1, rent.setBook());
		
		ResultSet rs = st.executeQuery();
		Member m = null;

		if(rs.next()) {
			m = new Member(rs.getString("member_id"), rs.getString("member_Pwd"), rs.getString("member_Name"));	
		}

		closeAll(rs, st, conn);
		return m;
		
	}

	@Override
	public int deleteRent(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("updatePassword"));
		st.setInt(1, no);

		st.executeUpdate();
		closeAll(st, conn);
		return 0;
		
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
		return null;
	}

}