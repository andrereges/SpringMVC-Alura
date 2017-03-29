<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ attribute name="titulo" required="true" %>
<%@ attribute name="bodyClass" required="false" %>
<%@ attribute name="extraScripts" fragment="true" %>

<!DOCTYPE html>
<html>
    <head>
    
    	<title>${titulo} - Casa do Código</title>
    	<c:url value="/resources/imagens/" var="imgPath" /> 
		
        <%@ include file="/WEB-INF/views/includes/metadados.jsp" %>
        <%@ include file="/WEB-INF/views/includes/links.jsp" %>
        <%@ include file="/WEB-INF/views/includes/cabecalho.jsp" %>
        
    </head>
    <body class="${bodyClass}">

        <%@ include file="/WEB-INF/views/includes/menu.jsp" %>
        <jsp:doBody />   
        <jsp:invoke fragment="extraScripts"></jsp:invoke>
        <%@ include file="/WEB-INF/views/includes/rodape.jsp" %>
        
    </body>
</html>
