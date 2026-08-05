package models;

public class Professor {
    int id;
    Usuario usuario;

    public Professor() {}

    public Professor(int id, Usuario usuario, Turma turma) {
        this.id = id;
        this.usuario = usuario;
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
