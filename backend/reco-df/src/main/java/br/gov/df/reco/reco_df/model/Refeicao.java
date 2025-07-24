package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;
/**
 * Representa a tabela 'refeicao'.
 */
@Entity
@Table(name = "refeicao")
public class Refeicao extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_refeicao")
    public Integer cdRefeicao;

    @Column(name = "valor_calorico", nullable = false)
    public Integer valorCalorico;

    @Column(name = "tipo", nullable = false)
    public Integer tipo;

    @ManyToOne
    @JoinColumn(name = "cd_cardapio", nullable = false)
    @JsonIgnore
    public Cardapio cardapio;

    // Relação Many-to-Many com Alimento através da tabela de junção refeicao_alimento
    @ManyToMany
    @JoinTable(
        name = "refeicao_alimento",
        joinColumns = @JoinColumn(name = "cd_refeicao"),
        inverseJoinColumns = @JoinColumn(name = "cd_alimento")
    )
    public List<Alimento> alimentos;

    // Construtores
    public Refeicao() {
    }

    public Refeicao(Integer valorCalorico, Integer tipo, Cardapio cardapio) {
        this.valorCalorico = valorCalorico;
        this.tipo = tipo;
        this.cardapio = cardapio;
    }
}