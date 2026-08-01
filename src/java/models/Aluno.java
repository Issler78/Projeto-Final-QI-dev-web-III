package models;

public class Aluno {
    int id;
    Usuario usuario;
    Turma turma;

    public Aluno() {}

    public Aluno(int id, Usuario usuario, Turma turma) {
        this.id = id;
        this.usuario = usuario;
        this.turma = turma;
    }

    public Turma getTurma() {
        return turma;
    }

    public void setTurma(Turma turma) {
        this.turma = turma;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
