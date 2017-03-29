package br.com.casadocodigo.loja.controllers;

import java.util.concurrent.Callable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.casadocodigo.loja.models.CarrinhoCompras;
import br.com.casadocodigo.loja.models.DadosPagamento;
import br.com.casadocodigo.loja.models.Usuario;

@Controller
@RequestMapping("/pagamento")
@Scope(value=WebApplicationContext.SCOPE_REQUEST)
public class PagamentoController {
	
	@Autowired
	private CarrinhoCompras carrinho;
	
	@Autowired
	private RestTemplate restTemplate;
	
	@Autowired
    private MailSender sender;
	
	@RequestMapping(value="/finalizar", method= RequestMethod.POST)
	public Callable<ModelAndView> finalizar(@AuthenticationPrincipal Usuario usuario, RedirectAttributes ra) {
		
		return () -> {
			
				String url = "http://book-payment.herokuapp.com/payment";
			
			try {
				
				String response = restTemplate.postForObject(url, new DadosPagamento(carrinho.getTotal()), String.class);
				
				System.out.println(response);
				
				enviaEmailCompraProduto(usuario);
				
				ra.addFlashAttribute("mensagem", "Pagamento efetuado com sucesso");
				
				carrinho.zerarCarrinho();
				
				return new ModelAndView("redirect:/");
				
			} catch(HttpClientErrorException e) {
				e.printStackTrace();
				ra.addFlashAttribute("mensagem", "Valor maior que o permitido");
				return new ModelAndView("redirect:/");
			}
			
		};		
	}

	private void enviaEmailCompraProduto(Usuario usuario) {
		
		SimpleMailMessage email = new SimpleMailMessage();

        email.setSubject("Compra finalizada com sucesso");
        //email.setTo(usuario.getEmail());
        email.setTo("dreeh.silva@hotmail.com");
        email.setText("Compra foi aprovada com sucesso no valor de " + carrinho.getTotal());
        email.setFrom("no-reply@casadocodigo.com.br");

        sender.send(email);
		
	}
}
