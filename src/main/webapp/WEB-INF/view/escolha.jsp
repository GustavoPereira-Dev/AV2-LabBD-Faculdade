<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<c:set var="tituloPagina" value="Escolha seu Time" scope="request"/>
	<c:set var="imagem" value="choice.png" scope="request"/>
	<jsp:include page="header.jsp" />
<body>
	<div class="container main-container text-center">
	    <h2 class="mb-4">Para qual time você torce?</h2>
	    <p class="lead mb-5">Clique no seu time para receber uma mensagem especial!</p>
		    
	    <div class="row justify-content-center">
		        
			<c:forEach var="time" items="${times}">
			            <div class="col-lg-3 col-md-6 mb-4">
			                <a href="${pageContext.request.contextPath}/curiosidade?timeId=${time.codigo}" class="text-decoration-none">
			                    <div class="card h-100 team-card">
			                        <img src="${pageContext.request.contextPath}/images/${time.nome}.png" class="card-img-top" alt="Logo ${time.nome}">
			                        <div class="card-body">
			                            <h5 class="card-title">${time.nome}</h5>
			                        </div>
			                    </div>
			                </a>
			            </div>
			        </c:forEach>
	
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>