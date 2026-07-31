package controllers;

import models.Usuario;

import utils.Conexao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import enums.RoleUsuarioEnum;
import java.sql.SQLException;
import java.time.LocalDate;

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
        } catch(SQLException e){
            throw new Exception("Erro ao logar");
        } finally {
            conn.close();
        }
    }
}
