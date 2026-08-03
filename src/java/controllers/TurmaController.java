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
    
    public Turma getById(int id) throws Exception{
        Connection conn = new Conexao().connect();
        
        String querySql = """
            SELECT * FROM turmas WHERE id = ?;
        """;
        try{
            PreparedStatement ps = conn.prepareStatement(querySql);
            ps.setInt(1, id);
            
            ResultSet resultado = ps.executeQuery();
            Turma turma = null;
            if(resultado.next()){
                turma = new Turma();
                turma.setId(resultado.getInt("id"));
                turma.setNivel(NivelTurmaEnum.fromValor(resultado.getString("nivel")));
                turma.setSala(resultado.getString("sala"));
                turma.setSerie(SerieTurmaEnum.fromValor(resultado.getString("serie")));
            }
            
            return turma;
        } catch (SQLException e){
            throw new Exception("Erro ao tentar procurar turma: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
