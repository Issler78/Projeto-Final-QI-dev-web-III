package models;

import enums.NivelTurmaEnum;
import enums.SerieTurmaEnum;

public class Turma {
    int id;
    String sala;
    NivelTurmaEnum nivel;
    SerieTurmaEnum serie;

    public Turma(int id, String sala, NivelTurmaEnum nivel, SerieTurmaEnum serie) {
        this.id = id;
        this.sala = sala;
        this.nivel = nivel;
        this.serie = serie;
    }

    public Turma(){}

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
