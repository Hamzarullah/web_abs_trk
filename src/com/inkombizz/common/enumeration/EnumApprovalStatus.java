package com.inkombizz.common.enumeration;

public class EnumApprovalStatus {
    public enum ENUM_ApprovalStatus{
        CHECKED, 
        UNCHECKED,
        REJECTED,
        APPROVED,
        PENDING,
        CONFIRMED,
        ALL
    }
    
    public static String toString(ENUM_ApprovalStatus enumApprovalStatus) {
        String rValue = "";
        
        if(ENUM_ApprovalStatus.CHECKED == enumApprovalStatus) {
            rValue = "Checked";
        }
        
        else if(ENUM_ApprovalStatus.UNCHECKED == enumApprovalStatus) {
            rValue = "Unchecked";
        }
        
        else if(ENUM_ApprovalStatus.REJECTED == enumApprovalStatus) {
            rValue = "Rejected";
        }
        
        else if(ENUM_ApprovalStatus.APPROVED == enumApprovalStatus) {
            rValue = "Approved";
        }
        
        else if(ENUM_ApprovalStatus.PENDING == enumApprovalStatus) {
            rValue = "Pending";
        }
        
        else if(ENUM_ApprovalStatus.CONFIRMED == enumApprovalStatus) {
            rValue = "Confirmed";
        }
                
        else if(ENUM_ApprovalStatus.ALL == enumApprovalStatus) {
            rValue = "All";
        }
        
        return rValue;
    }
    
    
}
