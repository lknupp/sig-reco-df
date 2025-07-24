package br.gov.df.reco.reco_df.repository;

import br.gov.df.reco.reco_df.model.Cardapio;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.time.LocalDate;
import java.util.List;

/**
 * Repositório Panache para a entidade Cardapio.
 * O segundo tipo genérico (Integer) especifica o tipo da chave primária.
 */
@ApplicationScoped
public class CardapioRepository implements PanacheRepositoryBase<Cardapio, Integer> {
    /**
     * Busca cardápios por data, incluindo suas refeições e alimentos associados.
     * @param date A data para buscar os cardápios.
     * @return Uma lista de Cardapio com refeições e alimentos carregados.
     */
    public List<Cardapio> findByDateWithDetails(LocalDate date) {
        return find("dtCardapio = ?1", date).list();
    }

        /**
     * Busca cardápios por data, incluindo suas refeições e alimentos associados.
     * @param date A data para buscar os cardápios.
     * @return Uma lista de Cardapio com refeições e alimentos carregados.
     */
    public List<Cardapio> findByDateAndRestaurantWithDetails(LocalDate date, Integer cdRest) {
        return find("dtCardapio = ?1 AND restaurante.cdRest = ?2", date, cdRest).list();
    }

    /**
     * Busca cardápios para um mês e ano específicos.
     * @param year O ano.
     * @param month O mês (1-12).
     * @return Uma lista de Cardapio.
     */
    public List<Cardapio> findByMonthAndYear(int year, int month) {
        // A query usa funções SQL/JPQL para extrair o ano e o mês da coluna dtCardapio
        return find("EXTRACT(YEAR FROM dtCardapio) = ?1 AND EXTRACT(MONTH FROM dtCardapio) = ?2", year, month).list();
    }
}