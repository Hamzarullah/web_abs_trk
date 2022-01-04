/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author jason
 */
public class EnumClosingStatus {
 
    public enum ENUM_ClosingStatus{
        OPEN, 
        CLOSED,
        ALL
    }
    
    public static String toString(ENUM_ClosingStatus enumClosingStatus) {
        String rValue = "";
        
        if(ENUM_ClosingStatus.OPEN == enumClosingStatus) {
            rValue = "Open";
        }
        
        else if(ENUM_ClosingStatus.CLOSED == enumClosingStatus) {
            rValue = "Closed";
        }
        
        else if(ENUM_ClosingStatus.ALL == enumClosingStatus) {
            rValue = "All";
        }
        
        return rValue;
    }
    
}
