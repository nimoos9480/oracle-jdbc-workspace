package com.kh.controller;

import java.sql.SQLException;

import com.kh.model.dao.MemberDAO;
import com.kh.model.vo.Member;

public class MemberController {

	private MemberDAO dao = new MemberDAO();
	
	// controller 에서 try~catch!
	public boolean joinMembership(Member m) {
		
		// id가 없다면 회원가입 후 true 반환
		// 없다면 false 값 반환
		try {
			Member member = dao.getMember(m.getId());
			
			if (member == null) {
				dao.registerMember(m);
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	
	public String login(String id, String password) {

		
		// 로그인 성공하면 이름 반환
		// 실패하면 null 반환
		Member member = new Member();
		member.setId(id);
		member.setPassword(password);
		
		try {
			
			Member result = dao.login(member);
			
			if(result != null){
				return result.getName();
			} 
			return null;
	
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
			
	}
	
	public boolean changePassword(String id, String oldPw, String newPw) {

		// 로그인 했을 때 null이 아닌 경우
		// 비밀번호 변경 후 true 반환, 아니라면 false 반환
		Member member = new Member();
		member.setId(id);
		member.setPassword(oldPw);
		
		try {
		
			if(dao.login(member)!= null) {
				member.setPassword(newPw);
				dao.updatePassword(member);
				return true;
				
			} else {
				return false;
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
	}
	
	public void changeName(String id, String name) {

		// 이름 변경!
		Member member = new Member();
		member.setId(id);
		member.setName(name);
		try {		
			
			dao.updateName(member);			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}


}