package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

/**
 * Representa a tabela 'usuario'.
 */
@Entity
@Table(name = "usuario")
public class Usuario extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_usuario")
    public Integer cdUsuario;

    @Column(name = "login", unique = true, nullable = false, length = 16)
    public String login;

    @Column(name = "senha", nullable = false, length = 256)
    public String senha;

    @Column(name = "role", nullable = false)
    public Integer role;

    // Construtores
    public Usuario() {
    }

    public Usuario(String login, String senha, Integer role) {
        this.login = login;
        this.senha = senha;
        this.role = role;
    }
}