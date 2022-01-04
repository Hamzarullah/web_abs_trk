/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.action;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.model.Setup;
import com.inkombizz.security.bll.RoleAuthorizationBLL;

/**
 *
 * @author niko
 */
public class ProgramSession {
    private String logoPath;
    private String userCode;
    private String userName;
    private String groupCode;
    private String branchCode;
    private String branchName;
    private String currencyCode;
    private String defaultTimeIn = "00:00";
    private String defaultTimeOut = "00:00";
    int periodYear;
    int periodMonth;
    private String roleCode;
    private Setup setup;

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
    }
    
    public String getDefaultTimeIn() {
        return defaultTimeIn;
    }
    public void setDefaultTimeIn(String defaultTimeIn) {
        this.defaultTimeIn = defaultTimeIn;
    }
    
    public String getDefaultTimeOut() {
        return defaultTimeOut;
    }
    public void setDefaultTimeOut(String defaultTimeOut) {
        this.defaultTimeOut = defaultTimeOut;
    }       
    
    public boolean hasAuthority(String moduleCode, String authorizationString, HBMSession hbmSession) throws Exception {
        RoleAuthorizationBLL roleAuthorizationBLL = new RoleAuthorizationBLL(hbmSession);
        
        return roleAuthorizationBLL.hasAuthority(userName, moduleCode, authorizationString);
    }

    public int getPeriodYear() {
        return periodYear;
    }

    public void setPeriodYear(int periodYear) {
        this.periodYear = periodYear;
    }

    public int getPeriodMonth() {
        return periodMonth;
    }

    public void setPeriodMonth(int periodMonth) {
        this.periodMonth = periodMonth;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public Setup getSetup() {
        return setup;
    }

    public void setSetup(Setup setup) {
        this.setup = setup;
    }

//    public String getBranchCode() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
//    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public boolean hasAuthority(String MODULECODE, String toString) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    

}
