<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<tags:pageTemplate titulo="Livros de Java, SOA, Android, iPhone, Ruby on Rails e muito mais">
	
	<jsp:attribute name="extraScripts">
    	<script> Todo o script. </script>
	</jsp:attribute>
	
	
	<jsp:body>
		
		<div class="container">
		
		
			<h1><s:message code="list.titleH1" /></h1>		
			<div>${mensagem}</div>
		 	<table class="table table-bordered table-striped table-hover" >
		        <tr>
		            <th><s:message code="list.title" /></th>
		            <th><s:message code="list.description" /></th>
		            <th><s:message code="list.typePrices" /></th>
		            <th><s:message code="list.pages" /></th>
		        </tr>
		
		        <c:forEach items="${produtos}" var="produto">
		            <tr id="${produto.id}">
		                <td><a href="${s:mvcUrl('PC#detalhe').arg(0, produto.id).build()}">${produto.titulo}</a></td>
		                <td>${produto.descricao}</td>
		                <td>${produto.precos}</td>
		                <td>${produto.paginas}</td>
		            </tr>
		        </c:forEach>
		
		    </table>
	    </div>
	</jsp:body>
</tags:pageTemplate>