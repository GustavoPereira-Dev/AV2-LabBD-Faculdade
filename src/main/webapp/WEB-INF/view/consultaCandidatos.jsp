<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<c:set var="tituloPagina" value="Admin - Consulta de Candidatos" scope="request"/>
	<c:set var="imagem" value="candidate.jpg" scope="request"/>
	<jsp:include page="header.jsp" />
<body>
	<c:set var="tituloPagina" value="Admin - Consulta de Candidatos" scope="request"/>
	<jsp:include page="header.jsp" />
	
	<div class="container main-container">
	    <h2 class="mb-4">Consulta de Candidatos</h2>
	
	    <div class="card mb-4">
	        <div class="card-header">
	            Filtros de Consulta
	        </div>
	        <div class="card-body">
	            <div class="row g-3">
	                <form class="col-md-6" action="${pageContext.request.contextPath}/consultaCandidatos" method="get">
	                    <input type="hidden" name="tipo" value="curso">
	                    <label for="curso" class="form-label">Por Curso</label>
	                    <div class="input-group">
	                        <select class="form-select" id="curso" name="filtro">
	                            <c:forEach var="curso" items="${cursos}"><option value="${curso.codigo}">${curso.nome}</option></c:forEach>
	                        </select>
	                        <button class="btn btn-outline-secondary" type="submit">Buscar</button>
	                    </div>
	                </form>
	                <form class="col-md-6" action="${pageContext.request.contextPath}/consultaCandidatos" method="get">
	                     <input type="hidden" name="tipo" value="bairro">
	                     <label for="bairro" class="form-label">Por Bairro</label>
	                    <div class="input-group">
	                        <input type="text" class="form-control" placeholder="Digite o bairro" name="filtro">
	                        <button class="btn btn-outline-secondary" type="submit">Buscar</button>
	                    </div>
	                </form>
	            </div>
	            <hr>
	            <div class="d-flex flex-wrap gap-2">
	                 <a href="${pageContext.request.contextPath}/consultaCandidatos?tipo=todosPorCurso" class="btn btn-info">Listar Todos (por Curso)</a>
	                 <a href="${pageContext.request.contextPath}/consultaCandidatos?tipo=todosPorBairro" class="btn btn-info">Listar Todos (por Bairro)</a>
	                 <a href="${pageContext.request.contextPath}/consultaCandidatos?tipo=primeiros10" class="btn btn-success">10 Primeiros Cadastrados</a>
	                 <a href="${pageContext.request.contextPath}/consultaCandidatos?tipo=ultimos10" class="btn btn-success">10 Últimos Cadastrados</a>
	            </div>
	        </div>
	    </div>
	    
	    <h4>Resultados da Consulta: <small class="text-muted">${tituloResultado}</small></h4>
	    <div class="table-responsive">
	        <table class="table table-bordered table-striped">
	            <thead>
	                <tr>
	                    <th>Nome</th>
	                    <th>E-mail</th>
	                    <th>Telefone</th>
	                    <th>Bairro</th>
	                    <th>Curso de Interesse</th>
	                    <th>Data/Hora Cadastro</th>
	                    <th>Concordância Mensagens</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:forEach var="candidato" items="${candidatos}">
	                    <tr>
	                        <td>${candidato.nome}</td>
	                        <td>${candidato.email}</td>
	                        <td>${candidato.telefone}</td>
	                        <td>${candidato.bairro}</td>
	                        <td>${candidato.curso.nome}</td>
	                        <td>${candidato.dataCadastro}</td>
	                         <c:if test="${candidato.recebeMensagem}">
	                         	<td>Sim</td>
	                         </c:if>
	                         <c:if test="${!candidato.recebeMensagem}">
	                         	<td>Nao</td>
	                         </c:if>
	                    </tr>
	                </c:forEach>
	                <c:if test="${empty candidatos}">
	                    <tr>
	                        <td colspan="6" class="text-center">Nenhum candidato encontrado para esta consulta.</td>
	                    </tr>
	                </c:if>
	            </tbody>
	        </table>
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>