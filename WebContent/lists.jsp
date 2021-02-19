<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 게시판의 전체 리스트 불러오기 -->
    
<!-- jsp 페이지에서 자바 클래스를 사용하기 위해서 import -->
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 전체 목록</title>
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
	
	td > a {
		text-decoration : none;
	}
	
	.container {
		width : 960px;
		/* 전체화면에서 중앙정렬하려면 마진값 오토로 주면됨 */
		margin : 0px auto;
		
	}
	
</style>
</head>
<body>
<!-- jsp는 디렉티브 태그와 액션태그가 있다. 둘 다 include가 있는데 형식이 다르다, 디렉티브 태그는 현재 기준이 되는 파일 안에 불러와서 붙여넣기해서 사용, 액션태그는 해당 파일에 가서 실행하고 다시 돌아오는 것임. 이 두가지만 기억하자. -->
<!-- 기존에 만들어진 파일을 불러와서 해당파일의 내용을 실행한다. -->
	<%@ include file="dbConn.jsp" %>
	<div class="container">
		<table>
			<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>글쓴이</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>
			<tbody>
				<%
				/* ResultSet : SQL 쿼리(SELECT문) 실행 후 그 결과값을 받아오는 데이터 타입 -> SELECT문을 사용하면 무조건 ResultSet 객체에 저장한다고 생각하면 된다. SELECT는 INSERT, UPDATE, DELETE(int 타입으로 저장)와 다르게 데이터를 return 만 할 뿐 저장을 안 하기 때문에 실행 결과를 리절트셋에 저장해줘야 한다. */
				ResultSet rs = null;
				/* 실제 SQL 쿼리를 실행하기 위해서 사용 */
				Statement smt = null;
				
				try {
					String query = "SELECT * FROM bbs ";
					
					/* 스테이트먼트 사용할때는 크리에이트스테이트먼트해서 사용해야한다. */
					smt = conn.createStatement();
					/* select문 실행 시 executeQuery() 사용 */
					/* insert, update, delete문 실행 시 executeUpdate() 사용 */
					/* 셀렉트문을 익스큐트쿼리 사용해서 결과를 아까위에서 말한대로 리절트셋인 rs에 넣어준다. */
					/* 리절트셋에 넣어주면 일종의 2차원 배열로 만들어진다. */
					rs = smt.executeQuery(query);
					
					while (rs.next()) {
						/* 게시판에는 내용을 안 보여줘도 돼서 comments를 뺐다 */
						/* 한 줄씩 출력한다고 보면 됨, 위에서 true면 next해서 아래 실행해서 또 한 줄 추가, rs 즉 리절트셋에 들어가있는 값이 존재하면 참이니까 결과값이 있으면 next 아래가 실행되는 것임. */
						String num = rs.getString("num");
						String title = rs.getString("title");
						String writer = rs.getString("writer");
						String cDate = rs.getString("cDate");
						String views = rs.getString("views");
						String likes = rs.getString("likes");
						%>
						<!-- 표에 값을 넣기 위한 것이니까 아래와 같이 작성. 위에서는 값만 저장하고, 아래에 표에 그 값을 가져와서 나타내줌 -->
						<!-- 한 줄 추가니까 tr로 , td는 옆에 칸 추가 -->
						<tr>
							<td><%= num %></td>
							<!-- 아래의 a태그에 링크 걸어서 ? 값 준 것은 form 태그 사용 시 method 속성을 get으로 사용한 것과 같은 효과이다.  -->
							<!-- 아래의 num을 select.jsp로 이동 시 파라미터 이름으로 num을 사용하고 num에 데이터를 저장하여 서버로 전송 -->
							<td><a href="./select.jsp?num=<%= num %>"><%= title %></a></td>
							<td><%= writer %></td>
							<td><%= cDate %></td>
							<td><%= views %></td>
							<td><%= likes %></td>
						<!-- 한 줄 다 적고 /tr -->
						</tr>
						<% 
					} // while문 종료 -> 다시 위에 조건 rs.next 가서 결과 있는지 없는지 확인한다. 결과가 없어서 false 나오면 while문 종료 후 다음 줄 실행한다 try catch 문 도 종료됨. 그래서 그 다음인 finally 실행된다.
					/* try 문에 오류가 나면 catch가 실행된다. finally문은 try 문만 실행되든, 오류가 나서 catch 문을 실행해도 동작해야한다. finally에서 어떤 경우든지 다 닫아주는 문구를 적어준다. 안정성을 위해서 */
				}
				catch (SQLException ex) {
					out.println("bbs 테이블에서 게시글 목록 조회를 실패했습니다.<br>");
					out.println("SQLExeption : " + ex.getMessage());
				}
				finally {
					if (rs != null) {
						rs.close();
					}
					
					if (smt != null) {
						smt.close();
					}
					
					if (conn != null) {
						conn.close();
					}
				}
				%>
			</tbody>
		</table>
		<!-- 글쓰기 버튼 방식 두 가지가 있다. -->
		<!-- 1. 버튼 - 자바 스크립트 연결 2. a태그 - jsp 연결 -->
		<!-- <button id="btn_write">글쓰기</button> -->
		<a href="write.jsp">글쓰기</a>
	</div>
</body>
</html>








