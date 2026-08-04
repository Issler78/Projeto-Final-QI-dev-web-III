package controllers;

import models.Usuario;

import utils.Conexao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import enums.RoleUsuarioEnum;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Date;
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

        // validando se existe usuarios cadastrados com o mesmo cpf ou mesmo telefone
        // passando -1, a validacao de verificar um usuario diferente, sempre vai passar por nao existir um usuario de id -1
        String erro = validate(-1, cpf, telefone, conn);
        if(erro != null){
            throw new Exception(erro);
        }
        
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
            ps.setDate(5, Date.valueOf(dataNascimento));
            ps.setString(6, cpf);
            ps.setString(7, role.toString());

            ps.executeUpdate();

            ResultSet result = ps.getGeneratedKeys();

            // retorna o id do usuario criado
            int id = 0;
            while(result.next()){
                id = result.getInt(1);
            }
            return id;
        } catch(SQLException e){
            throw new Exception("Erro ao salvar usuario: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    public void update(
        int usuarioId,
        String nome,
        String email,
        String senha,
        String telefone,
        LocalDate dataNascimento,
        String cpf
    ) throws Exception{
        Connection conn = new Conexao().connect();
        
        // procurar se existe usuario antes de editar
        Usuario usuario = getById(usuarioId);
        if(usuario == null){
            throw new Exception("Usuário não encontrado");
        }

        // validando se existe usuarios cadastrados com o mesmo cpf ou mesmo telefone
        String erro = validate(usuarioId, cpf, telefone, conn);
        if(erro != null){
            throw new Exception(erro);
        }
        
        
        
        String sql = """
            UPDATE usuarios 
            SET nome = ?, email = ?, senha = ?, telefone = ?, data_nascimento = ?, cpf = ?
            WHERE id = ?;
        """;
        try{
            // preparando comando para editar na tabela de usuarios
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nome);
            ps.setString(2, email);
            ps.setString(3, senha);
            ps.setString(4, telefone);
            ps.setDate(5, Date.valueOf(dataNascimento));
            ps.setString(6, cpf);
            ps.setInt(7, usuarioId);

            ps.executeUpdate();
            
        } catch(SQLException e){
            throw new Exception("Erro ao salvar usuario: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    private String validate(int usuarioId, String cpf, String telefone, Connection conn) throws Exception{
        String sql = """
            SELECT id, cpf, telefone FROM usuarios 
            WHERE (cpf = ? OR telefone = ?) AND id != ?;
        """;
        
        String mensagem = null;
        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cpf);
            ps.setString(2, telefone);
            ps.setInt(3, usuarioId);
            
            ResultSet result = ps.executeQuery();
            
            if(result.next()){
                if(cpf.equals(result.getString("cpf"))){
                    mensagem = "Esse CPF já está cadastrado.";
                }
                if(telefone.equals(result.getString("telefone"))){
                    mensagem = "Esse telefone já está cadastrado.";
                }
            }
        } catch (SQLException e) {
            throw new Exception("Erro: " + e.getMessage());
        }
        
        return mensagem;
    }
    
    
    
    public boolean delete(int id, Connection conn) throws Exception{
        Usuario usuario = getById(id);
        if(usuario == null){
            throw new Exception("Usuário não encontrado");
        }
        
        String sql = """
            DELETE FROM usuarios WHERE id = ?;             
        """;
        
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            
            int linhasDeletadas = ps.executeUpdate();
            if(linhasDeletadas > 0){
                return true;
            }
            
            return false;
        } catch (SQLException e){
            throw new Exception("Erro ao excluir usuário: " + e.getMessage());
        }
    }
    
    
    
    public Usuario getById(int id) throws Exception{
        Connection conn = new Conexao().connect();
        
        String querySql = """
            SELECT * FROM usuarios WHERE id = ?;
        """;
        try{
            PreparedStatement ps = conn.prepareStatement(querySql);
            ps.setInt(1, id);
            
            ResultSet resultado = ps.executeQuery();
            Usuario usuario = null;
            if(resultado.next()){
                usuario = new Usuario();
                usuario.setId(resultado.getInt("id"));
                usuario.setNome(resultado.getString("nome"));
                usuario.setEmail(resultado.getString("email"));
                usuario.setSenha(resultado.getString("senha"));
                usuario.setTelefone(resultado.getString("telefone"));
                usuario.setDataNascimento(LocalDate.parse(resultado.getString("data_nascimento")));
                usuario.setCpf(resultado.getString("cpf"));
                usuario.setRole(RoleUsuarioEnum.valueOf(resultado.getString("role")));
            }
            
            return usuario;
        } catch (SQLException e){
            throw new Exception("Erro ao tentar procurar usuário: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
