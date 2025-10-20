<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%-- A URL de redirecionamento pode ser passada pelo controller --%>
<c:set var="redirectUrl" value="autenticacao" />
<c:set var="tituloPagina" value="Sua Curiosidade!" scope="request"/>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sua Curiosidade!</title>
    <meta http-equiv="refresh" content="15;url=${redirectUrl}">
    <link rel="icon" href="${pageContext.request.contextPath}/images/curiosity.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<div class="container curiosity-container text-center">
    <div class="card text-center w-75">
        <div class="card-header">
            <h3>Oráculo do ${timeNome}</h3>
        </div>
        <div class="card-body">
            <blockquote class="blockquote mb-0">
                <p class="fs-4">"${conteudoCuriosidade}"</p>
                <footer class="blockquote-footer mt-3">Uma inspiração para o seu futuro!</footer>
            </blockquote>
        </div>
        <div class="card-footer text-muted">
            Você será redirecionado para a página de cadastro em 15 segundos...
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>