/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import java.util.LinkedHashSet;
import utils.Conexao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import models.Disciplina;
import models.Professor;
import models.Usuario;

public class DisciplinaController {
    public LinkedHashSet<Disciplina> getAll() throws Exception {
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT * FROM disciplinas ORDER BY nome ASC;
        """;

        try {
            ResultSet resultado = conn.prepareStatement(sql).executeQuery();

            LinkedHashSet<Disciplina> disciplinas = new LinkedHashSet<>();

            while (resultado.next()) {
                Disciplina disciplina = new Disciplina();

                disciplina.setId(resultado.getInt("id"));
                disciplina.setNome(resultado.getString("nome"));

                disciplinas.add(disciplina);
            }

            return disciplinas;

        } catch (SQLException e) {
            throw new Exception("Erro ao listar disciplinas: " + e);
        } finally {
            conn.close();
        }
    }
    
    public void save(String nome) throws Exception {
        Connection conn = new Conexao().connect();

        String sql = """
            INSERT INTO disciplinas (nome)
            VALUES (?);
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nome);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new Exception("Erro ao criar disciplina: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    public void update(int disciplinaId, String nome) throws Exception {
        // tentar encontrar disciplina antes de editar
        Disciplina disciplina = getById(disciplinaId);
        if(disciplina == null){
            throw new Exception("Disciplina não encontrada");
        }

        Connection conn = new Conexao().connect();

        String sql = """
            UPDATE disciplinas
            SET nome = ?
            WHERE id = ?;
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nome);
            ps.setInt(2, disciplinaId);

            ps.executeUpdate();
        } catch(SQLException e) {
            throw new Exception("Erro ao editar disciplina: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    public boolean delete(int disciplinaId) throws Exception {
        // tentar encontrar disciplina antes de excluir
        Disciplina disciplina = getById(disciplinaId);
        if(disciplina == null){
            throw new Exception("Disciplina não encontrada");
        }

        Connection conn = new Conexao().connect();

        String sql = """
            DELETE FROM disciplinas
            WHERE id = ?;
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, disciplinaId);

            int resultado = ps.executeUpdate();
            
            // retorna quantas linhas afetadas, e retorna true caso for maior q 0
            return resultado > 0 ? true : false;
        } catch(SQLException e) {
            throw new Exception("Erro ao excluir disciplina: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    public Disciplina getById(int id) throws Exception{
        Connection conn = new Conexao().connect();

        String querySql = """
            SELECT * FROM disciplinas WHERE id = ?;
        """;
        try {
            PreparedStatement ps = conn.prepareStatement(querySql);
            ps.setInt(1, id);

            ResultSet resultado = ps.executeQuery();
            Disciplina disciplina = null;
            if (resultado.next()) {
                disciplina = new Disciplina();
                disciplina.setId(resultado.getInt("id"));
                disciplina.setNome(resultado.getString("nome"));
            }

            return disciplina;
        } catch (SQLException e) {
            throw new Exception("Erro ao tentar procurar disciplina: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    public LinkedHashSet<Professor> getAllProfessoresByDisciplina(int disciplinaId) throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT 
                p.id AS id, 
                u.nome AS nome,
                d.id AS disciplina_id
            FROM professor_disciplina pd 
            INNER JOIN disciplinas d
                ON pd.disciplina_id = d.id
            INNER JOIN professores p
                ON pd.professor_id = p.id
            INNER JOIN usuarios u
                ON u.id = p.usuario_id
            WHERE pd.disciplina_id = ?
            ORDER BY nome ASC;
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, disciplinaId);
            
            ResultSet resultado = ps.executeQuery();

            LinkedHashSet<Professor> professores = new LinkedHashSet<>();
            while(resultado.next()){
                Professor professor = new Professor();
                professor.setId(resultado.getInt("id"));
                
                // definindo o usuario do professor (usuario é um objeto no modelo de professor)
                Usuario usuario = new Usuario();
                usuario.setNome(resultado.getString("nome"));
                professor.setUsuario(usuario);
                
                professores.add(professor);
            }

            return professores;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar professores: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
