/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common;

/**
 *
 * @author ikb_hengky
 */
public class CommonConst {
    
    public static final String spliterNo = "_REV_";
    public static final String spliterNoRev = "_REV.";
    
    public static final String RequiredField = "The following required fields have been left empty : ";
    public static final String MsgEmptyData = "Data Is Empty ";
    public static final String MsgUpdateSuccess = "Update Data Success ";
    public static final String MsgDeleteSuccess = "Delete Data Success ";
    public static final String MsgTransactionDate = "Transaction Date must between Session Period ";
    public static final String MsgDelete = "Are you sure to delete this Data ";
    public static final String MsgConfirmationSuccess = "Confirmation Data Success ";
    public static final String MsgSaveSuccess = "Save Data Success ";
    public static final String MsgPrint = "Do you want to Print? ";
    
    /*  AUTHORITY AREA  */
    public static final String MsgAuthorityInsert = "Unable to Insert this Transaction, Authority Required !";
    public static final String MsgAuthorityUpdate = "Unable to Update this Transaction, Authority Required !";
    public static final String MsgAuthorityDelete = "Unable to Delete this Transaction, Authority Required !";
    public static final String MsgAuthorityPrint = "Unable to Print this Transaction, Authority Required !";    

    public static String getSpliterNo() {
        return spliterNo;
    }
    
    
}
