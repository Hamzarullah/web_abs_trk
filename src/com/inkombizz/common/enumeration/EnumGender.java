/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author niko
 */
public class EnumGender {
    public enum ENUM_Gender{
        Male,
        Female
    }
    
    public static String toString(EnumGender.ENUM_Gender enumGender){
        String rValue = "Male";
        
        if (enumGender == EnumGender.ENUM_Gender.Female)
            rValue = "Female";
        
        return rValue;
    }
}
