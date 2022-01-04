
package com.inkombizz.common.enumeration;


public class EnumActivity {
    
    public enum ENUM_Activity{
        NEW,
        UPDATE,
        DELETE,
        REVISE,
        CLONE,
        VERIFIED,
        PROCESSED,
        RELEASED,
        RECEIVED,
        APPROVED,
        REQUESTED,
        PARTIAL,
        GRANTED,
        DECLINED, //Purchase Request yang Rejected
        REJECTED, // Purchase Order yang Rejected
        REFUSED, // Finance Request yang Rejected
        CLOSED,
        DONE,
        BUDGETING,
        CANCELLED,
        FAILED,
        REVIEWING,
        OPEN,
        PENDING
    }
    
    public static String toString(EnumActivity.ENUM_Activity enumActivity){
        String rValue = "";
        
        if (enumActivity == EnumActivity.ENUM_Activity.NEW) {
            rValue = "NEW";
        }else if  (enumActivity == EnumActivity.ENUM_Activity.UPDATE) {
            rValue = "UPDATE";
        }else if  (enumActivity == EnumActivity.ENUM_Activity.DELETE) {
            rValue = "DELETE";
        }else if  (enumActivity == EnumActivity.ENUM_Activity.REVISE) {
            rValue = "REVISE";
        }else if  (enumActivity == EnumActivity.ENUM_Activity.CLONE) {
            rValue = "CLONE";
        }else if (enumActivity == EnumActivity.ENUM_Activity.VERIFIED) {
            rValue = "VERIFIED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.PROCESSED) {
            rValue = "PROCESSED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.RELEASED) {
            rValue = "RELEASED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.APPROVED) {
            rValue = "APPROVED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.REQUESTED) {
            rValue = "REQUESTED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.PARTIAL) {
            rValue = "PARTIAL";
        }else if (enumActivity == EnumActivity.ENUM_Activity.GRANTED) {
            rValue = "GRANTED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.DECLINED) {
            rValue = "DECLINED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.REJECTED) {
            rValue = "REJECTED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.REFUSED) {
            rValue = "REFUSED";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.RECEIVED) {
            rValue = "RECEIVED";
        }else if (enumActivity == EnumActivity.ENUM_Activity.DONE) {
            rValue = "DONE";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.CLOSED) {
            rValue = "CLOSED";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.BUDGETING) {
            rValue = "BUDGETING";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.CANCELLED) {
            rValue = "CANCELLED";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.FAILED) {
            rValue = "FAILED";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.REVIEWING) {
            rValue = "REVIEWING";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.OPEN){
            rValue = "REVIEWING";
        }
        else if (enumActivity == EnumActivity.ENUM_Activity.PENDING){
            rValue = "PENDING";
        }
        
        return rValue;
    }
    
}
