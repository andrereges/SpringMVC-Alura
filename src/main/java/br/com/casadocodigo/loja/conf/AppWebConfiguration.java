package br.com.casadocodigo.loja.conf;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.guava.GuavaCacheManager;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.format.datetime.DateFormatterRegistrar;
import org.springframework.format.support.DefaultFormattingConversionService;
import org.springframework.format.support.FormattingConversionService;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.google.common.cache.CacheBuilder;

import br.com.casadocodigo.loja.controllers.HomeController;
import br.com.casadocodigo.loja.daos.ProdutoDAO;
import br.com.casadocodigo.loja.infra.FileSaver;
import br.com.casadocodigo.loja.models.CarrinhoCompras;


@EnableWebMvc
@EnableCaching
@ComponentScan(basePackageClasses={HomeController.class, ProdutoDAO.class, 
		FileSaver.class, CarrinhoCompras.class})
public class AppWebConfiguration extends WebMvcConfigurerAdapter {
	
	/**
	 * Resolvedor de páginas .jsp
	 * gerencia o prefixo, sufixo.
	 * Expõe a modelo carrinhoCompras para que a view tenha acesso aos métodos públicos.
	 * @return
	 */
	@Bean //para que o Spring o gerencie este método
	public InternalResourceViewResolver internalResourceViewResolver() {
        InternalResourceViewResolver resolve = new InternalResourceViewResolver();
        resolve.setPrefix("/WEB-INF/views/");
        resolve.setSuffix(".jsp");
        resolve.setExposedContextBeanNames("carrinhoCompras");
        return resolve;
    }
	
	/**
	 * Gerencia o path base da aplicação, ou seja, o caminho absoluto.
	 * Deixa por padrão o encode UTF-8.
	 * Tempo de cache 1 segundo.
	 * @return
	 */
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource =
				new ReloadableResourceBundleMessageSource();
		
		messageSource.setBasename("/WEB-INF/messages");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setCacheSeconds(1);
		
		return messageSource;
	}
	
	/**
	 * Converte para o padrão("dd/MM/yyyy") a data recebida pelos formulários.
	 * @return
	 */
	@Bean
    public FormattingConversionService mvcConversionService() {
        DefaultFormattingConversionService conversionService = new DefaultFormattingConversionService();
        DateFormatterRegistrar registra = new DateFormatterRegistrar();
        registra.setFormatter(new DateFormatter("dd/MM/yyyy"));      
        registra.registerFormatters(conversionService);

        return conversionService;

    }
	
	/**
	 * Gerencia os formulário que recebem arquivos do multiformatos(.jpg, .pnp, e etc).
	 */
	@Bean
	public MultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}
	
	/**
	 * Servlet default para requisições de css, js. 
	 * Método que ativa o uso do CSS e JavaScript nas páginas JSPs.
	 */
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
	    configurer.enable();
	}
	
	/**
	 * Responsável pelo envio de dados para uma aplicação externa, fazendo a integração entre sistemas.
	 * @return
	 */
	@Bean
    public RestTemplate restTemplate(){
        return new RestTemplate();
    }
	
	/**
	 * Gerenciador de Cache, foi usado o Guava da Google.
	 * Usado para melhorar a performance da consulta ao banco de dados.
	 * @return
	 */
	@Bean
	public CacheManager cacheManager() {
        CacheBuilder<Object, Object> builder = CacheBuilder.newBuilder()
        		.maximumSize(100)
        		.expireAfterAccess(5, TimeUnit.MINUTES);
        
        GuavaCacheManager manager = new GuavaCacheManager();
        manager.setCacheBuilder(builder);
        return manager;
    }
	
	/**
	 * Método responsável por gerenciar qual tipo de view será escolhida .jsp ou .json
	 * @param manager Recebe qual tipo de view foi escolhida.
	 * @return Página escolhida.
	 */
	
	@Bean
    public ViewResolver contentNegotiationViewResolver(ContentNegotiationManager manager){
        List<ViewResolver> viewResolvers = new ArrayList<>();
        viewResolvers.add(internalResourceViewResolver());
        viewResolvers.add(new JsonViewResolver());

        ContentNegotiatingViewResolver resolver = new ContentNegotiatingViewResolver();
        resolver.setViewResolvers(viewResolvers);
        resolver.setContentNegotiationManager(manager);
        return resolver;
    }
	
	/**
	 * Interceptador de registro de mudança de localidade
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LocaleChangeInterceptor());
    }
	
	/**
	 * Guarda a configuração de localidade dentro de um cookie
	 * @return
	 */
    @Bean
    public LocaleResolver localeResolver(){
        return new CookieLocaleResolver();
    }
    
    @Bean
    public MailSender mailSender(){
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
       
        mailSender.setHost("smtp.gmail.com");
        mailSender.setProtocol("smtp");
        mailSender.setUsername("andreriggs90@gmail.com");
        mailSender.setPassword("***");
        mailSender.setPort(587);
        mailSender.setDefaultEncoding("UTF-8");

        Properties mailProperties = new Properties();
        mailProperties.put("mail.smtp.auth", true);
        mailProperties.put("mail.smtp.starttls.enable", true);

        mailSender.setJavaMailProperties(mailProperties);
        return mailSender;
    }
}
