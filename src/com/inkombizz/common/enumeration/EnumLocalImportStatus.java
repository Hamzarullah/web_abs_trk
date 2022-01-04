package com.inkombizz.common.enumeration;

public class EnumLocalImportStatus {
    public enum ENUM_LocalImportStatus{        
        LOCAL,
        IMPORT
    }
    
    public static String toString(ENUM_LocalImportStatus localImportStatus){
        String rValue = "local";
        
        if (localImportStatus == ENUM_LocalImportStatus.IMPORT)
            rValue = "import";
        
        return rValue;
    }
}
