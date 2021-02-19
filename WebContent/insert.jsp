<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 디렉티브 태그 사용할거니까 추가 -->
<%@ page import="java.sql.*" %>

<!-- ui 부분 필요 없어서 삭제 -->

<%@ include file="dbConn.jsp" %>

<!-- 나머지 실행 부분 -->
<%
request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");
String writer = request.getParameter("writer");
/* 이 부분은 아직 쿼리 부분이 아니라 jsp 부분이라서 우리가 write.jsp에서 textarea의 name 속성값(전송된 파라미터의 이름으로 들어옴)을 comment로 해놨기 때문에 아래의 부분에서 comment 그대로 적어줘야한다. 우리가 워크밴치에서 comments라고 저장했어도 그것과 무관한 부분이다. */
String comment = request.getParameter("comment");

Statement stmt = null;

/* 아래의 실제 쿼리 부분은 데이터베이스와 컬럼명을 똑같이 맞춰줘야한다.
그리고 쿼리부분은 워크밴치가서 실제로 동작시켜보고, 실행되는 것을 가져와서 작성할 것 */
try {
	String query = "INSERT INTO bbs ";
	query += "(title, comments, writer, cdate) ";
	query += "VALUES ('" + title + "', '" + comment + "', ' ";
	query +=  writer + "', now())";
	
	stmt = conn.createStatement(); // select 할 때만 사용
	int result = stmt.executeUpdate(query); // 나머지는 executeUpdate
	
	out.println("게시물을 등록했습니다.");
}
catch (SQLException ex) {
	out.println("게시물을 등록하는 데 실패했습니다.<br>");
	out.println("SQLException : " + ex.getMessage());
}
finally {
	if (stmt != null) {
		stmt.close();
		}
	
	if (conn != null) {
		conn.close();
		}
		
	/* 지정한 시간 이후에 페이지 이동 -->
	리플래쉬 적어주고, 초, url 적어주면 된다.
	파이널리에 적어준 이유는 성공해도 실패해도 첫 화면으로 넘어가야하니까. */
	response.setHeader("Refresh", "3;URL=lists.jsp");
} 
%>



