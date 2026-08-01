package controllers;

import enums.RoleUsuarioEnum;
import utils.Conexao;
import models.Usuario;
import models.Turma;
import models.Aluno;
import java.util.LinkedHashSet;
import java.util.Set;
import java.sql.ResultSet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class AlunoController {
    private final UsuarioController usuarioController = new UsuarioController();

    void save(String nome, String cpf, String telefone, String data_nascimento, int turma_id) throws Exception {
        // preparando alguns valores para serem criados automaticamente

        // email para o formato: nome + primeiros 3 numeros do cpf + @estudante.com
        String email = nome.strip().split(" ")[0].toLowerCase() + cpf.substring(0, 2) + "@estudante.com";

        // senha para o formato: @nome#datanascimento*
        // data de nascimento no formato ddmmyyyy
        String senha = "@" + nome.strip().split(" ")[0].toLowerCase() + "#" + LocalDate.parse(data_nascimento, DateTimeFormatter.ofPattern("ddMMyyyy")) + "*";



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
            ps.setInt(2, turma_id);

            ps.executeUpdate();
        } catch(SQLException e){
            throw new Exception("Erro ao salvar aluno");
        } finally {
            conn.close();
        }
    }
    
    public Set<Aluno> getAll() throws Exception{
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT 
                     a.id AS id, 
                     u.nome AS nome, 
                     u.email AS email, 
                     u.telefone AS telefone, 
                     t.sala AS turma 
                     FROM alunos a 
                     INNER JOIN usuarios u 
                        ON a.usuario_id = u.id 
                     INNER JOIN turmas t 
                        ON a.turma_id = t.id;
        """;

        try {
            ResultSet result = conn.prepareStatement(sql).executeQuery();

            Set<Aluno> alunos = new LinkedHashSet<>();
            while(result.next()){
                Aluno aluno = new Aluno();
                aluno.setId(result.getInt("id"));
                
                // definindo o usuario do aluno (usuario é um objeto no modelo de aluno)
                Usuario usuario = new Usuario();
                usuario.setNome(result.getString("nome"));
                usuario.setEmail(result.getString("email"));
                usuario.setTelefone(result.getString("telefone"));
                aluno.setUsuario(usuario);
                
                // definindo a turma do aluno (turma é um objeto no modelo de aluno)
                Turma turma = new Turma();
                turma.setSala(result.getString("turma"));
                aluno.setTurma(turma);

                alunos.add(aluno);
            }

            return alunos;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar turmas: " + e);
        } finally {
            conn.close();
        }
    }
}
