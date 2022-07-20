public class JSON2ApexPersona {


    public String personaStatus;
    public String LeadId;

    
    public static JSON2ApexPersona parse(String json) {
        return (JSON2ApexPersona) System.JSON.deserialize(json, JSON2ApexPersona.class);
    }
}