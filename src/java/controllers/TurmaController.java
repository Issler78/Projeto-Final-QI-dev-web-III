package controllers;

import models.Turma;
import utils.Conexao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.Set;

public class TurmaController {
    public Set<Turma> getAll() throws Exception {
        Connection conn = new Conexao().connect();

        String sql = """
            SELECT * FROM turmas ORDER BY sala ASC;
        """;

        try {
            ResultSet result = conn.prepareStatement(sql).executeQuery();

            Set<Turma> turmas = new LinkedHashSet<>();
            while(result.next()){
                Turma turma = new Turma();
                turma.setId(result.getInt("id"));
                turma.setSala(result.getString("sala"));
                turma.setSerie(result.getString("serie"));

                turmas.add(turma);
            }

            return turmas;
        } catch (SQLException e) {
            throw new Exception("Erro ao listar turmas: " + e);
        }
    }
}
