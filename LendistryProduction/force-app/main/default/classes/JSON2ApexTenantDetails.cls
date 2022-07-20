public class JSON2ApexTenantDetails {

    public Integer Tenant_ID;
    public String Referral_Partner;
    public String Tenant_Name;
    public String Tenant_URL;
     public String Tenant_recordId;
    
    public static JSON2ApexTenantDetails parse(String json) {
        return (JSON2ApexTenantDetails ) System.JSON.deserialize(json, JSON2ApexTenantDetails.class);
    }
}