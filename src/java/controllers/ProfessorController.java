package controllers;

import enums.RoleUsuarioEnum;
import java.time.LocalDate;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import java.time.format.DateTimeFormatter;
import utils.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.LinkedHashSet;
import models.Disciplina;
import models.Professor;
import models.Usuario;

public class ProfessorController {
    private final UsuarioController usuarioController = new UsuarioController();
    
    public LinkedHashSet<Professor> getAll() throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT 
                p.id AS id, 
                u.nome AS nome, 
                u.email AS email, 
                u.telefone AS telefone,
                u.cpf AS cpf,
                u.data_nascimento AS data_nascimento
            FROM professores p 
            INNER JOIN usuarios u 
                ON p.usuario_id = u.id 
            ORDER BY nome ASC;
        """;

        try {
            ResultSet resultado = conn.prepareStatement(sql).executeQuery();

            LinkedHashSet<Professor> professores = new LinkedHashSet<>();
            while(resultado.next()){
                Professor professor = new Professor();
                professor.setId(resultado.getInt("id"));
                
                LinkedHashSet<Disciplina> disciplinas = getAllDisciplinasByProfessorId(professor.getId());
                professor.setDisciplinas(disciplinas);
                
                // definindo o usuario do professor (usuario é um objeto no modelo de professor)
                Usuario usuario = new Usuario();
                usuario.setNome(resultado.getString("nome"));
                usuario.setEmail(resultado.getString("email"));
                usuario.setTelefone(resultado.getString("telefone"));
                usuario.setCpf(resultado.getString("cpf"));
                usuario.setDataNascimento(LocalDate.parse(resultado.getString("data_nascimento")));
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
    
    
    
    public LinkedHashSet<Professor> getAllByQuery(String q) throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT 
                p.id AS id, 
                u.nome AS nome, 
                u.email AS email, 
                u.telefone AS telefone,
                u.cpf AS cpf,
                u.data_nascimento AS data_nascimento
            FROM professores p 
            INNER JOIN usuarios u 
                ON p.usuario_id = u.id 
            WHERE nome LIKE ?
            ORDER BY nome ASC;
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + q + "%");
            
            ResultSet resultado = ps.executeQuery();

            LinkedHashSet<Professor> professores = new LinkedHashSet<>();
            while(resultado.next()){
                Professor professor = new Professor();
                professor.setId(resultado.getInt("id"));
                
                LinkedHashSet<Disciplina> disciplinas = getAllDisciplinasByProfessorId(professor.getId());
                professor.setDisciplinas(disciplinas);
                
                // definindo o usuario do professor (usuario é um objeto no modelo de professor)
                Usuario usuario = new Usuario();
                usuario.setNome(resultado.getString("nome"));
                usuario.setEmail(resultado.getString("email"));
                usuario.setTelefone(resultado.getString("telefone"));
                usuario.setCpf(resultado.getString("cpf"));
                usuario.setDataNascimento(LocalDate.parse(resultado.getString("data_nascimento")));
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
    
    public LinkedHashSet<Disciplina> getAllDisciplinasByProfessorId(int professorId) throws Exception {
        Connection conn = new Conexao().connect();
        
        String sql = """
            SELECT
                d.id AS id,
                d.nome AS disciplina
            FROM professor_disciplina pd
            INNER JOIN disciplinas d
                ON d.id = pd.disciplina_id
            WHERE pd.professor_id = ?
            ORDER BY disciplina ASC;
        """;
        
        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, professorId);
            
            ResultSet resultado = ps.executeQuery();
            LinkedHashSet<Disciplina> disciplinas = new LinkedHashSet<>();
            while(resultado.next()){
                Disciplina disciplina = new Disciplina();
                disciplina.setId(resultado.getInt("id"));
                disciplina.setNome(resultado.getString("disciplina"));
                disciplinas.add(disciplina);
            }
            
            return disciplinas;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar disciplinas: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    public void save(String nome, String cpf, String telefone, String dataNascimento, Set<Integer> disciplinasIds) throws Exception {
        // preparando alguns valores para serem criados automaticamente

        // string sem acentos
        String nomeFormatado = StringUtils.stripAccents(nome.strip().split(" ")[0].toLowerCase());
        
        // email para o formato: nome + primeiros 3 numeros do cpf + @estudante.com
        String email = nomeFormatado + cpf.trim().substring(0, 3) + "@professor.com";
        

        // senha para o formato: @nome#datanascimento*
        // data de nascimento no formato ddmmyyyy
        String senha = "@" + nomeFormatado + "#" + LocalDate.parse(dataNascimento).format(DateTimeFormatter.ofPattern("ddMMyyyy")) + "*";



        int novoUsuarioId = usuarioController.save(
                nome,
                email,
                senha,
                telefone,
                LocalDate.parse(dataNascimento),
                cpf,
                RoleUsuarioEnum.PROFESSOR
        );



        Connection conn = new Conexao().connect();

        String sql = """
            INSERT INTO professores (usuario_id)
            VALUES (?);
        """;

        try {
            // preparando comando para inserir na tabela de professores um novo professor
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, novoUsuarioId);
            
            ps.executeUpdate();
            ResultSet resultado = ps.getGeneratedKeys();
            
            // id do professor criado
            int professorId = 0;
            while(resultado.next()){
                professorId = resultado.getInt(1);
            }
            
            // salvar materias relacionadas a este professor
            insertDisciplinas(professorId, disciplinasIds, conn);
            
        } catch(SQLException e){
            throw new Exception("Erro ao salvar professor: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    private void insertDisciplinas(int professorId, Set<Integer> disciplinasIds, Connection conn) throws Exception{
         String sql = """
                INSERT INTO professor_disciplina (professor_id, disciplina_id)
                VALUES (?, ?);
            """;
        
        // para cada materia, salvar na tabela de relacao com professor
        for(int disciplinaId : disciplinasIds){           
            try{
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, professorId);
                ps.setInt(2, disciplinaId);
                
                ps.executeUpdate();
            } catch(SQLException e){
                throw new Exception("Erro ao salvar professor: " + e.getMessage());
            }
        }
    }
    
    
    
    public void update(int professorId, String nome, String cpf, String telefone, String dataNascimento, Set<Integer> disciplinasIds) throws Exception{
        // tentar encontrar aluno antes de editar
        Professor professor = getById(professorId);
        if(professor == null){
            throw new Exception("Professor não encontrado");
        }
        
        
        
        // EDITAR USUARIO ANTES
        
        // preparando alguns valores para serem criados automaticamente

        // string sem acentos
        String nomeFormatado = StringUtils.stripAccents(nome.strip().split(" ")[0].toLowerCase());
        // email para o formato: nome + primeiros 3 numeros do cpf + @estudante.com
        String email = nomeFormatado + cpf.trim().substring(0, 3) + "@professor.com";

        // senha para o formato: @nome#datanascimento*
        // data de nascimento no formato ddmmyyyy
        String senha = "@" + nomeFormatado + "#" + LocalDate.parse(dataNascimento).format(DateTimeFormatter.ofPattern("ddMMyyyy")) + "*";
        

        
        // editar usuario
        usuarioController.update(
                professor.getUsuario().getId(),
                nome,
                email,
                senha,
                telefone,
                LocalDate.parse(dataNascimento),
                cpf
        );
        
        
        
        Connection conn = new Conexao().connect();
        
        try{
            // editar na tabela de professores com disciplinas
            updateDisciplinas(professorId, disciplinasIds, conn);
            
        } catch (SQLException e){
            throw new Exception("Erro ao editar professor: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    private void updateDisciplinas(int professorId, Set<Integer> disciplinasIds, Connection conn) throws Exception{
        // deletar todas as disciplinas relacionadas ao professor
        try{
            String deleteSql = """
                DELETE FROM professor_disciplina WHERE professor_id = ?;
            """;
            
            PreparedStatement ps = conn.prepareStatement(deleteSql);
            ps.setInt(1, professorId);

            ps.executeUpdate();
        } catch(SQLException e){
            throw new Exception("Erro ao excluir materias: " + e.getMessage());
        }
        
        // funcao para inserir dnv
        insertDisciplinas(professorId, disciplinasIds, conn);
    }
    
    
    
    
    public boolean delete(int id) throws Exception{
        Connection conn = new Conexao().connect();
        
        // tentar encontrar professor antes de excluir
        Professor professor = getById(id);
        if(professor == null){
            throw new Exception("Professor não encontrado");
        }
        
        
        
        String deleteSql = """
            DELETE FROM professores WHERE id = ?;
        """;
        try {
            PreparedStatement ps = conn.prepareStatement(deleteSql);
            ps.setInt(1, id);
            
            int linhasDeletadas = ps.executeUpdate();
            
            // se deletou aluno, deletar tambem usuario
            if(linhasDeletadas > 0){
                // se deletar com sucesso o usuario, retorna true
                return usuarioController.delete(professor.getUsuario().getId(), conn);
            }
            
            return false;
        } catch (SQLException e){
            throw new Exception("Erro ao excluir professor: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    public Professor getById(int id) throws Exception{
        Connection conn = new Conexao().connect();
        
        String querySql = """
            SELECT * FROM professores WHERE id = ?;
        """;
        
        try{
            PreparedStatement ps = conn.prepareStatement(querySql);
            ps.setInt(1, id);
            
            ResultSet resultado = ps.executeQuery();
            Professor professor = null;
            if(resultado.next()){
                professor = new Professor();
                professor.setId(resultado.getInt("id"));
                professor.setUsuario(usuarioController.getById(resultado.getInt("usuario_id")));
            }
            
            return professor;
        } catch (SQLException e){
            throw new Exception("Erro ao tentar procurar professor: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
