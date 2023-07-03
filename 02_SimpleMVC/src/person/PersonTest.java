package person;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import config.ServerInfo;

public class PersonTest {
	
	private Properties p = new Properties();
	
	public PersonTest() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	// 고정적인 반복메서드기 때문에 밖으로 빼줌 -- 디비연결, 자원반납
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}
	
	public void closeAll(Connection conn, PreparedStatement st) throws SQLException {
		if(st != null) st.close();
		if(conn != null) conn.close();
	}
	
	public void closeAll(Connection conn, PreparedStatement st, ResultSet rs) throws SQLException {
		if(rs != null) rs.close();
		closeAll(conn, st);
	}
	
	
	
	
	// 변동적인 반복..! 비즈니스 로직 DAO(Database Access Object)
	public void addPerson (String name, String address) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("addPerson"));
		st.setString(1, name);
		st.setString(2, address);
		
		int result = st.executeUpdate();
		if(result == 1) {
		System.out.println(name + "님, 추가!");
		}
		
		closeAll(conn, st);
	}
	
	public void removePerson (int id) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("removePerson"));
		st.setInt(1, id);
		
		int result = st.executeUpdate();
		System.out.println(result + "명 삭제!");
		
		closeAll(conn, st);
	
	}
	
	public void updatePerson(int id, String address) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("updatePerson"));
		st.setString(1, address);
		st.setInt(2, id);
		
		int result = st.executeUpdate();
		System.out.println(result + "명 수정!");
		
		closeAll(conn, st);

		
	}
	public void searchAllPerson() throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("searchAllPerson"));
		
		
		ResultSet rs = st.executeQuery();
		
		while(rs.next()) {
		System.out.println(rs.getString("name") + ", " + rs.getString("address"));
		}
		
		closeAll(conn, st);
		
		
	}
	
	public void viewPerson(int id) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("viewPerson"));
		st.setInt(1, id);
		
		ResultSet rs = st.executeQuery();
		
		if(rs.next()) { // 하나니까 if써도 됨
			System.out.println(rs.getString("name") + ", " + rs.getString("address"));
			}
			
		
		closeAll(conn, st);
		
	}
	
	
	
	public static void main(String[] args) {
		
		PersonTest pt = new PersonTest();
		
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("Driver Loading!");
		
			

			pt.addPerson("김강우", "서울");
			pt.addPerson("고아라", "제주도");
			pt.addPerson("강태주", "경기도");
			
			pt.searchAllPerson();
			
			pt.removePerson(3); // 강태주 삭제
			
			pt.updatePerson(1, "제주도");
			
			pt.viewPerson(1);
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		

		
	}

}
