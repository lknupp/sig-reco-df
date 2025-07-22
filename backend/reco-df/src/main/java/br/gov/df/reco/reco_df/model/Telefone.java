package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

/**
 * Representa a tabela 'telefone'.
 */
@Entity
@Table(name = "telefone")
public class Telefone extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_telefone")
    public Integer cdTelefone;

    @Column(name = "ddd", nullable = false)
    public Integer ddd;

    @Column(name = "telefone", nullable = false)
    public Integer telefone;

    @ManyToOne
    @JoinColumn(name = "cd_rest", nullable = false)
    public Restaurante restaurante;

    // Construtores
    public Telefone() {
    }

    public Telefone(Integer ddd, Integer telefone, Restaurante restaurante) {
        this.ddd = ddd;
        this.telefone = telefone;
        this.restaurante = restaurante;
    }
}