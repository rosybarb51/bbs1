<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 글 확인</title>
<style>
/* css 부분 */
	table {
		width: 100%
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	td, th {
		border: 1px solid black;
	}
	
	.container {
		width : 960px;
		/* 전체화면에서 중앙정렬하려면 마진값 오토로 주면됨 */
		margin : 0px auto;
		
	}
	
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	/* request : 클라이언트가 요청하는 모든 것 */
	/* cf) respose : 서버가 클라이언트에 넘겨주는 모든 것 */
	/* 아래의 num은 lists.jsp에서 전송한 num의 데이터를 불러옴 */
	String number = request.getParameter("num");
	/* request로 넘겨줄 땐 기본적으로 문자열로 넘겨주는데, db는 숫자이므로 변경해줘야한다. */
	/* 문자로 표현된 숫자가 실제 정수형으로 바꿔주기 */
	int num = Integer.parseInt(number);
	/* 주소창에 localhost:8080/bbs1/select.jsp?num=글번호 입력하면 실행됨 */
	 %>
	<%@ include file="dbConn.jsp" %>
	<!-- select 문을 사용하여 지정한 1개의 글 내용을 가져오기 -->
	<%
	ResultSet rs = null;
	/* 쿼리문을 날리기 위한 statement 객체  */
	Statement stmt = null;
	/* Statement 대신 PreparedStatement 가 사용하기 더 쉽다..... */
	/* PreparedStatement psmt = null; */
	
	try {
		/* lists.jsp에서 데이터 다 들고 오면 그 데이터는 다 삭제되므로, 여기서 또 다시 db에서 데이터를 들고 와야해서 쿼리문을 사용해서 데이터를 들고 온다. */
		/* 쿼리문 작성 시 중요한 포인트 끝에 공백을 무조건 남겨줘야 함. 일반적인 문자열 사용하듯이 공백없이 빽빽하게 하면 안 돌아간다.  */
		String query = "SELECT title, comments, writer, cdate, ";
		query += "views, likes ";
		query += "FROM bbs ";
		/* where 쓰는 이유 : 내가 원하는 글 번호 하나만 가져오기 위해서 */
		query += "WHERE num = " + num;
		
		/* 쿼리문을 날리기 위한 statement 객체 사용 */
		stmt = conn.createStatement();
		/* select 를 사용했으니까 resultSet에 저장 */
		rs = stmt.executeQuery(query);
		
		/* while문 실행 안 할 땐 while 문 안에 있던 이 친구 실행해줘야한다. 변수 가져와야하니까 */
		/* 데이터를 꺼내오려면 next() 함수를 사용해야함 */
		rs.next();
		
			/* 한 개만 있는 거니까 바로 화면에 출력해도 됨 */
			/* request.getParameter()랑 비슷하다고 보면 된다. rs.getString() */
			String title = rs.getString("title");
			String comments = rs.getString("comments");
			String writer = rs.getString("writer");
			String cdate = rs.getString("cdate");
			String views = rs.getString("views");
			String likes = rs.getString("likes");
			
			/* 이건 어차피 한 개만 들고 오니까 동일한 값이 있을 수 없어서 while문 안 써도 되는데 while문 사용해도 상관은 없다.  */
			
	/* 	while (rs.next()) {
			String title = rs.getString("title");
			String comments = rs.getString("comments");
			String writer = rs.getString("writer");
			String cdate = rs.getString("cdate");
			String views = rs.getString("views");
			String likes = rs.getString("likes"); */
			/* out.println(title + "<br>");
			out.println(comments + "<br>");
			out.println(writer + "<br>");
			out.println(cdate + "<br>");
			out.println(views + "<br>");
			out.println(likes + "<br>");
		}  */
		%>
		
		<div class="container">
			<table>
				<thead>
					<tr>
						<!-- 제목은 한 줄 다 사용해야하니까 colspan=3 -->
						<!-- 콜스팬은 칸을 합치는 것, 현재 표가 3x3 이라서 세 칸을 하나로 합침 -->
						<!-- 로스팬은 줄을 합치는 것 -->
						<th colspan=3><%= rs.getString("title") %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%= writer %></td>
						<td><%= views %></td>
						<td><%= likes %></td>
					</tr>
					<tr>
						<td colspan=3><%= comments %></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<a href="./lists.jsp">목록으로</a>
		<!-- 수정하기 누르면 modify.jsp로 넘겨준다 -->
		<a href="./modify.jsp?num=<%= num %>">수정하기</a>
		<a href="./delete.jsp?num=<%= num %>">삭제하기</a>
		<%
	}
	
	catch (SQLException ex) {
		out.println("글 조회를 실패했습니다.<br>");
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