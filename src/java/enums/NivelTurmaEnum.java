package enums;

public enum NivelTurmaEnum {
    FUNDAMENTAL("Fundamental"),
    MEDIO("Médio");
    
    private final String valor;
    
    NivelTurmaEnum(String valor){
        this.valor = valor;
    }
    
    public String getvalor(){
        return valor;
    }
    
    public static NivelTurmaEnum fromValor(String valor) throws Exception{
        for(NivelTurmaEnum nivel : values()){
            if(nivel.valor.equals(valor)){
                return nivel;
            }
        }
        
        throw new Exception("Nível de ensino inválido");
    }
}
