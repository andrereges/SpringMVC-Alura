<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<tags:pageTemplate titulo="${produto.titulo }">
	
	<jsp:attribute name="extraScripts">
    	<script> Todo o script. </script>
	</jsp:attribute>
	
	
	<jsp:body>	

	<article id="livro-css-eficiente">
		  <header id="product-highlight" class="clearfix">
		    <div id="product-overview" class="container">
		      
		      <img width="280px" 	
      				height="395px" 
      				src="${produto.sumarioPath }"
					alt="${produto.titulo }"
					title="${produto.titulo }" 
					class="product-featured-image" />
		      
		      <h1 class="product-title">${produto.titulo }</h1>
		      <p class="product-author">
		        <span class="product-author-link">
		          
		        </span>
		      </p>	
			
		    <p class="book-description">
		    	${produto.descricao }
		    </p>
		    </div>
		  </header>

	  <section class="buy-options clearfix">  
	  <form:form servletRelativeAction="/carrinho/add" method="POST" class="container">
	    <ul id="variants" class="clearfix">
	    	<input type="hidden" name="produtoId" value="${produto.id}" />
	    	<c:forEach items="${produto.precos }" var="preco" >
		    	  <li class="buy-option">
		            <input type="radio" name="tipoPreco" class="variant-radio" id="tipo" value="${preco.tipo }"  checked="checked"  />
		            <label  class="variant-label" for="product-variant-9720393823">
		              ${preco.tipo}  
		            </label>
		            <small class="compare-at-price">R$ 39,90</small>
		            <p class="variant-price">R$ ${preco.valor}</p>
		          </li>
	        </c:forEach>           
	    </ul>
	    <button type="submit" class="submit-image icon-basket-alt"  title="Compre Agora"></button>
	    
	  </form:form>
	  
	</section>
	  
	<div class="container">
	  <section class="summary">
	    <ul>
	      	<li><h3>E muito mais... <a href='/pages/sumario-java8'>veja o sumário</a>.</h3></li>
	    </ul>
	  </section>
	  
	  <section class="data product-detail">
	    <h2 class="section-title">Dados do livro:</h2>
	    <p>Número de páginas: <span>${produto.paginas }</span></p>
	    <p></p>
	    <p>Data de publicação: 
	    	<fmt:formatDate pattern="dd/MM/yyyy" value="${produto.dataLancamento.time}"/> 
	    </p>
	    <p>Encontrou um erro? <a href='/submissao-errata' target='_blank'>Submeta uma errata</a></p>
	  </section>
	</div>
	
	</article>	
	
	</jsp:body>
</tags:pageTemplate>