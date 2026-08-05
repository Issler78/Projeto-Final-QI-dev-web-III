package controllers;

import enums.NivelTurmaEnum;
import enums.SerieTurmaEnum;
import models.Turma;
import utils.Conexao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.LinkedHashSet;

public class TurmaController {

    public LinkedHashSet<Turma> getAll() throws Exception {
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT * FROM turmas ORDER BY sala ASC;
        """;

        try {
            ResultSet result = conn.prepareStatement(sql).executeQuery();

            LinkedHashSet<Turma> turmas = new LinkedHashSet<>();
            while (result.next()) {
                Turma turma = new Turma();
                turma.setId(result.getInt("id"));
                turma.setSala(result.getString("sala"));
                turma.setNivel(NivelTurmaEnum.fromValor(result.getString("nivel")));
                turma.setSerie(SerieTurmaEnum.fromValor(result.getString("serie")));

                turmas.add(turma);
            }

            return turmas;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar turmas: " + e);
        } finally {
            conn.close();
        }
    }

    public Turma getById(int id) throws Exception {
        Connection conn = new Conexao().connect();

        String querySql = """
            SELECT * FROM turmas WHERE id = ?;
        """;
        try {
            PreparedStatement ps = conn.prepareStatement(querySql);
            ps.setInt(1, id);

            ResultSet resultado = ps.executeQuery();
            Turma turma = null;
            if (resultado.next()) {
                turma = new Turma();
                turma.setId(resultado.getInt("id"));
                turma.setNivel(NivelTurmaEnum.fromValor(resultado.getString("nivel")));
                turma.setSala(resultado.getString("sala"));
                turma.setSerie(SerieTurmaEnum.fromValor(resultado.getString("serie")));
            }

            return turma;
        } catch (SQLException e) {
            throw new Exception("Erro ao tentar procurar turma: " + e.getMessage());
        } finally {
            conn.close();
        }
    }

    public void save(String sala, NivelTurmaEnum nivel, SerieTurmaEnum serie) throws Exception {
        Connection conn = new Conexao().connect();

        String sql = """
            INSERT INTO turmas (sala, nivel, serie)
            VALUES (?, ?, ?);
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, sala);
            ps.setString(2, nivel.getvalor());
            ps.setString(3, serie.getvalor());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new Exception("erro ao salvar turma: " + e.getMessage());
        } finally {
            conn.close();
        }
    }

    public void update(int turmaId, String sala, NivelTurmaEnum nivel, SerieTurmaEnum serie) throws Exception {
        // tentar encontrar turma antes de editar
        Turma turma = getById(turmaId);
        if(turma == null){
            throw new Exception("Turma não encontrada");
        }

        Connection conn = new Conexao().connect();

        String sql = """
            UPDATE turmas
            SET sala = ?,
                nivel = ?,
                serie = ?
            WHERE id = ?;
        """;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, sala);
            ps.setString(2, nivel.getvalor());
            ps.setString(3, serie.getvalor());
            ps.setInt(4, turmaId);

            ps.executeUpdate();

        } catch(SQLException e) {
            throw new Exception("Erro ao editar turma: " + e.getMessage());
        } finally {
            conn.close();
        }
    }

    public boolean delete(int turmaId) throws Exception {
        Connection conn = new Conexao().connect();

        // tentar encontrar turma antes de excluir
        Turma turma = getById(turmaId);
        if (turma == null) {
            throw new Exception("Turma não encontrada");
        }

        // verifica se existe alunos naquela turma (nao excluir se existe
        String sql = """
            SELECT COUNT(*)
            FROM alunos
            WHERE turma_id = ?;
        """;

        PreparedStatement ps1 = conn.prepareStatement(sql);
        ps1.setInt(1, turmaId);
        ResultSet resultado1 = ps1.executeQuery();

        if (resultado1.next() && resultado1.getInt(1) > 0) {
            return false;
        }

        String deleteSql = """
            DELETE FROM turmas WHERE id = ?;
        """;

        try {
            PreparedStatement ps2 = conn.prepareStatement(deleteSql);
            ps2.setInt(1, turmaId);

            int resultado2 = ps2.executeUpdate();

            // retorna quantas linhas afetadas, e retorna true caso for maior q 0
            return resultado2 > 0 ? true : false;

        } catch (SQLException e) {
            throw new Exception("Erro ao excluir turma: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
