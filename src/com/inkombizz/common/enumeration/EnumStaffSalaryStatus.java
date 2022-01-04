/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author niko
 */
public class EnumStaffSalaryStatus {
    public enum ENUM_StaffSalaryStatus{
        B,
        H
    }
    
    public static String toString(EnumStaffSalaryStatus.ENUM_StaffSalaryStatus enumStaffSalaryStatus){
        String rValue = "Harian";
        
        if (enumStaffSalaryStatus == EnumStaffSalaryStatus.ENUM_StaffSalaryStatus.B)
            rValue = "Bulanan";
        
        return rValue;
    }
}
