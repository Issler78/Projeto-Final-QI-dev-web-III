package models;

import enums.NivelTurmaEnum;
import enums.SerieTurmaEnum;
import java.util.LinkedHashSet;
import java.util.Set;

public class Turma {
    int id;
    String sala;
    NivelTurmaEnum nivel;
    SerieTurmaEnum serie;
    int quantidadeAlunos;

    public Turma(int id, String sala, NivelTurmaEnum nivel, SerieTurmaEnum serie, int quantidadeAlunos) {
        this.id = id;
        this.sala = sala;
        this.nivel = nivel;
        this.serie = serie;
        this.quantidadeAlunos = quantidadeAlunos;
    }

    public Turma(){}
    
    public int getQuantidadeAlunos() {
        return quantidadeAlunos;
    }

    public void setQuantidadeAlunos(int quantidadeAlunos) {
        this.quantidadeAlunos = quantidadeAlunos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSala() {
        return sala;
    }

    public void setSala(String sala) {
        this.sala = sala;
    }
    
    public NivelTurmaEnum getNivel() {
        return nivel;
    }

    public void setNivel(NivelTurmaEnum nivel) {
        this.nivel = nivel;
    }

    public SerieTurmaEnum getSerie() {
        return serie;
    }

    public void setSerie(SerieTurmaEnum serie) {
        this.serie = serie;
    }
}
