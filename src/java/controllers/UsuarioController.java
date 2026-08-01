package controllers;

import models.Usuario;

import utils.Conexao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import enums.RoleUsuarioEnum;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Statement;

public class UsuarioController {

    public Usuario login(String email, String senha) throws Exception {
        Usuario usuario = null;
        Connection conn = new Conexao().connect();

        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, senha);

            ResultSet result = ps.executeQuery();

            // se nao achar um usuario retorna null
            if (!result.next()) {
                return usuario;
            }

            // se achar retorna ele preenchido como objeto
            usuario = new Usuario(
                    result.getInt("id"),
                    result.getString("nome"),
                    result.getString("email"),
                    result.getString("senha"),
                    result.getString("telefone"),
                    LocalDate.parse(result.getString("data_nascimento")),
                    result.getString("cpf"),
                    RoleUsuarioEnum.valueOf(result.getString("role"))
            );

            return usuario;
        } catch (SQLException e) {
            throw new Exception("Erro ao logar");
        } finally {
            conn.close();
        }
    }

    public int save(
        String nome,
        String email,
        String senha,
        String telefone,
        LocalDate dataNascimento,
        String cpf,
        RoleUsuarioEnum role
    ) throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            INSERT INTO usuarios (nome, email, senha, telefone, data_nascimento, cpf, role)
            VALUES (?, ?, ?, ?, ?, ?, ?);
        """;

        try{
            // preparando comando para inserir na tabela de usuarios um novo usuario
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, nome);
            ps.setString(2, email);
            ps.setString(3, senha);
            ps.setString(4, telefone);
            ps.setString(5, dataNascimento.toString());
            ps.setString(6, cpf);
            ps.setString(7, role.toString());

            ps.executeUpdate();

            ResultSet result = ps.getGeneratedKeys();

            // retorna o id do usuario criado
            return result.getInt(1);
        } catch(SQLException e){
            throw new Exception("Erro ao salvar usuario");
        } finally {
            conn.close();
        }
    }
        
}
