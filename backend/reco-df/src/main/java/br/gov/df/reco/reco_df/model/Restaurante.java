package br.gov.df.reco.reco_df.model;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import java.time.LocalTime;

/**
 * Representa a tabela 'restaurante'.
 */
@Entity
@Table(name = "restaurante")
public class Restaurante extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cd_rest")
    public Integer cdRest;

    @Column(name = "nome", nullable = false, length = 200)
    public String nome;

    @Column(name = "latitude", nullable = false)
    public Double latitude;

    @Column(name = "longitude", nullable = false)
    public Double longitude;

    @Column(name = "hr_aber", nullable = false)
    public LocalTime hrAber;

    @Column(name = "hr_fech", nullable = false)
    public LocalTime hrFech;

    @Column(name = "logradouro", nullable = false, length = 200)
    public String logradouro;

    @Column(name = "numero")
    public Integer numero;

    @Column(name = "complemento", length = 200)
    public String complemento;

    @Column(name = "bairro", nullable = false, length = 200)
    public String bairro;

    @Column(name = "cep", length = 8)
    public String cep;

    @Column(name = "cidade", nullable = false, length = 200)
    public String cidade;

    @Column(name = "sg_estado", nullable = false, length = 2)
    public String sgEstado;

    // Construtores
    public Restaurante() {
    }

    public Restaurante(String nome, Double latitude, Double longitude, LocalTime hrAber, LocalTime hrFech,
                       String logradouro, Integer numero, String complemento, String bairro, String cep,
                       String cidade, String sgEstado) {
        this.nome = nome;
        this.latitude = latitude;
        this.longitude = longitude;
        this.hrAber = hrAber;
        this.hrFech = hrFech;
        this.logradouro = logradouro;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cep = cep;
        this.cidade = cidade;
        this.sgEstado = sgEstado;
    }
}