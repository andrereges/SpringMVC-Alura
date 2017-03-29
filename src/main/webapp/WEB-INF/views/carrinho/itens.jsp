<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>

<tags:pageTemplate titulo="Meu carrinho">
	
	<jsp:attribute name="extraScripts">
    	<script> Todo o script. </script>
	</jsp:attribute>
	
	<jsp:body>		
		<section class="container middle">
			<h2 id="cart-title"><s:message code="cart.title" /></h2>
			<table id="cart-table">
			    <colgroup>
					<col class="item-col" />
					<col class="item-price-col" />
					<col class="item-quantity-col" />
					<col class="line-price-col" />
					<col class="delete-col" />
				</colgroup>
				<thead>
				  <tr>
				    <th class="cart-img-col"></th>
				    <th width="65%"><s:message code="cart.table.title" /></th>
				    <th width="10%"><s:message code="cart.table.price" /></th>
				    <th width="10%"><s:message code="cart.table.amount" /></th>
				    <th width="10%"><s:message code="cart.table.total" /></th>
				    <th width="5%"></th>
				  </tr>
				</thead>
				<tbody>
					 <c:forEach items="${carrinhoCompras.itens }" var="item">
						<tr>
							<td class="cart-img-col"><img src="${item.produto.sumarioPath }" width="71px" height="100px"/></td>
							<td class="item-title">${item.produto.titulo}</td>
							<td class="numeric-cell">${item.tipoPreco}<br> R$ ${item.produtoPreco}</td>
							<td class="quantity-input-cell"> 				         				       	        
								<form:form name="atualizar" action="${s:mvcUrl('CCC#add').arg(0, item.produto.id).build() }" method="POST">
									<input type="number" min="0" readonly="readonly" id="quantidade" name="quantidade" value="${carrinhoCompras.getQuantidade(item) }" />
								</form:form>	          				    			  
							</td>
							<td class="numeric-cell">${carrinhoCompras.getTotal(item)}</td>
							<td class="remove-item">
						        <form:form action="${s:mvcUrl('CCC#remover').arg(0, item.produto.id).arg(1, item.tipoPreco).build() }" method="POST">
									<input type="image" src='<c:url value="/resources/imagens/excluir.png"/>' alt="Excluir" title="Excluir" />
						        </form:form>		                 
							</td>
						</tr>
					</c:forEach>
					
					</tbody>
				  <tfoot>
				 	<tr>
				           <td colspan="3">
				           	<form:form action="${s:mvcUrl('PC#finalizar').build()}" method="POST">
				    	<input type="submit" class="formularioDoCarrinho-finalizar-botao" name="checkout" value="<s:message code='cart.table.footer.button' />" />
					</form:form>
					</td>
				<td class="numeric-cell">${carrinhoCompras.total}</td>
				                <td></td>
				            </tr>
				  </tfoot>
			  </table>
			
			<h2>Você já conhece os outros livros da Casa do Código?</h2>
			<ul id="collection" class="related-books">          
			    <li class="col-left">
			      <a href="/products/livro-plsql" class="block clearfix book-suggest" data-book="PL/SQL: Domine a linguagem do banco de dados Oracle">
			        <img width="113px" height="160px" src="http:////cdn.shopify.com/s/files/1/0155/7645/products/plsql-featured_compact.png?v=1434740236" alt="PL/SQL: Domine a linguagem do banco de dados Oracle"/>
			      </a>
			    </li>          
			</ul>
			
			<h2><a href='<c:url value="produtos/listar" /> '>Veja todos os livros que publicamos!</a></h2>
		</section> 
	</jsp:body>
</tags:pageTemplate>