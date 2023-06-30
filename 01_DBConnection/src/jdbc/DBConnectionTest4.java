package jdbc;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import config.ServerInfo;

public class DBConnectionTest4 {


	public static void main(String[] args) {
		
		Properties p = new Properties();
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
		
		
			// 1. 드라이버를 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
				
			// 2. 데이터베이스와 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
			
			System.out.println("Connection...!!");				
			
			
			// 3. Statement 객체 생성 - DELETE
			String query = p.getProperty("jdbc.sql.delete");
			PreparedStatement st = conn.prepareStatement(query);
			
			// 4. 쿼리문 실행
			st.setInt(1,2);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 삭제!");
			
			// 결과가 잘 나오는지 확인 - SELECT
			query = p.getProperty("jdbc.sql.select");
			st = conn.prepareStatement(query);
			
			// 4. 쿼리문 실행
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				String empId = rs.getString("emp_id");
				String empName = rs.getString("emp_name");
				String deptTitle = rs.getString("dept_title");
				
				System.out.println(empId + " / " + empName + " / " + deptTitle );

			}
			
		} catch (IOException e1) {
			e1.printStackTrace();
		
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
