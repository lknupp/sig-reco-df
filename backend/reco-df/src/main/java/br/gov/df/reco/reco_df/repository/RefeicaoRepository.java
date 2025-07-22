package br.gov.df.reco.reco_df.repository;

import br.gov.df.reco.reco_df.model.Refeicao;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

/**
 * Repositório Panache para a entidade Refeicao.
 */
@ApplicationScoped
public class RefeicaoRepository implements PanacheRepositoryBase<Refeicao, Integer> {
    // Métodos Panache como listAll(), findById(), persist(), delete() já estão disponíveis.
    // Adicione métodos personalizados aqui, se necessário.
}