<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="tituloPagina" value="Admin - Mensagens" scope="request"/>
	<jsp:include page="header.jsp" />
	
	<div class="container main-container">
	    <h2 class="mb-4">Gerenciamento das mensagens</h2>
	
	    <div class="row">
	        <div class="col-md-4">
	            <div class="card">
	                <div class="card-header">
	                    <h4><c:choose><c:when test="${not empty mensagem}">Editar</c:when><c:otherwise>Cadastrar Nova</c:otherwise></c:choose> Mensagem</h4>
	                </div>
	                <div class="card-body">
	                    <form action="${pageContext.request.contextPath}/admin/salvarMensagem" method="post">
	                        <input type="hidden" name="id" value="${mensagem.id}">
	                        <div class="mb-3">
	                            <label for="conteudo" class="form-label">Mensagem</label>
	                            <textarea class="form-control" id="conteudo" name="conteudo" rows="5" required>${mensagem.texto}</textarea>
	                        </div>
	                        <button type="submit" class="btn btn-primary">Salvar</button>
	                        <a href="${pageContext.request.contextPath}/admin/mensagens" class="btn btn-secondary">Cancelar</a>
	                    </form>
	                </div>
	            </div>
	        </div>
	
	        <div class="col-md-8">
	            <h4>Mensagens Cadastradas</h4>
	            <table class="table table-striped table-hover">
	                <thead>
	                    <tr>
	                        <th>ID</th>
	                        <th>Time</th>
	                        <th>Conteúdo</th>
	                        <th>Ações</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="msg" items="${listaMensagens}">
	                        <tr>
	                            <td>${msg.id}</td>
	                            <td>${msg.time.nome}</td>
	                            <td>${msg.texto}</td>
	                            <td>
	                                <a href="${pageContext.request.contextPath}/admin/editarMensagem?id=${msg.id}" class="btn btn-sm btn-warning">Editar</a>
	                            </td>
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