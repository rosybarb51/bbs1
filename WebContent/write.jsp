<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>a 태그의 write.jsp</title>
</head>
<body>
<!-- get은 웹브라우저의 주소창에 적어서 전송, post는 암호화해서 전송. 그래서 중요한 정보는 무조건 post로 전송할 것 -->
	<form action="insert.jsp" method="post">
		<label for="title">제목 : </label>
		<input type="text" id="title" name="title" placeholder="제목을 입력하세요"><br>
		<label for="writer">작성자 : </label>
		<input type="text" id="writer" name="writer" placeholder="작성자를 입력하세요"><br>
		<label for="comment">글내용 : </label>
		<textarea rows="5" cols="80" id="comment" name="comment"></textarea><br><br>
		
		<button type="submit">확인</button>
		<button type="reset">취소</button>
	</form>
</body>
</html>