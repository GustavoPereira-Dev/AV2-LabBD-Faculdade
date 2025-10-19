<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="tituloPagina" value="Meu Painel" scope="request"/>
<jsp:include page="header.jsp" />

<div class="container main-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Meu Painel de Candidato</h2>
        <a href="${pageContext.request.contextPath}/candidato/logout" class="btn btn-outline-danger">
            Sair <i class="bi bi-box-arrow-right"></i>
        </a>
    </div>

    <h4 class="fw-light">Bem-vindo(a) de volta, ${candidato.nome}!</h4>
    <p class="lead text-muted">Aqui estão as informações do seu cadastro em nosso evento.</p>
    
    <hr class="my-4">

    <div class="row g-4">
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-header">
                    <i class="bi bi-person-fill"></i> Seus Dados Pessoais
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <strong>E-mail:</strong> ${candidato.email}
                        </li>
                        <li class="list-group-item">
                            <strong>Telefone:</strong> ${candidato.telefone}
                        </li>
                        <li class="list-group-item">
                            <strong>Bairro:</strong> ${candidato.bairro}
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-header">
                    <i class="bi bi-calendar-event-fill"></i> Seu Interesse
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <strong>Curso de Interesse:</strong> ${candidato.curso.nome}
                        </li>
						<li class="list-group-item">
						    <strong>Cadastrado desde:</strong> 
						    ${candidato.getDataCadastroFormatada()}
						</li>
                        <li class="list-group-item">
                            <strong>Receber Mensagens:</strong> 
                            <c:if test="${candidato.recebeMensagem}">
                                <span class="badge bg-success">Sim</span>
                            </c:if>
                            <c:if test="${not candidato.recebeMensagem}">
                                <span class="badge bg-danger">Não</span>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <c:if test="${not empty ultimaCuriosidade}">
            <div class="col-12">
                <div class="card text-center">
                    <div class="card-header">
                        <i class="bi bi-star-fill"></i> Sua Mensagem do Oráculo
                    </div>
                    <div class="card-body">
                        <blockquote class="blockquote mb-0">
                            <p class="fs-5">"${ultimaCuriosidade}"</p>
                            <footer class="blockquote-footer mt-2">Uma lembrança do nosso evento!</footer>
                        </blockquote>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="footer.jsp" />