<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oráculo</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/index.png">
</head>
<body>
	<c:set var="tituloPagina" value="Bem-vindo ao Evento Fatec ZL!" scope="request"/>
	<jsp:include page="header.jsp" />
	
	<div class="splash-screen">
	    <div class="splash-content">
	        <h1>Oráculo do Futebol</h1>
	        <p class="lead">Descubra uma curiosidade sobre seu time do coração e veja o futuro que a Fatec ZL reserva para você!</p>
	        <a href="${pageContext.request.contextPath}/escolha" class="btn btn-primary btn-lg mt-3">Começar!</a>
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>