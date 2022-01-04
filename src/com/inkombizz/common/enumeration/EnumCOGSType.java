/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;


public class EnumCOGSType {
    public enum ENUM_COGSType {
        ADJIN/*Adjustment In*/,
        PRT/*Purchase Return*/,
        IIN/*Inventory IN*/,
        IOT/*Inventory OUT*/,
        ASM/*Assembly*/,
        DOD/*Delivery Order*/,
        INV/*Invoice Non DO*/,
        SRT/*Sales Return*/,
        DSM/*Disassembly*/,
        OPN/*Opname*/,
        NONE,
        GRN/*Goods Received Note*/,
        WOR/*Work Order*/,
        OPENINGBALANCE,
        BHO/*Bonus Hand Over*/,
        WHM/*Warehouse Mutation*/,
        WHM_POP_INST/*Bonus Hand Over*/,
        WHM_POP_UNST/*Bonus Hand Over*/,
        WHM_POP_USED/*Bonus Hand Over*/,
        WHM_CUS_INST/*Bonus Hand Over*/,
        WHM_CUS_UNST/*Bonus Hand Over*/,
        WHM_CUS_USED/*Bonus Hand Over*/,
        DLN/*Delivery Note*/
    }
    
    public ENUM_COGSType transactionCogsType(ENUM_COGSType cogsType, boolean isIncreaseStock){
        ENUM_COGSType enumCogsType = ENUM_COGSType.NONE;
        
        if(isIncreaseStock){
            if((cogsType == ENUM_COGSType.OPENINGBALANCE))
                enumCogsType = ENUM_COGSType.NONE;
        }
        else{
            if((cogsType == ENUM_COGSType.GRN)&(cogsType == ENUM_COGSType.IIN)&(cogsType == ENUM_COGSType.GRN)&
                (cogsType == ENUM_COGSType.ASM))
                enumCogsType = ENUM_COGSType.NONE;
        }
        
        return cogsType;
    }
}
