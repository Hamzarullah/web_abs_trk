/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common.enumeration;

/**
 *
 * @author niko
 */
public class EnumInventoryType {
    public enum ENUM_InventoryType {
        FIFO,
        AVERAGE,
        INVENTORY,
        LIFO
    }
        
    public static String toString(ENUM_InventoryType inventoryType)
    {
        String rValue = "fifo";

        if (inventoryType == ENUM_InventoryType.AVERAGE)
        {
            rValue = "average";
        }

        else if (inventoryType == ENUM_InventoryType.LIFO)
        {
            rValue = "lifo";
        }
        
        else if (inventoryType == ENUM_InventoryType.INVENTORY)
        {
            rValue = "inventory";
        }

        return rValue;
    }

}
