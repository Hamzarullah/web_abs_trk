/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.inkombizz.security.model;

/**
 *
 * @author eggi
 */
public class RoleAuthorizationTemp {
    
    private String code = "";
    private String modulecode = "";
    private String modulename = "";
    private boolean assignauthority = false;
    private boolean deleteauthority = false;
    private boolean updateauthority = false;
    private boolean saveauthority = false;
    private boolean printauthority = false;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getModulecode() {
        return modulecode;
    }

    public void setModulecode(String modulecode) {
        this.modulecode = modulecode;
    }

    public String getModulename() {
        return modulename;
    }

    public void setModulename(String modulename) {
        this.modulename = modulename;
    }

    public boolean isAssignauthority() {
        return assignauthority;
    }

    public void setAssignauthority(boolean assignauthority) {
        this.assignauthority = assignauthority;
    }

    public boolean isDeleteauthority() {
        return deleteauthority;
    }

    public void setDeleteauthority(boolean deleteauthority) {
        this.deleteauthority = deleteauthority;
    }

    public boolean isUpdateauthority() {
        return updateauthority;
    }

    public void setUpdateauthority(boolean updateauthority) {
        this.updateauthority = updateauthority;
    }

    public boolean isSaveauthority() {
        return saveauthority;
    }

    public void setSaveauthority(boolean saveauthority) {
        this.saveauthority = saveauthority;
    }

    public boolean isPrintauthority() {
        return printauthority;
    }

    public void setPrintauthority(boolean printauthority) {
        this.printauthority = printauthority;
    }

}
