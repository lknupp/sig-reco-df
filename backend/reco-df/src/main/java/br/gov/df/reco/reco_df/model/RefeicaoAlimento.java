package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import java.io.Serializable;

/**
 * Representa a tabela de junção 'refeicao_alimento'.
 */
@Entity
@Table(name = "refeicao_alimento")
@IdClass(RefeicaoAlimento.RefeicaoAlimentoId.class)
public class RefeicaoAlimento extends PanacheEntityBase {

    @Id
    @ManyToOne
    @JoinColumn(name = "cd_alimento", nullable = false)
    public Alimento alimento;

    @Id
    @ManyToOne
    @JoinColumn(name = "cd_refeicao", nullable = false)
    public Refeicao refeicao;

    // Construtores
    public RefeicaoAlimento() {
    }

    public RefeicaoAlimento(Alimento alimento, Refeicao refeicao) {
        this.alimento = alimento;
        this.refeicao = refeicao;
    }

    // Classe para a chave primária composta
    public static class RefeicaoAlimentoId implements Serializable {
        public Integer alimento;
        public Integer refeicao;

        public RefeicaoAlimentoId() {}

        public RefeicaoAlimentoId(Integer alimento, Integer refeicao) {
            this.alimento = alimento;
            this.refeicao = refeicao;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            RefeicaoAlimentoId that = (RefeicaoAlimentoId) o;
            return alimento.equals(that.alimento) && refeicao.equals(that.refeicao);
        }

        @Override
        public int hashCode() {
            return java.util.Objects.hash(alimento, refeicao);
        }
    }
}