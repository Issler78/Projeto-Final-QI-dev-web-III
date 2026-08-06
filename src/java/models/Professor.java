package models;

import java.util.LinkedHashSet;
import java.util.Set;

public class Professor {
    int id;
    Usuario usuario;
    Set<Disciplina> disciplinas;

    public Professor() {
        this.disciplinas = new LinkedHashSet<>();
    }

    public Professor(int id, Usuario usuario, Turma turma) {
        this.id = id;
        this.usuario = usuario;
        this.disciplinas = new LinkedHashSet<>();
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
    
    public Set<Disciplina> getDisciplinas() {
        return disciplinas;
    }

    public void setDisciplinas(Set<Disciplina> disciplinas) {
        this.disciplinas = disciplinas;
    }
}
