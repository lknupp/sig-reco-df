package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

/**
 * Representa a tabela 'cardapio'.
 */
@Entity
@Table(name = "cardapio")
public class Cardapio extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_cardapio")
    public Integer cdCardapio;

    @Column(name = "dt_cardapio", nullable = false)
    public LocalDate dtCardapio;

    @ManyToOne
    @JoinColumn(name = "cd_rest", nullable = false)
    public Restaurante restaurante;

    @OneToMany(mappedBy = "cardapio", cascade = CascadeType.ALL, orphanRemoval = true)
    public List<Refeicao> refeicoes;

    // Construtores
    public Cardapio() {
    }

    public Cardapio(LocalDate dtCardapio, Restaurante restaurante) {
        this.dtCardapio = dtCardapio;
        this.restaurante = restaurante;
    }
}