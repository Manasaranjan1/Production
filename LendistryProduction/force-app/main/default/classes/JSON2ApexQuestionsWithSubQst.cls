public class JSON2ApexQuestionsWithSubQst {
    // Parent Question Wrapper
    public class Questionnaire {
        public Integer questionId;
        public String  questionDesc;
        public String  questionType;
        public Boolean isRequired;
        public String  answer;
        public string  options;
        public Boolean isCustomized;
        public Boolean isSubQuestion;
        public List<SubQuestionnaire > listOfSubQuestion;
        public Questionnaire(){
            isSubQuestion = false;
            listOfSubQuestion = new List<SubQuestionnaire >();
        }
    }
    // child question wrapper
    public class SubQuestionnaire {
        public Integer  parentQuestionId;
        public Integer subQuestionId;
        public String  questionDesc;
        public String  questionType;
        public Boolean isRequired;
        public String  answer;
        public string  options;
        public Boolean isCustomized;
        
        
    } 

    public Integer TenantId;
    public String SalesforceUserID;
    public String LeadId;
    public String OpportunityId;
    public Integer BusinessId;
    public List<Questionnaire> Questionnaire;
    
    public JSON2ApexQuestionsWithSubQst(){
       Questionnaire = new  List<Questionnaire> ();
    }
    
    public static JSON2ApexQuestionsWithSubQst  parse(String json) {
        return (JSON2ApexQuestionsWithSubQst) System.JSON.deserialize(json, JSON2ApexQuestionsWithSubQst.class);
    }
}