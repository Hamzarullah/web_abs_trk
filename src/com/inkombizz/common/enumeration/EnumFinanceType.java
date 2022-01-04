/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author ikb_hengky
 */
public class EnumFinanceType {
    public enum ENUM_Payment_Type {
        Transaction,
        Transfer,
        Giro,
        Other,
        DPP,
        PPN
    }
    public enum ENUM_Giro_Type {
        Pending,
        Rejected,
        Cleared
    }
    
}
