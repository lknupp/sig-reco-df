package br.gov.df.reco.reco_df.dto;

import br.gov.df.reco.reco_df.model.Cardapio;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 * DTO para representar um cardápio com suas refeições detalhadas.
 */
public class CardapioDetalhadoDTO {
    public Integer cdCardapio;
    public LocalDate dtCardapio;
    public String restauranteNome; // Nome do restaurante
    public List<RefeicaoDetalhadaDTO> refeicoes;

    public CardapioDetalhadoDTO() {}

    public CardapioDetalhadoDTO(Cardapio cardapio) {
        this.cdCardapio = cardapio.cdCardapio;
        this.dtCardapio = cardapio.dtCardapio;
        if (cardapio.restaurante != null) {
            this.restauranteNome = cardapio.restaurante.nome;
        }
        if (cardapio.refeicoes != null) {
            this.refeicoes = cardapio.refeicoes.stream()
                                .map(RefeicaoDetalhadaDTO::new)
                                .collect(Collectors.toList());
        }
    }
}