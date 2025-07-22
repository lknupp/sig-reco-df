package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import java.io.Serializable;

/**
 * Representa a tabela de junção 'administra'.
 */
@Entity
@Table(name = "administra")
@IdClass(Administra.AdministraId.class)
public class Administra extends PanacheEntityBase {

    @Id
    @ManyToOne
    @JoinColumn(name = "cd_rest", nullable = false)
    public Restaurante restaurante;

    @Id
    @ManyToOne
    @JoinColumn(name = "cd_usuario", nullable = false)
    public Usuario usuario;

    // Construtores
    public Administra() {
    }

    public Administra(Restaurante restaurante, Usuario usuario) {
        this.restaurante = restaurante;
        this.usuario = usuario;
    }

    // Classe para a chave primária composta
    public static class AdministraId implements Serializable {
        public Integer restaurante;
        public Integer usuario;

        public AdministraId() {}

        public AdministraId(Integer restaurante, Integer usuario) {
            this.restaurante = restaurante;
            this.usuario = usuario;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            AdministraId that = (AdministraId) o;
            return restaurante.equals(that.restaurante) && usuario.equals(that.usuario);
        }

        @Override
        public int hashCode() {
            return java.util.Objects.hash(restaurante, usuario);
        }
    }
}