/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author niko
 */
public class EnumItemTypeIncentiveStatus {
    public enum ENUM_ItemTypeIncentiveStatus{
        Proposional,
        Full
    }
    
    public static String toString(EnumItemTypeIncentiveStatus.ENUM_ItemTypeIncentiveStatus enumItemTypeIncentiveStatus){
        String rValue = "Proposional";
        
        if (enumItemTypeIncentiveStatus == EnumItemTypeIncentiveStatus.ENUM_ItemTypeIncentiveStatus.Full)
            rValue = "Full";
        
        return rValue;
    }
}
