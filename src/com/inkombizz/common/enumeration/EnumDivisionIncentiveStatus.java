/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author niko
 */
public class EnumDivisionIncentiveStatus {
    public enum ENUM_DivisionIncentiveStatus{
        Proposional,
        Full
    }
    
    public static String toString(EnumDivisionIncentiveStatus.ENUM_DivisionIncentiveStatus enumDivisionIncentiveStatus){
        String rValue = "Proposional";
        
        if (enumDivisionIncentiveStatus == EnumDivisionIncentiveStatus.ENUM_DivisionIncentiveStatus.Full)
            rValue = "Full";
        
        return rValue;
    }
}
