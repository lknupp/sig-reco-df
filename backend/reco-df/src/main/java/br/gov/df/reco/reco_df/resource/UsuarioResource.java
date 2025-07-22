package br.gov.df.reco.reco_df.resource;

import br.gov.df.reco.reco_df.model.Usuario;
import br.gov.df.reco.reco_df.repository.UsuarioRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

/**
 * Recurso REST para a entidade Usuario.
 */
@Path("/usuarios")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UsuarioResource {

    @Inject
    UsuarioRepository usuarioRepository;

    @GET
    public List<Usuario> getAllUsuarios() {
        return usuarioRepository.listAll();
    }

    @GET
    @Path("/{id}")
    public Response getUsuarioById(@PathParam("id") Integer id) {
        Usuario usuario = usuarioRepository.findById(id);
        if (usuario != null) {
            return Response.ok(usuario).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @POST
    @Transactional
    public Response createUsuario(Usuario usuario) {
        usuarioRepository.persist(usuario);
        return Response.status(Response.Status.CREATED).entity(usuario).build();
    }

    @PUT
    @Transactional
    @Path("/{id}")
    public Response updateUsuario(@PathParam("id") Integer id, Usuario usuarioUpdates) {
        Usuario usuario = usuarioRepository.findById(id);
        if (usuario != null) {
            usuario.login = usuarioUpdates.login;
            usuario.senha = usuarioUpdates.senha;
            usuario.role = usuarioUpdates.role;
            // No need to call persist explicitly, Panache manages updates in a transactional context
            return Response.ok(usuario).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @DELETE
    @Transactional
    @Path("/{id}")
    public Response deleteUsuario(@PathParam("id") Integer id) {
        if (usuarioRepository.deleteById(id)) {
            return Response.noContent().build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }
}