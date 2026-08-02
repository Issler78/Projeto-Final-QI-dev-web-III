package enums;

public enum SerieTurmaEnum {
    PRIMEIRA("1ª Série"),
    SEGUNDA("2ª Série"),
    TERCEIRA("3ª Série"),
    QUARTA("4ª Série"),
    QUINTA("5ª Série"),
    SEXTA("6ª Série"),
    SETIMA("7ª Série"),
    OITAVA("8ª Série"),
    NONA("9ª Série");
    
    private final String valor;
    
    SerieTurmaEnum(String valor){
        this.valor = valor;
    }
    
    public String getvalor(){
        return valor;
    }
    
    public static SerieTurmaEnum fromValor(String valor) throws Exception{
        for(SerieTurmaEnum serie : values()){
            if(serie.valor.equals(valor)){
                return serie;
            }
        }
        
        throw new Exception("Série inválida");
    }
}
