package br.gov.df.reco.reco_df.resource;

import br.gov.df.reco.reco_df.dto.LoginRequest;
import br.gov.df.reco.reco_df.dto.LoginResponse;
import br.gov.df.reco.reco_df.model.Usuario;
import br.gov.df.reco.reco_df.repository.UsuarioRepository;
import io.smallrye.jwt.build.Jwt;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.IOException;
import java.io.InputStream;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Set;

/**
 * Recurso REST para a entidade Usuario.
 */
@Path("/usuarios")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UsuarioResource {

    @Inject
    UsuarioRepository usuarioRepository;

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response loginUsuario(@Valid LoginRequest request) {
        Usuario usuario = usuarioRepository.findByLoginAndSenha(request.getLogin(), request.getSenha());
        if (usuario != null) {
            String token = Jwt.claims()
                    .issuer("reco-df-issuer") // O emissor do seu token
                    .subject(usuario.login) // O assunto do token (geralmente o ID ou login do usuário)
                    .groups(Set.of("admin")) // As roles ou grupos do usuário
                    .issuedAt(Instant.now()) // Quando o token foi emitido
                    .expiresIn(3600) // Validade do token (1 hora, em segundos)
                    .sign(); // Assina o token com a chave privada

            LoginResponse response = new LoginResponse(token, usuario.login);
            return Response.ok(response).build();
        }
        return Response.status(Response.Status.UNAUTHORIZED)
                .entity("{\"message\": \"Credenciais inválidas.\"}")
                .build();
    }

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
            // No need to call persist explicitly, Panache manages updates in a
            // transactional context
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