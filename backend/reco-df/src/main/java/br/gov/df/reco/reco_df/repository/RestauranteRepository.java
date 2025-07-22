package br.gov.df.reco.reco_df.repository;

import br.gov.df.reco.reco_df.model.Restaurante;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

/**
 * Repositório Panache para a entidade Restaurante.
 */
@ApplicationScoped
public class RestauranteRepository implements PanacheRepositoryBase<Restaurante, Integer> {
    // Métodos Panache como listAll(), findById(), persist(), delete() já estão disponíveis.
    // Adicione métodos personalizados aqui, se necessário.
}