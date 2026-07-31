package models;

import java.time.LocalDate;
import enums.RoleUsuarioEnum;

public class Usuario {

    public void setId(int id) {
        this.id = id;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public void setRole(RoleUsuarioEnum role) {
        this.role = role;
    }
    int id;
    String nome;
    String email;
    String senha;
    String telefone;
    LocalDate dataNascimento;
    String cpf;
    RoleUsuarioEnum role;

    public Usuario(int id, String nome, String email, String senha, String telefone, LocalDate dataNascimento, String cpf, RoleUsuarioEnum role) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.telefone = telefone;
        this.dataNascimento = dataNascimento;
        this.cpf = cpf;
        this.role = role;
    }
    
    public Usuario(){}

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getSenha() {
        return senha;
    }

    public String getTelefone() {
        return telefone;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public String getCpf() {
        return cpf;
    }

    public RoleUsuarioEnum getRole() {
        return role;
    }
    
    
}
