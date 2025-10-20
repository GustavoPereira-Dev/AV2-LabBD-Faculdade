<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<c:set var="tituloPagina" value="Admin - Curiosidade" scope="request"/>
	<c:set var="imagem" value="curiosity.png" scope="request"/>
	<jsp:include page="header.jsp" />
<body>
	<div class="container main-container">
	    <h2 class="mb-4">Gerenciamento das mensagens</h2>
	
	    <div class="row">
	        <div class="col-md-4">
	            <div class="card">
	                <div class="card-header">
	                    <h4><c:choose><c:when test="${not empty mensagem}">Editar</c:when><c:otherwise>Cadastrar Nova</c:otherwise></c:choose> Mensagem</h4>
	                </div>
	                <div class="card-body">
	                    <form action="${pageContext.request.contextPath}/cadastraTipo" method="post">
	                        <input type="hidden" name="id" value="${mensagem.id}">
	                        <div class="mb-3">
	                            <label for="conteudo" class="form-label">Curiosidade</label>
	                            <textarea class="form-control" id="conteudo" name="conteudo" rows="5" required>${mensagem.texto}</textarea>
								<label for="time" class="form-label">Mensagem</label>
		                       	<select class="form-select" id="time" name="timeId" required>
		                          	<option selected disabled value="">Selecione um time...</option>
		                                <c:forEach var="time" items="${times}">
		                                    <option value="${time.codigo}">${time.nome}</option>
		                                </c:forEach>
		                     	</select>

	                        </div>
	                        <input type="submit" id="button" name="button" value="Salvar" class="btn btn-primary"/>
	                    </form>
	                </div>
	            </div>
	            <div class="conteiner" align="center">
					<c:if test="${not empty saida}">
						<h2 style="color: blue;"><c:out value="${saida}" /></h2>
					</c:if>
				</div>
				<div class="conteiner" align="center">
					<c:if test="${not empty erro}">
						<h2 style="color: red;"><c:out value="${erro}" /></h2>
					</c:if>
				</div>
	        </div>
	
	        <div class="col-md-8">
	        	<form action="${pageContext.request.contextPath}/cadastraTipo" method="post">
	        		<div class="mb-3">
						<label for="time" class="form-label">Filtragem</label>
			         	<select class="form-select" id="time" name="timeId" required>
			          		<option selected disabled value="">Selecione um time...</option>
			          		<c:forEach var="time" items="${times}">
			                   	<option value="${time.codigo}">${time.nome}</option>
			                 </c:forEach>
			        	</select>			
			       </div>
			       <input type="submit" id="button" name="button" value="Filtrar" class="btn btn-primary"/>	
	        	</form>
	            <h4>Mensagens Cadastradas</h4>
	            <table class="table table-striped table-hover">
	                <thead>
	                    <tr>
	                        <th>ID</th>
	                        <th>Time</th>
	                        <th>Conteúdo</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="msg" items="${listaMensagens}">
	                        <tr>
	                            <td>${msg.codigo}</td>
	                            <td>${msg.time.nome}</td>
	                            <td>${msg.conteudo}</td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	        </div>
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>