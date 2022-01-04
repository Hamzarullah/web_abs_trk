
package com.inkombizz.inventory.model;


public class ErrorMessageImportExcel {
    
    private String rowID="";
    private String columnID="";
    private String columName="";
    private String errorMessages="";

    public String getRowID() {
        return rowID;
    }

    public void setRowID(String rowID) {
        this.rowID = rowID;
    }

    public String getColumnID() {
        return columnID;
    }

    public void setColumnID(String columnID) {
        this.columnID = columnID;
    }

    public String getColumName() {
        return columName;
    }

    public void setColumName(String columName) {
        this.columName = columName;
    }

    public String getErrorMessages() {
        return errorMessages;
    }

    public void setErrorMessages(String errorMessages) {
        this.errorMessages = errorMessages;
    }

    
    
}
