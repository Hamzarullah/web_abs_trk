
package com.inkombizz.security.model;


public class UserTemp {
    
    private String code = "";
    private String branchCode="";
    private String branchName="";
    private String divisionCode="";
    private String divisionName="";
    private String username = "";
    private String fullName = "";
    private String employeeCode = "";
    private String employeeName = "";
    private String password = "";
    private String roleCode = "";
    private String roleName = "";
    private String remark = "";
    private boolean unlockSoLimit = false;
    private boolean activeStatus = false;
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }


    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    public boolean isUnlockSoStatus() {
        return unlockSoLimit;
    }

    public void setUnlockSoStatus(boolean unlockSoLimit) {
        this.unlockSoLimit = unlockSoLimit;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public boolean isUnlockSoLimit() {
        return unlockSoLimit;
    }

    public void setUnlockSoLimit(boolean unlockSoLimit) {
        this.unlockSoLimit = unlockSoLimit;
    }

    public String getDivisionCode() {
        return divisionCode;
    }

    public void setDivisionCode(String divisionCode) {
        this.divisionCode = divisionCode;
    }

    public String getDivisionName() {
        return divisionName;
    }

    public void setDivisionName(String divisionName) {
        this.divisionName = divisionName;
    }

    
    
}
