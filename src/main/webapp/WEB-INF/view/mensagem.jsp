<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Define o título que será usado no header.jsp --%>
<c:set var="tituloPagina" value="Sua Mensagem Especial" scope="request"/>
<jsp:include page="header.jsp" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
    }
    .main-container { /* Adicionando um padding ao container principal como nas outras páginas */
        padding-top: 3rem;
        padding-bottom: 3rem;
    }
    .document-container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #ffffff;
        border: 1px solid #dee2e6;
        box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1);
        padding: 40px 50px;
    }
    .document-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid #000;
        padding-bottom: 20px;
        margin-bottom: 30px;
    }
    .document-header img {
        max-height: 70px;
    }
    .document-header h2 {
        font-family: 'Merriweather', serif;
        font-weight: 700;
        margin: 0;
    }
    .document-body .lead {
        font-family: 'Roboto', sans-serif;
        font-size: 1.1rem;
        margin-bottom: 25px;
    }
    .message-box {
        border-left: 4px solid #0d6efd;
        padding: 20px;
        background-color: #f8f9fa;
        font-family: 'Merriweather', serif;
        font-size: 1.25rem;
        margin: 30px 0;
    }
    .document-footer {
        text-align: center;
        margin-top: 40px;
        font-style: italic;
        color: #6c757d;
    }
    .no-print {
        text-align: center;
        margin-top: 2rem;
        margin-bottom: 2rem;
    }
    @media print {
        body {
            background-color: #ffffff;
        }
        .no-print, footer /* Esconde também o footer padrão na impressão, se houver */ {
            display: none !important;
        }
        .document-container {
            box-shadow: none;
            border: none;
            margin: 0;
            max-width: 100%;
        }
    }
</style>

<div class="container main-container">
    <div class="document-container" id="printable-area">
        <header class="document-header">
            <h2>Oráculo Fatec ZL</h2>
            <img src="${pageContext.request.contextPath}/images/fatec-zl-logo.png" alt="Logo Fatec ZL">
        </header>

        <main class="document-body">
            <h4 class="mb-3">Prezado(a) ${candidato.nome},</h4>
            <p class="lead">
                Obrigado por participar do nosso evento! Como prometido, o oráculo do seu time, o <strong>${mensagem.time.nome}</strong>, revelou uma notícia especial sobre o seu potencial e futuro.
            </p>
            <div class="message-box">
                <p>${mensagem.texto}</p>
            </div>
            <p>
                Guarde esta mensagem como um lembrete do seu potencial. A Fatec Zona Leste está de portas abertas para ajudá-lo(a) a transformar essa inspiração em uma carreira de sucesso.
            </p>
        </main>
        
        <footer class="document-footer">
            <p>Evento de Portas Abertas | Fatec Zona Leste</p>
        </footer>
    </div>
    
    <div class="no-print">
        <button class="btn btn-primary" onclick="window.print();">
            Imprimir Mensagem
        </button>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
            Voltar ao Início
        </a>
    </div>
</div>

<jsp:include page="footer.jsp" />