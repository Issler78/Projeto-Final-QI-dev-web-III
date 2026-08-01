package models;

public class Turma {
    int id;
    String sala;
    String serie;

    public Turma(int id, String sala, String serie) {
        this.id = id;
        this.sala = sala;
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

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }
}
