package br.gov.df.reco.reco_df.dto;

/**
 * DTO para a resposta de login, incluindo token e detalhes do usuário.
 */
public class LoginResponse {
    public String token;
    public String username;
    // Você pode adicionar outros detalhes do usuário aqui, se necessário

    public LoginResponse(String token, String username) {
        this.token = token;
        this.username = username;
    }

    // Getters e Setters (ou use Lombok)
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
