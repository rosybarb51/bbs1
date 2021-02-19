<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String comments = request.getParameter("comments");
	int num = Integer.parseInt(request.getParameter("num"));
	int views = Integer.parseInt(request.getParameter("views"));
	/* 원래 조회수 카운트 하는 건 select.jsp에서 해야하는데 지금 꼬였다.. */
	/* 지금 update.jsp에 views++; 해놔서 수정해야지만 조회수 카운트가 올라간다 */
	views++;
%>

<!-- 이 페이지에서는 뭐 보여줄 필요가 없다.  -->

<%@ include file="dbConn.jsp" %>

<!-- 워크밴치가서 업데이트 문 작성해서 실행해보고 가져와서 작성하기 -->
<%
	Statement stmt = null;

	try {
	String query = "UPDATE bbs ";
	query += "SET title = '" + title + "', ";
	query += "comments='" + comments + "', ";
	query += "views= " + views + " ";
	query += "WHERE num = " + num + " ";
	
	stmt = conn.createStatement();
	/* 아래의 result는 딱히 활용하지 않는다. update나 insert, delete는 실행하면 select와 다르게 적용된 것이 '몇 행 실행 했습니다.' 라고 결과물이 result에 그 몇 행의 숫자가 뜬다. ->if 문 써서 그 값이 0이상이면 실행됐다고 알려주거나 할 때 활용하라고 나온다..  */
	/* select문은 실행하면 결과물이 보이고, return 됐다고 뜬다.  */
	int result = stmt.executeUpdate(query);
	
	if (result > 0) {
		out.println("정상적으로 게시물이 수정됐습니다.");
	}
	
	}
	catch (SQLException ex) {
		out.println("게시물 수정에 오류가 발생했습니다.<br>");
		out.println("SQLException : " + ex.getMessage());
	}
	finally {
		if (stmt != null) {	stmt.close(); }
		if (conn != null) { conn.close(); }
		
		/* 수정 완료 했으니까 원래대로 돌아가기 */
		response.setHeader("Refresh", "3;URL=lists.jsp");
	}
%>