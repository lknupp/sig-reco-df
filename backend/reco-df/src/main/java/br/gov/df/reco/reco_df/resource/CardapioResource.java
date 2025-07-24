package br.gov.df.reco.reco_df.resource;

import br.gov.df.reco.reco_df.model.Cardapio;
import br.gov.df.reco.reco_df.repository.CardapioRepository;
import br.gov.df.reco.reco_df.dto.CardapioDetalhadoDTO; // Importar o DTO
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Recurso REST para a entidade Cardapio.
 */
@Path("/cardapios")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CardapioResource {

    @Inject
    CardapioRepository cardapioRepository;

    @GET
    public List<Cardapio> getAllCardapios() {
        return cardapioRepository.listAll();
    }

    @GET
    @Path("/{id}")
    public Response getCardapioById(@PathParam("id") Integer id) {
        Cardapio cardapio = cardapioRepository.findById(id);
        if (cardapio != null) {
            return Response.ok(cardapio).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @POST
    @Transactional
    public Response createCardapio(Cardapio cardapio) {
        // Certifique-se de que o restaurante associado já existe no banco de dados
        // ou trate a criação/associação aqui
        cardapioRepository.persist(cardapio);
        return Response.status(Response.Status.CREATED).entity(cardapio).build();
    }

    @PUT
    @Transactional
    @Path("/{id}")
    public Response updateCardapio(@PathParam("id") Integer id, Cardapio cardapioUpdates) {
        Cardapio cardapio = cardapioRepository.findById(id);
        if (cardapio != null) {
            cardapio.dtCardapio = cardapioUpdates.dtCardapio;
            cardapio.restaurante = cardapioUpdates.restaurante; // Cuidado ao atualizar FKs
            return Response.ok(cardapio).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @DELETE
    @Transactional
    @Path("/{id}")
    public Response deleteCardapio(@PathParam("id") Integer id) {
        if (cardapioRepository.deleteById(id)) {
            return Response.noContent().build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    /**
     * Retorna os cardápios para uma data específica, incluindo detalhes das refeições e alimentos.
     * Exemplo de uso: GET /cardapios/data/2025-07-22
     * @param dateString A data no formato YYYY-MM-DD.
     * @return Uma lista de CardapioDetalhadoDTO.
     */
    @GET
    @Path("/data/{dateString}")
    @Transactional // Necessário para carregar relações lazy
    public Response getCardapiosByDateWithDetails(@PathParam("dateString") String dateString) {
        LocalDate date;
        try {
            date = LocalDate.parse(dateString);
        } catch (DateTimeParseException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("Formato de data inválido. Use YYYY-MM-DD.")
                           .build();
        }

        // 1. Recuperar o código do cardápio para o dia especificado (ou vários cardápios)
        List<Cardapio> cardapios = cardapioRepository.findByDateWithDetails(date);

        if (cardapios.isEmpty()) {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("Nenhum cardápio encontrado para a data: " + dateString)
                           .build();
        }

        // 2. e 3. Recuperar as refeições e alimentos vinculados a essas refeições
        // Isso acontecerá automaticamente (lazy loading) quando os DTOs forem construídos,
        // pois estamos dentro de um contexto transacional (@Transactional).
        List<CardapioDetalhadoDTO> dtos = cardapios.stream()
                                                .map(CardapioDetalhadoDTO::new)
                                                .collect(Collectors.toList());
        return Response.ok(dtos).build();
    }

    /**
     * Retorna os cardápios para uma data específica, incluindo detalhes das refeições e alimentos.
     * Exemplo de uso: GET /cardapios/data/2025-07-22
     * @param dateString A data no formato YYYY-MM-DD.
     * @return Uma lista de CardapioDetalhadoDTO.
     */
    @GET
    @Path("/data/{dateString}/restaurante/{cdRest}")
    @Transactional // Necessário para carregar relações lazy
    public Response getCardapiosByDateAndRestaurantWithDetails(@PathParam("dateString") String dateString, @PathParam("cdRest") Integer codigoRestaurante) {
        LocalDate date;
        try {
            date = LocalDate.parse(dateString);
        } catch (DateTimeParseException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("Formato de data inválido. Use YYYY-MM-DD.")
                           .build();
        }

        // 1. Recuperar o código do cardápio para o dia especificado (ou vários cardápios)
        List<Cardapio> cardapios = cardapioRepository.findByDateAndRestaurantWithDetails(date, codigoRestaurante);

        if (cardapios.isEmpty()) {
            Response.ok(cardapios).build();
        }

        // 2. e 3. Recuperar as refeições e alimentos vinculados a essas refeições
        // Isso acontecerá automaticamente (lazy loading) quando os DTOs forem construídos,
        // pois estamos dentro de um contexto transacional (@Transactional).
        List<CardapioDetalhadoDTO> dtos = cardapios.stream()
                                                .map(CardapioDetalhadoDTO::new)
                                                .collect(Collectors.toList());
        return Response.ok(dtos).build();
    }

    /**
     * Retorna todos os cardápios para um mês e ano específicos, incluindo detalhes das refeições e alimentos.
     * Exemplo de uso: GET /cardapios/mes/2025/7 (para julho de 2025)
     * @param year O ano.
     * @param month O mês (1-12).
     * @return Uma lista de CardapioDetalhadoDTO.
     */
    @GET
    @Path("/mes/{year}/{month}")
    @Transactional // Necessário para carregar relações lazy
    public Response getCardapiosByMonthAndYearWithDetails(@PathParam("year") int year, @PathParam("month") int month) {
        if (month < 1 || month > 12) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("Mês inválido. Use um valor entre 1 e 12.")
                           .build();
        }

        List<Cardapio> cardapios = cardapioRepository.findByMonthAndYear(year, month);

        if (cardapios.isEmpty()) {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("Nenhum cardápio encontrado para o mês " + month + " do ano " + year + ".")
                           .build();
        }

        List<CardapioDetalhadoDTO> dtos = cardapios.stream()
                                                .map(CardapioDetalhadoDTO::new)
                                                .collect(Collectors.toList());
        return Response.ok(dtos).build();
    }
}