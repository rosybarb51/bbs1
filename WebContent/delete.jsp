<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<!-- 받아 올 게 num 하나밖에 없음 -->
<%
	int num = Integer.parseInt(request.getParameter("num"));

/* 	out.println(num); */
	// 여기까지 작성하고 삭제하기 눌러서 번호 넘어오는지 확인하기
	
%>

<!-- 데이터 로딩하기 -->
<%@ include file="dbConn.jsp" %>

<%
	Statement stmt = null;

	try {
		String query = "DELETE FROM bbs WHERE num = " + num + " ";
		
		stmt = conn.createStatement();
		int result = stmt.executeUpdate(query);
		
		if (result > 0) {
			out.println("게시물이 정상적으로 삭제됐습니다.");
		}
	}
	catch (SQLException ex) {
		out.println("게시물 삭제 중 오류가 발생했습니다.");
		out.println("SQLException : " + ex.getMessage());
	}
	finally {
		/* 시작할 때는 커넥션, stmt, result 순서대로 시작하고 
		닫을 때는 result, stmt, 커넥션 순서대로 닫기 */
		if (stmt != null) { stmt.close(); }
		if (conn != null) { conn.close(); }
		
		/* 3초 후에 첫 페이지로 돌아가기 */
		response.setHeader("Refresh", "3;URL=./lists.jsp");
	}
%>