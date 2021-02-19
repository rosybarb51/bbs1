<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	/* select.jsp에서는 lists.jsp에서 넘겨온 변수 받고, 또 형변환 해줬는데 아래는 한 번에 했다. 간단. */
	int num = Integer.parseInt(request.getParameter("num"));
	%>
	
	<%@ include file="dbConn.jsp" %>
	
	<%
	ResultSet rs = null;
	Statement stmt = null;
	
	try {
		/* select.jsp에서 넘겨주면 거기의 데이터는 다 잃어버리기 때문에 이 페이지 열 때 다시 쿼리문 이용해서 db의 데이터를 가져와야한다. */
		String query = "SELECT title, comments, cdate, writer, cdate, ";
		query += "views, likes ";
		query += "FROM bbs ";
		query += "WHERE num = " + num;	
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		rs.next();
		
		%>
		<!-- select.jsp에서는 테이블 안에 데이터를 표현해줬는데 여기서는 form 안에 표현해줬다. -->
		<!-- 제목과 내용만 변경할 수 있도록 함 -->
		
		<form action="update.jsp" method="post">
			<label for="title">제목 : </label>
			<input type="text" id="title" name="title" value='<%= rs.getString("title")%>'><br>
			<label for="comments">내용 : </label>
			<textarea rows="5" cols="80" id="comments" name="comments"><%= rs.getString("comments") %></textarea><br>
			<!-- 지금 현재 이 창에서는 데이터베이스를 수정할 수 없음, 왜냐하면 db의 기본값인(우리가 설정한) pk로 설정된 num이 없어서  -->
			<!-- 그래서 아래의 hidden으로 num을 update.jsp에 넘겨준다. 아래의 name 부분이 파라미터 받는 이름 부분임 -->
			<!-- 아래의 num을 value에 바로 num으로 적어서 받아오는 것은 위에서 getParameter로 받아왔기 때문에 가져온 이름 그대로 사용하면 된다. -->
			<input type="hidden" name="num" value="<%= num %>">
			<!-- viwes 부분도 자동으로 카운트 돼서 넘겨줄 거니까 hidden으로 했다. -->
			<!-- views는 원래 select 에서 자동으로 해줘야 하는데 위치가 좀 꼬였다.. -->
			<!-- 위의 num과 다르게 rs.getString으로 받아온 이유는 num처럼 getParameter로 받아온 게 아니라 db에서 직접 가져오는 것이기 때문이다. -->
			<!-- 위와 비교해보면 쌍따옴표, 아래는 홑따옴표임 -->
			<input type="hidden" name="views" value='<%= rs.getString("views") %>'>
			<button type="submit">수정</button>
			<button type="reset">취소</button>
		</form>
		<%
	}
	catch (SQLException ex) {
		out.println("데이터를 불러오는 데 오류가 발생했습니다.<br>");
		out.println("SQLException : " + ex.getMessage());
	}
	finally {
		if (rs != null) {
			rs.close();
		}
		
		if (stmt != null) {
			stmt.close();
		}
		
		if (conn != null) {
			conn.close();
		}
	}
	
	
	
	%>
</body>
</html>