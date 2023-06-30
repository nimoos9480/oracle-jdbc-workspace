package config;
/*
 * 디비 서버 정보의 상수값으로 구성된 인터페이스
 * */

public interface ServerInfo {
	
	public String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	public String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	public String USER = "kh";
	public String PASSWORD = "kh";


}
