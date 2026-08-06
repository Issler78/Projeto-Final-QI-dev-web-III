package controllers;

import enums.RoleUsuarioEnum;
import utils.Conexao;
import models.Usuario;
import models.Turma;
import models.Aluno;
import java.util.LinkedHashSet;
import java.sql.ResultSet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.apache.commons.lang3.StringUtils;

public class AlunoController {
    private final UsuarioController usuarioController = new UsuarioController();
    private final TurmaController turmaController = new TurmaController();

    public void save(String nome, String cpf, String telefone, String data_nascimento, int turmaId) throws Exception {
        // preparando alguns valores para serem criados automaticamente

        // string sem acentos
        String nomeFormatado = StringUtils.stripAccents(nome.strip().split(" ")[0].toLowerCase());
        
        // email para o formato: nome + primeiros 3 numeros do cpf + @estudante.com
        String email = nomeFormatado + cpf.trim().substring(0, 3) + "@estudante.com";
        

        // senha para o formato: @nome#datanascimento*
        // data de nascimento no formato ddmmyyyy
        String senha = "@" + nomeFormatado + "#" + LocalDate.parse(data_nascimento).format(DateTimeFormatter.ofPattern("ddMMyyyy")) + "*";



        int novoUsuarioId = usuarioController.save(
                nome,
                email,
                senha,
                telefone,
                LocalDate.parse(data_nascimento),
                cpf,
                RoleUsuarioEnum.ALUNO
        );



        Connection conn = new Conexao().connect();

        String sql = """
            INSERT INTO alunos (usuario_id, turma_id)
            VALUES (?, ?);
        """;

        try {
            // preparando comando para inserir na tabela de alunos um novo aluno
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, novoUsuarioId);
            ps.setInt(2, turmaId);

            ps.executeUpdate();
        } catch(SQLException e){
            throw new Exception("Erro ao salvar aluno: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    public LinkedHashSet<Aluno> getAll() throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT 
                a.id AS id, 
                u.nome AS nome, 
                u.email AS email, 
                u.telefone AS telefone,
                u.cpf AS cpf,
                u.data_nascimento AS data_nascimento,
                t.id AS turma_id, 
                t.sala AS sala
            FROM alunos a 
            INNER JOIN usuarios u 
                ON a.usuario_id = u.id 
            INNER JOIN turmas t 
                ON a.turma_id = t.id
            ORDER BY nome ASC;
        """;

        try {
            ResultSet resultado = conn.prepareStatement(sql).executeQuery();

            LinkedHashSet<Aluno> alunos = new LinkedHashSet<>();
            while(resultado.next()){
                Aluno aluno = new Aluno();
                aluno.setId(resultado.getInt("id"));
                
                // definindo o usuario do aluno (usuario é um objeto no modelo de aluno)
                Usuario usuario = new Usuario();
                usuario.setNome(resultado.getString("nome"));
                usuario.setEmail(resultado.getString("email"));
                usuario.setTelefone(resultado.getString("telefone"));
                usuario.setCpf(resultado.getString("cpf"));
                usuario.setDataNascimento(LocalDate.parse(resultado.getString("data_nascimento")));
                aluno.setUsuario(usuario);
                
                // definindo a turma do aluno (turma é um objeto no modelo de aluno)
                Turma turma = new Turma();
                turma.setSala(resultado.getString("sala"));
                turma.setId(resultado.getInt("turma_id"));
                aluno.setTurma(turma);

                alunos.add(aluno);
            }

            return alunos;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar alunos: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    public LinkedHashSet<Aluno> getAllByQuery(String q) throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT 
                a.id AS id, 
                u.nome AS nome, 
                u.email AS email, 
                u.telefone AS telefone,
                u.cpf AS cpf,
                u.data_nascimento AS data_nascimento,
                t.id AS turma_id, 
                t.sala AS sala
            FROM alunos a 
            INNER JOIN usuarios u 
                ON a.usuario_id = u.id 
            INNER JOIN turmas t 
                ON a.turma_id = t.id
            WHERE nome LIKE ?
            ORDER BY nome ASC;
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + q + "%");
            
            ResultSet resultado = ps.executeQuery();

            LinkedHashSet<Aluno> alunos = new LinkedHashSet<>();
            while(resultado.next()){
                Aluno aluno = new Aluno();
                aluno.setId(resultado.getInt("id"));
                
                // definindo o usuario do aluno (usuario é um objeto no modelo de aluno)
                Usuario usuario = new Usuario();
                usuario.setNome(resultado.getString("nome"));
                usuario.setEmail(resultado.getString("email"));
                usuario.setTelefone(resultado.getString("telefone"));
                usuario.setCpf(resultado.getString("cpf"));
                usuario.setDataNascimento(LocalDate.parse(resultado.getString("data_nascimento")));
                aluno.setUsuario(usuario);
                
                // definindo a turma do aluno (turma é um objeto no modelo de aluno)
                Turma turma = new Turma();
                turma.setSala(resultado.getString("sala"));
                turma.setId(resultado.getInt("turma_id"));
                aluno.setTurma(turma);

                alunos.add(aluno);
            }

            return alunos;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar alunos: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
            
    
    public void update(int alunoId, String nome, String cpf, String telefone, String dataNascimento, int turmaId) throws Exception{
        // tentar encontrar aluno antes de editar
        Aluno aluno = getById(alunoId);
        if(aluno == null){
            throw new Exception("Aluno não encontrado");
        }
        
        
        
        // EDITAR USUARIO ANTES
        
        // preparando alguns valores para serem criados automaticamente

        // string sem acentos
        String nomeFormatado = StringUtils.stripAccents(nome.strip().split(" ")[0].toLowerCase());
        // email para o formato: nome + primeiros 3 numeros do cpf + @estudante.com
        String email = nomeFormatado + cpf.trim().substring(0, 3) + "@estudante.com";

        // senha para o formato: @nome#datanascimento*
        // data de nascimento no formato ddmmyyyy
        String senha = "@" + nomeFormatado + "#" + LocalDate.parse(dataNascimento).format(DateTimeFormatter.ofPattern("ddMMyyyy")) + "*";
        

        
        // editar usuario
        usuarioController.update(
                aluno.getUsuario().getId(),
                nome,
                email,
                senha,
                telefone,
                LocalDate.parse(dataNascimento),
                cpf
        );
        
        
        
        Connection conn = new Conexao().connect();
        
        String sql = """
            UPDATE alunos 
            SET turma_id = ?
            WHERE id = ?;
        """;
        try{
            // preparando comando para editar na tabela de alunos
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, turmaId);
            ps.setInt(2, alunoId);

            ps.executeUpdate();
        } catch (SQLException e){
            throw new Exception("Erro ao editar aluno: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    public boolean delete(int id) throws Exception{
        Connection conn = new Conexao().connect();
        
        // tentar encontrar aluno antes de excluir
        Aluno aluno = getById(id);
        if(aluno == null){
            throw new Exception("Aluno não encontrado");
        }
        
        
        
        String deleteSql = """
            DELETE FROM alunos WHERE id = ?;
        """;
        try {
            PreparedStatement ps = conn.prepareStatement(deleteSql);
            ps.setInt(1, id);
            
            int linhasDeletadas = ps.executeUpdate();
            // se deletou aluno, deletar tambem usuario
            if(linhasDeletadas > 0){
                
                // se deletar com sucesso o usuario, retorna true
                return usuarioController.delete(aluno.getUsuario().getId(), conn);
            }
            
            return false;
        } catch (SQLException e){
            throw new Exception("Erro ao excluir aluno: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
    
    
    
    public Aluno getById(int id) throws Exception{
        Connection conn = new Conexao().connect();
        
        String querySql = """
            SELECT * FROM alunos WHERE id = ?;
        """;
        
        try{
            PreparedStatement ps = conn.prepareStatement(querySql);
            ps.setInt(1, id);
            
            ResultSet resultado = ps.executeQuery();
            Aluno aluno = null;
            if(resultado.next()){
                aluno = new Aluno();
                aluno.setId(resultado.getInt("id"));
                aluno.setUsuario(usuarioController.getById(resultado.getInt("usuario_id")));
                aluno.setTurma(turmaController.getById(resultado.getInt("turma_id")));
            }
            
            return aluno;
        } catch (SQLException e){
            throw new Exception("Erro ao tentar procurar Aluno: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
