<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<tags:pageTemplate titulo="Cadastro de Usuário">
	
	<jsp:attribute name="extraScripts">
    	
	</jsp:attribute>
	
	<jsp:body>	
		<section id="index-section" class="container middle">		
		
		<c:if test="${usuario.email != null }">
			
			<c:set var="nameButton" scope="session" value="Alterar"/>
			<c:set var="nameH1" scope="session" value="Alterar dados do usuário"/>
			<c:set var="changePassword" scope="session" value="Alterar senha"/>
			<c:set var="nameMethod" scope="session" value="${s:mvcUrl('UC#atualizar').arg(0, usuario).build()}"/>				
		</c:if>
		
		<c:if test="${usuario.email == null }">
			<c:set var="nameButton" scope="session" value="Cadastrar"/>
			<c:set var="nameH1" scope="session" value="Cadastrar novo usuário"/>
			<c:set var="changePassword" scope="session" value="Senha"/>
			<c:set var="nameMethod" scope="session" value="${s:mvcUrl('UC#gravar').build()}"/>	
		</c:if>
			
		<div class="container">
			<h1>${nameH1 }</h1>
			${mensagem }
		    <form:form action="${nameMethod}" 
		    	method="POST" enctype="multipart/form-data" commandName="usuario">
		       
		        <div class="form-group">
		            <label>Nome</label>
		            <form:input path="nome" value="${usuario.nome }" cssClass="form-control"/>
		            <form:errors path="nome" />
		        </div>
		        
		        <div class="form-group">
		            <label>E-mail</label>
		            <form:input path="email"  value="${usuario.email}" cssClass="form-control"/>
		            <form:errors path="email" />
		        </div>
		        
		        <div class="form-group">
		            <label>${changePassword}</label>
		            <form:password path="senha" value="${usuario.senha }" cssClass="form-control"/>
		            <form:errors path="senha" />
		        </div>
				
				<div class="form-group">
		            <label>Permissões</label>		
		        </div>

		        <form:button type="submit">${nameButton}</form:button>
		    </form:form>
	    </div>
		</section>
	</jsp:body>
</tags:pageTemplate>
	    