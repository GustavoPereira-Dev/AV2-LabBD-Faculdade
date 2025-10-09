<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="tituloPagina" value="Cadastre-se" scope="request"/>
	<jsp:include page="header.jsp" />
	
	<div class="container">
		<div class="container main-container">
		    <div class="row justify-content-center">
		        <div class="col-md-8">
		            <div class="card">
		                <div class="card-header text-center">
		                    <h3>Garanta seu Futuro na Fatec ZL!</h3>
		                </div>
		                <div class="card-body p-4">
		                    <p class="text-muted">Preencha seus dados para receber informações sobre nossos vestibulares e eventos.</p>
		                    <form action="${pageContext.request.contextPath}/salvarCandidato" method="post">
		                        <div class="mb-3">
		                            <label for="nome" class="form-label">Nome Completo</label>
		                            <input type="text" class="form-control" id="nome" name="nome" required>
		                        </div>
		                        <div class="mb-3">
		                            <label for="email" class="form-label">E-mail</label>
		                            <input type="email" class="form-control" id="email" name="email" required>
		                        </div>
		                        <div class="mb-3">
		                            <label for="telefone" class="form-label">Telefone Celular</label>
		                            <input type="tel" class="form-control" id="telefone" name="telefone" required>
		                        </div>
		                         <div class="mb-3">
		                            <label for="bairro" class="form-label">Bairro onde reside</label>
		                            <input type="text" class="form-control" id="bairro" name="bairro" required>
		                        </div>
		                        <div class="mb-3">
		                            <label for="curso" class="form-label">Curso de Interesse</label>
		                            <select class="form-select" id="curso" name="cursoId" required>
		                                <option selected disabled value="">Selecione um curso...</option>
		                                <c:forEach var="curso" items="${cursos}">
		                                    <option value="${curso.id}">${curso.nome} - ${curso.turno}</option>
		                                </c:forEach>
		                            </select>
		                        </div>
		                        <div class="form-check mb-4">
		                            <input class="form-check-input" type="checkbox" id="consentimento" checked disabled>
		                            <label class="form-check-label" for="consentimento">
		                                Ao me cadastrar, concordo em receber mensagens da Fatec ZL sobre o vestibular.
		                            </label>
		                        </div>
		                        <div class="d-grid">
		                           <button type="submit" class="btn btn-primary btn-lg">Cadastrar</button>
		                        </div>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		<div class="login-container">
	        <h3 class="text-center mb-4">Login</h3>
	        
	        <c:if test="${not empty param.error}">
	            <div class="alert alert-danger" role="alert">
	                Login ou senha inválidos.
	            </div>
	        </c:if>
	
	        <form action="${pageContext.request.contextPath}/admin/autenticar" method="post">
	            <input type="hidden" name="target" value="${param.target}">
	            
	            <div class="mb-3">
	                <label for="login" class="form-label">Usuário</label>
	                <input type="text" class="form-control" id="login" name="login" required>
	            </div>
	            <div class="mb-3">
	                <label for="senha" class="form-label">Senha</label>
	                <input type="password" class="form-control" id="senha" name="senha" required>
	            </div>
	            <div class="d-grid mt-4">
	                <button type="submit" class="btn btn-dark">Entrar</button>
	            </div>
	        </form>
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>