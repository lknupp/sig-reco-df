package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

/**
 * Representa a tabela 'tipo_alimento'.
 */
@Entity
@Table(name = "tipo_alimento")
public class TipoAlimento extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_tipo_alimento")
    public Integer cdTipoAlimento;

    @Column(name = "nome", nullable = false, length = 50)
    public String nome;

    // Construtores
    public TipoAlimento() {
    }

    public TipoAlimento(String nome) {
        this.nome = nome;
    }
}