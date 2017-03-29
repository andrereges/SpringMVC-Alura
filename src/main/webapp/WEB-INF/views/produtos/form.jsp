<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<tags:pageTemplate titulo="Livros de Java, SOA, Android, iPhone, Ruby on Rails e muito mais">
	
	<jsp:attribute name="extraScripts">
    	<script> Todo o script. </script>
	</jsp:attribute>
	
	
	<jsp:body>	
				
		<div class="container">
			<h1><s:message code="register.titleH1" /></h1>
		    <form:form action="${s:mvcUrl('PC#gravar').build()}" 
		    	method="POST" enctype="multipart/form-data" commandName="produto">
		       
		        <div class="form-group">
		            <label><s:message code="register.title" /></label>
		            <form:input path="titulo" cssClass="form-control"/>
		            <form:errors path="titulo" />
		        </div>
		        
		        <div class="form-group">
		            <label><s:message code="register.description" /></label>
		            <form:textarea rows="10" cols="20" path="descricao" cssClass="form-control"/>
		            <form:errors path="descricao" />
		        </div>
		        
		        <div class="form-group">
		            <label><s:message code="register.pages" /></label> 
		            <form:input path="paginas" cssClass="form-control"/>
		            <form:errors path="paginas" />
		        </div>
		        
		        <div class="form-group">
		            <label><s:message code="register.date" /></label> 
		            <form:input path="dataLancamento" cssClass="form-control"/>
		            <form:errors path="dataLancamento" />
		        </div>
		        
		        <c:forEach items="${tipos}" var="tipoPreco" varStatus="status">
		            <div class="form-group">
		                <label>${tipoPreco}</label>
		                <form:input  path="precos[${status.index}].valor" cssClass="form-control"/>
		                <form:hidden path="precos[${status.index}].tipo" value="${tipoPreco}"/>
		            </div>
				</c:forEach>
				
				<div class="form-group">
					<label><s:message code="register.summary" /></label>
					<input type="file" name="sumario" class=".form-control" />
				</div>
		
		        <form:button type="submit"><s:message code="register.buttonRegister" /></form:button>
		    </form:form>
		   </div>
   
	</jsp:body>
</tags:pageTemplate>