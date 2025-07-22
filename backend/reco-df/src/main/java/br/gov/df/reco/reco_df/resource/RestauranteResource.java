package br.gov.df.reco.reco_df.resource;

import br.gov.df.reco.reco_df.model.Restaurante;
import br.gov.df.reco.reco_df.repository.RestauranteRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

/**
 * Recurso REST para a entidade Restaurante.
 */
@Path("/restaurantes")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class RestauranteResource {

    @Inject
    RestauranteRepository restauranteRepository;

    @GET
    public List<Restaurante> getAllRestaurantes() {
        return restauranteRepository.listAll();
    }

    @GET
    @Path("/{id}")
    public Response getRestauranteById(@PathParam("id") Integer id) {
        Restaurante restaurante = restauranteRepository.findById(id);
        if (restaurante != null) {
            return Response.ok(restaurante).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @POST
    @Transactional
    public Response createRestaurante(Restaurante restaurante) {
        restauranteRepository.persist(restaurante);
        return Response.status(Response.Status.CREATED).entity(restaurante).build();
    }

    @PUT
    @Transactional
    @Path("/{id}")
    public Response updateRestaurante(@PathParam("id") Integer id, Restaurante restauranteUpdates) {
        Restaurante restaurante = restauranteRepository.findById(id);
        if (restaurante != null) {
            restaurante.nome = restauranteUpdates.nome;
            restaurante.latitude = restauranteUpdates.latitude;
            restaurante.longitude = restauranteUpdates.longitude;
            restaurante.hrAber = restauranteUpdates.hrAber;
            restaurante.hrFech = restauranteUpdates.hrFech;
            restaurante.logradouro = restauranteUpdates.logradouro;
            restaurante.numero = restauranteUpdates.numero;
            restaurante.complemento = restauranteUpdates.complemento;
            restaurante.bairro = restauranteUpdates.bairro;
            restaurante.cep = restauranteUpdates.cep;
            restaurante.cidade = restauranteUpdates.cidade;
            restaurante.sgEstado = restauranteUpdates.sgEstado;
            // No need to call persist explicitly, Panache manages updates in a transactional context
            return Response.ok(restaurante).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @DELETE
    @Transactional
    @Path("/{id}")
    public Response deleteRestaurante(@PathParam("id") Integer id) {
        if (restauranteRepository.deleteById(id)) {
            return Response.noContent().build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }
}