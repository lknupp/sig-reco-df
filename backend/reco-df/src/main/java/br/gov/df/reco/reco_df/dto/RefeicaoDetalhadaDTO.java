package br.gov.df.reco.reco_df.dto;

import br.gov.df.reco.reco_df.model.Refeicao;
import java.util.List;
import java.util.stream.Collectors;

/**
 * DTO para representar uma refeição com seus alimentos.
 */
public class RefeicaoDetalhadaDTO {
    public Integer cdRefeicao;
    public Integer valorCalorico;
    public Integer tipo;
    public List<AlimentoDTO> alimentos;

    public RefeicaoDetalhadaDTO() {}

    public RefeicaoDetalhadaDTO(Refeicao refeicao) {
        this.cdRefeicao = refeicao.cdRefeicao;
        this.valorCalorico = refeicao.valorCalorico;
        this.tipo = refeicao.tipo;
        if (refeicao.alimentos != null) {
            this.alimentos = refeicao.alimentos.stream()
                                .map(AlimentoDTO::new)
                                .collect(Collectors.toList());
        }
    }
}