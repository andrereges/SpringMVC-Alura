package br.com.casadocodigo.loja.daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import br.com.casadocodigo.loja.models.Usuario;

@Repository
public class UsuarioDAO implements UserDetailsService {
    
	@PersistenceContext
    private EntityManager manager;
	
    public UserDetails loadUserByUsername(String email){
        List<Usuario> usuarios = manager.createQuery("select u from Usuario u where u.email = :email", Usuario.class)
                .setParameter("email", email)
                .getResultList();

        if(usuarios.isEmpty()){
            throw new UsernameNotFoundException("O usuário "+ email +" não foi encontrado");
        }
        
        return usuarios.get(0);
    }

	public void gravar(Usuario usuario) {
		manager.persist(usuario);	
	}
	
	public List<Usuario> listar() {
		
		return manager.createQuery("Select u from Usuario u", Usuario.class).getResultList();
	}

	public Usuario find(String email) {
		
		return manager.createQuery("select distinct(u) from Usuario u where u.id = :email", Usuario.class).setParameter("email", email).getSingleResult();
	}

	public void atualizar(Usuario usuario) {

		manager.createQuery("update Usuario u set u.nome= :nome, u.senha= :senha where u.id= :email")
		.setParameter("nome", usuario.getNome())
		.setParameter("senha", usuario.getPassword())
		.setParameter("email", usuario.getEmail())
		.executeUpdate();
		
		System.out.println("metodo atualizar "+usuario.getNome());
		
	}
}