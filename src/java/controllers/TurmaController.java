package controllers;

import enums.NivelTurmaEnum;
import enums.SerieTurmaEnum;
import models.Turma;
import utils.Conexao;

import java.sql.Connection;
import java.sql.ResultSet;
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
            while(result.next()){
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
}
