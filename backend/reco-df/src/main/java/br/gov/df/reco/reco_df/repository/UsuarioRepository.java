package br.gov.df.reco.reco_df.repository;

import br.gov.df.reco.reco_df.model.Usuario;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

/**
 * Repositório Panache para a entidade Usuario.
 */
@ApplicationScoped
public class UsuarioRepository implements PanacheRepositoryBase<Usuario, Integer> {
    // Métodos Panache como listAll(), findById(), persist(), delete() já estão disponíveis.
    // Adicione métodos personalizados aqui, se necessário.
    public Usuario findByLoginAndSenha(String login, String senha) {
        return find("login = ?1 and senha = ?2", login, senha).firstResult();
    }
}