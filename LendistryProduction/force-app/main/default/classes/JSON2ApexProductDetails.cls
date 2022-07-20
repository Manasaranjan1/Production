public class JSON2ApexProductDetails {

    public Integer TenantId;
    public Integer ProductId;
    public String BusinessCategory;
    public String BusinessType;
    public String ProductName;
    public String ProductRecordId;
    public boolean IsGrant;
    public static JSON2ApexProductDetails parse(String json) {
        return (JSON2ApexProductDetails ) System.JSON.deserialize(json, JSON2ApexProductDetails.class);
    }
}