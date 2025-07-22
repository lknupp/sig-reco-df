package br.gov.df.reco.reco_df.dto;

import br.gov.df.reco.reco_df.model.Alimento;

/**
 * DTO para representar um alimento.
 */
public class AlimentoDTO {
    public Integer cdAlimento;
    public String descricao;
    public String tipoAlimentoNome; // Nome do tipo de alimento

    public AlimentoDTO() {}

    public AlimentoDTO(Alimento alimento) {
        this.cdAlimento = alimento.cdAlimento;
        this.descricao = alimento.descricao;
        if (alimento.tipoAlimento != null) {
            this.tipoAlimentoNome = alimento.tipoAlimento.nome;
        }
    }
}