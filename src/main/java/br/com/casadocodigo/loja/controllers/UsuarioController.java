package br.com.casadocodigo.loja.controllers;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.casadocodigo.loja.daos.UsuarioDAO;
import br.com.casadocodigo.loja.models.Role;
import br.com.casadocodigo.loja.models.Usuario;
import br.com.casadocodigo.loja.validation.UsuarioValidation;

@Controller
@RequestMapping("/usuarios")
public class UsuarioController {
	
	@Autowired
	private UsuarioDAO usuarioDAO;
	
	@InitBinder
	public void iniBinder(WebDataBinder binder) {
		
		binder.addValidators(new UsuarioValidation());
	}
	
	
	@RequestMapping("/form")
	public ModelAndView form(Usuario usuario) {
		
		ModelAndView modelAndView = new ModelAndView("usuarios/form");
		modelAndView.addObject(usuario);
		return modelAndView;
	}
	
	@RequestMapping(value="/formAtualizar", method= RequestMethod.POST)
	public ModelAndView formAtualizar(String email, RedirectAttributes redirect) {
		
		Usuario usuario = new Usuario();
		usuario.setEmail(email);
		
		usuario = usuarioDAO.find(email);
				
		ModelAndView modelAndView = new ModelAndView("usuarios/form");
		
		modelAndView.addObject("usuario", usuario);
		
		return modelAndView;
	}
	
	@Transactional
	@RequestMapping("gravar")
	public ModelAndView gravar( Usuario usuario, BindingResult result, RedirectAttributes ra) {
		
		if(result.hasErrors()){
			return form(usuario);
		}
        
		String senhaBcrypt = new BCryptPasswordEncoder().encode(usuario.getSenha());
		
		usuario.setSenha(senhaBcrypt);
		
		usuarioDAO.gravar(usuario);;
		
		ra.addFlashAttribute("mensagem", "Usuário "+ usuario.getEmail() +" cadastrado com sucesso.");
		
		return new ModelAndView("redirect:/login");
	}
	
	//@Transactional
	@RequestMapping("atualizar")
	public ModelAndView atualizar(Usuario usuario, RedirectAttributes ra) {
		

		/*if(result.hasErrors()){
			return form(usuario);
		}*/
        
		String senhaBcrypt = new BCryptPasswordEncoder().encode(usuario.getSenha());
		
		usuario.setSenha(senhaBcrypt);
		
		usuarioDAO.atualizar(usuario);
		
		usuario.setRoles(Arrays.asList(new Role("ROLE_ADMIN")));
		
		ra.addFlashAttribute("mensagem", "Usuário "+ usuario.getEmail() +" atualizado com sucesso.");
		
		return new ModelAndView("redirect:/");
	}
}
