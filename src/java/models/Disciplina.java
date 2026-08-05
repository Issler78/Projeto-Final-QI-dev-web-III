package models;

public class Disciplina {
    int id;
    String nome;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Disciplina(int id, String nome) {
        this.id = id;
        this.nome = nome;
    }
    
    public Disciplina(){}

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
    
}
