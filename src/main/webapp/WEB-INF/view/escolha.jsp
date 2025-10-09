<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<c:set var="tituloPagina" value="Escolha seu Time" scope="request"/>
	<jsp:include page="header.jsp" />
		
	<div class="container main-container text-center">
	    <h2 class="mb-4">Para qual time você torce?</h2>
	    <p class="lead mb-5">Clique no seu time para receber uma mensagem especial!</p>
		    
	    <div class="row justify-content-center">
		        
	        <div class="col-lg-3 col-md-6 mb-4">
	            <a href="${pageContext.request.contextPath}/curiosidade?timeId=1" class="text-decoration-none">
	                <div class="card h-100 team-card">
	                    <img src="${pageContext.request.contextPath}/images/corinthians.png" class="card-img-top" alt="Logo Corinthians">
	                    <div class="card-body d-flex flex-column justify-content-center">
	                        <h5 class="card-title">Corinthians</h5>
	                    </div>
	                </div>
	            </a>
	        </div>
	
	        <div class="col-lg-3 col-md-6 mb-4">
	            <a href="${pageContext.request.contextPath}/curiosidade?timeId=2" class="text-decoration-none">
	                <div class="card h-100 team-card">
	                    <img src="${pageContext.request.contextPath}/images/palmeiras.png" class="card-img-top" alt="Logo Palmeiras">
	                    <div class="card-body d-flex flex-column justify-content-center">
	                        <h5 class="card-title">Palmeiras</h5>
	                    </div>
	                </div>
	            </a>
	        </div>
	
	        <div class="col-lg-3 col-md-6 mb-4">
	            <a href="${pageContext.request.contextPath}/curiosidade?timeId=3" class="text-decoration-none">
	                <div class="card h-100 team-card">
	                    <img src="${pageContext.request.contextPath}/images/santos.png" class="card-img-top" alt="Logo Santos">
	                    <div class="card-body d-flex flex-column justify-content-center">
	                        <h5 class="card-title">Santos</h5>
	                    </div>
	                </div>
	            </a>
	        </div>
	
	        <div class="col-lg-3 col-md-6 mb-4">
	            <a href="${pageContext.request.contextPath}/curiosidade?timeId=4" class="text-decoration-none">
	                <div class="card h-100 team-card">
	                    <img src="${pageContext.request.contextPath}/images/sao_paulo.png" class="card-img-top" alt="Logo São Paulo">
	                    <div class="card-body d-flex flex-column justify-content-center">
	                        <h5 class="card-title">São Paulo</h5>
	                    </div>
	                </div>
	            </a>
	        </div>
	
	    </div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>