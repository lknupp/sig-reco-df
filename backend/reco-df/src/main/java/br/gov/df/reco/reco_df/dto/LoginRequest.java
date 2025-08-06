package br.gov.df.reco.reco_df.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class LoginRequest {

    @NotBlank(message = "O login não pode estar vazio.")
    @Size(min = 3, max = 50, message = "O login deve ter entre 3 e 50 caracteres.")
    public String login;

    @NotBlank(message = "A senha não pode estar vazia.")
    @Size(min = 6, message = "A senha deve ter no mínimo 8 caracteres.")
    public String senha;

    // Getters e Setters (ou use Lombok para gerá-los automaticamente)
    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
