package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

/**
 * Representa a tabela 'alimento'.
 */
@Entity
@Table(name = "alimento")
public class Alimento extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_alimento")
    public Integer cdAlimento;

    @ManyToOne // Relação Many-to-One com TipoAlimento
    @JoinColumn(name = "tp_alimento", nullable = false) // Mapeia para a coluna tp_alimento
    public TipoAlimento tipoAlimento; // Alterado para objeto TipoAlimento

    @Column(name = "descricao", nullable = false, length = 300)
    public String descricao;

    // Construtores
    public Alimento() {
    }

    public Alimento(TipoAlimento tipoAlimento, String descricao) {
        this.tipoAlimento = tipoAlimento;
        this.descricao = descricao;
    }
}