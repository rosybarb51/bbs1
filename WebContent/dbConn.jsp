<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- java의 sql 관련 라이브러리를 사용하기 위해서 import -->
<%@ page import="java.sql.*" %>

<%
/* 통신부분에서도 사용하고, 밑에 드라이버메니저할 때 사용함 */
Connection conn = null;

try {
	/* jdbc(자바데이터베이스커넥터)를 이용해서 mysql에 접속하여 bbs1이라는 db를 사용한다는 의미  */
	/* 아래에 주소를 localhost로 해놔서 자기 컴퓨터만 접속 가능하게 해놓음, 만약에 아이피나 도메인 주소를 넣으면 그 쪽 데이터 베이스에 들어가진다. */
	/* 접속은 포트 3306 채널로 들어갈 수 있다. 회선은 하나 들어가도 채널은 여러 개 볼 수 있는 것처럼, 인터넷 연결은 하나지만 포트를 여러 개 사용하여 여러 가지 채널을 사용할 수 있다. mysql의 기본 포트는 3306이다  */
	/* bbs1 : 데이터베이스 이름을 적어준것임, 워크벤치의 왼쪽에 스키마명을 그대로 적어줘야한다. 안 그러면 오류난다. */
	/* ? 이후는 전부 다 옵션부분이다, 예전에는 이 부분 설정 안해도 됐었다. 이 설정이 어디있냐면, C:\ProgramData\MySQL\MySQL Server 8.0 - my.ini 열어서 포트번호를 3306 말고 다른 걸로 바꿔줄 수 있다. 보안을 위해서 안에서 두 개 바꿔줘야함.  */
	/* serverTimezone이랑 UTF-8 부분은 필수로 적어줘야한다... 업데이트 되면서 안 써주면 오류난다. */
	String url = "jdbc:mysql://localhost:3306/bbs1?serverTimezone=UTC&characterEncoding=UTF-8";
	/* 사용자 id/pw */
	String userId = "springb";
	String userPw = "asdf1234";
	
	/* jdbc 드라이버 이름 */
	/* 예전 버전과 다르게 cj 를 중간에 넣어줘야함.  */
	Class.forName("com.mysql.cj.jdbc.Driver");
	/* DriverManager 를 통해서 실제 데이터베이스와 연결 */
	/* 우리가 드라이버메니저라는 객체를 만든적이 없다, 싱글톤 방식으로 돌아감, 프로그램 실행시 클래스와 동시에 메모리에 등록이 돼서 static 처럼 사용할 수 있다. 정적멤버라서 클래스와 바로 이름 쓰면 된다, url이 위에 적은 주소, 사용자 아이디, 비밀번호 적어주고  */
	conn = DriverManager.getConnection(url, userId, userPw);
	/* 아래는 처음에 되는지 테스트용으로 사용함, 계속 사용할 때는 자꾸 뜨면 보기 안 좋아서 주석 처리함 */
	/* out.println("데이터 베이스에 연결이 성공하였습니다."); */
}
catch (SQLException ex) {
	out.println("데이터 베이스 연결이 실패하였습니다.<br>");
	out.println("SQLException : " + ex.getMessage());
}
%>





