package br.com.casadocodigo.loja.conf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import br.com.casadocodigo.loja.daos.UsuarioDAO;

@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired
    private UsuarioDAO usuarioDAO;
	
	@Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
        .antMatchers("/produtos/form").authenticated()
        .antMatchers("/login").anonymous()
        .antMatchers("/produtos").hasRole("ADMIN")
        .antMatchers("/produtos/").hasRole("ADMIN")
        //.antMatchers(HttpMethod.GET, "/pagamento/finalizar").authenticated()
        .antMatchers("/carrinho/**").permitAll()
        .antMatchers("/usuarios/**").permitAll()      
        //.antMatchers(HttpMethod.GET, "/produtos/").hasRole("ADMIN") // listagem        
        .antMatchers("/produtos/**").permitAll()                                      
        .antMatchers("/resources/**").permitAll()  
        .antMatchers("/arquivos-sumario/**").permitAll()                               
        .antMatchers("/").permitAll() 
        .anyRequest().authenticated()                                                
        .and().formLogin().loginPage("/login")                    
        .and().logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
        .logoutSuccessUrl("/");          
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(usuarioDAO)
            .passwordEncoder(new BCryptPasswordEncoder()); // Codifica a senha.
    }
}
