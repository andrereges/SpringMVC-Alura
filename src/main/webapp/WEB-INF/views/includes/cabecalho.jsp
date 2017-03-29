<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<header id="layout-header">
		<div class="clearfix container">
			<a href='<c:url value="/" />' id="logo">
			</a>
			<div id="header-content">
				<nav id="main-nav">		
					<ul class="clearfix">
						
						<security:authorize access="hasRole('ROLE_ADMIN')">
							<li><a href="${s:mvcUrl('PC#listar').build() }" rel="nofollow"> <s:message code="header.productList" /> </a></li>
					        <li><a href="${s:mvcUrl('PC#form').build() }" rel="nofollow"><s:message code="header.productRegister" /></a></li>
						</security:authorize>
						
						<li><a href="${s:mvcUrl('CCC#itens').build()}" rel="nofollow"><s:message code="header.myCart" arguments="${carrinhoCompras.quantidade}" /> </a></li>
						
						<!--  
						<li><a href="/pages/sobre-a-casa-do-codigo" rel="nofollow">Sobre Nós</a></li>
						<li><a href="/pages/perguntas-frequentes" rel="nofollow">Perguntas Frequentes</a></li>
						-->	
						
						<security:authorize access="isAuthenticated()">
						<security:authentication property="principal.username" var="usuario"/>
						
							<c:if test= "${usuario != null}"> 
								<li>
									<form:form action="${s:mvcUrl('UC#formAtualizar').arg(0, usuario).build()}" method="POST">								    	
										<button type="submit" class="btn btn-default"><s:message code="header.user" />: ${usuario}</button>
									</form:form>
							
									<form:form servletRelativeAction="/logout" method="POST">			    
								 		<button type="submit" class="btn btn-primary"><s:message code="header.logoutButton" /></button>
								    </form:form>
								</li>	
							</c:if>	
						</security:authorize>
						
						<c:if test= "${usuario == null}"> 
							<li>
								<form:form servletRelativeAction="/login" method="POST">			    
							 		<button type="submit" class="btn btn-primary"><s:message code="header.loginButton" /></button>
							    </form:form>
							</li>	
						</c:if>
						
						<li>
					        <a href="?locale=pt" rel="nofollow">
					        	<s:message code="header.pt" />
					        </a>
					    </li>
					    
					    <li>
					        <a href="?locale=en_US" rel="nofollow">
					        	<s:message code="header.en" />
					        </a>
					    </li>
														    
					</ul>
			    
				</nav>
			</div>
		</div>
	</header>