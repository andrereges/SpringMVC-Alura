<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<tags:pageTemplate titulo="Login">
	
	<jsp:attribute name="extraScripts">
    	<script> Todo o script. </script>
	</jsp:attribute>
	
	
	<jsp:body>
	
		
        <div class="container">
            <h1><s:message code="login.title" /></h1>
            <div>${mensagem }</div>
            <form:form servletRelativeAction="/login" method="POST">
                <div class="form-group">
                    <label><s:message code="login.name" /></label> -> dreeh.silva@hotmail.com
                    <input type="text" name="username" class="form-control" />
                </div>
                <div class="form-group">
                    <label><s:message code="login.password" /></label> -> 1234
                    <input type="password" name="password" class="form-control" />
                </div>
                <button type="submit" class="btn btn-primary"><s:message code="login.button" /></button>
                	<a href='<c:url value="usuarios/form" />' rel="nofollow"><s:message code="login.link.register" /></a>
            </form:form>
        </div>
        
	</jsp:body>
</tags:pageTemplate>