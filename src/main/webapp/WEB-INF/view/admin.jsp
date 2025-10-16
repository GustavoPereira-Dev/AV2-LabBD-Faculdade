<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="tituloPagina" value="Painel Administrativo" scope="request"/>
	<jsp:include page="header.jsp" />
	
	<div class="container main-container">
	    <div class="d-flex justify-content-between align-items-center mb-4">
	        <h2 class="mb-0">Painel Administrativo</h2>
	        <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-outline-danger">Sair</a>
	    </div>
	
	    <p class="lead">Bem-vindo, Administrador. Selecione uma das opções abaixo para começar.</p>
	    <hr>
	
	    <div class="row mt-4 g-4">
	        
	        <div class="col-md-6">
	            <div class="card h-100 text-center">
	                <div class="card-body d-flex flex-column align-items-center justify-content-center p-4">
	                    <%-- Sugestão: Usar uma biblioteca de ícones como Bootstrap Icons --%>
	                    <i class="bi bi-chat-left-text-fill" style="font-size: 3rem; color: #0d6efd;"></i>
	                    <h5 class="card-title mt-3">Gerenciar Mensagens</h5>
	                    <p class="card-text">
	                        Cadastre, consulte e modifique as curiosidades sobre os times que são exibidas para os candidatos.
	                    </p>
	                    <a href="${pageContext.request.contextPath}/admin/mensagens" class="btn btn-primary mt-auto">Acessar</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col-md-6">
	            <div class="card h-100 text-center">
	                <div class="card-body d-flex flex-column align-items-center justify-content-center p-4">
	                     <%-- Ícone de exemplo do Bootstrap Icons --%>
	                    <i class="bi bi-people-fill" style="font-size: 3rem; color: #198754;"></i>
	                    <h5 class="card-title mt-3">Consultar Candidatos</h5>
	                    <p class="card-text">
	                        Filtre e visualize a lista de potenciais alunos que se cadastraram durante o evento.
	                    </p>
	                    <a href="${pageContext.request.contextPath}/admin/consultarCandidatos" class="btn btn-success mt-auto">Acessar</a>
	                </div>
	            </div>
	        </div>
	
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>