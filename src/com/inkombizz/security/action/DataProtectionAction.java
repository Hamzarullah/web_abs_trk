/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.StringValue;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumMonth;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.DataProtectionBLL;
import com.inkombizz.security.model.DataProtection;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="security/data-protection.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class DataProtectionAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private int dataProtection_periodYear = 0;
    private int dataProtection_periodMonth = 0;
    private String dataProtection_periodMonth_Str = "";
    private List<StringValue> monthlyList;
    private List<StringValue> yearList;
    
    @Override
    public String execute() {
        try {
           DataProtectionBLL dataProtectionBLL = new DataProtectionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(dataProtectionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            dataProtection_periodMonth = DateUtils.getMonth();
            dataProtection_periodYear = DateUtils.getYear();
            dataProtection_periodMonth_Str = EnumMonth.toString(dataProtection_periodMonth, false);
                
            monthlyList = DateUtils.getMonthlyList();
            yearList = DateUtils.getYearList();
            
             return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public int getDataProtection_periodYear() {
        return dataProtection_periodYear;
    }

    public void setDataProtection_periodYear(int dataProtection_periodYear) {
        this.dataProtection_periodYear = dataProtection_periodYear;
    }

    public int getDataProtection_periodMonth() {
        return dataProtection_periodMonth;
    }

    public void setDataProtection_periodMonth(int dataProtection_periodMonth) {
        this.dataProtection_periodMonth = dataProtection_periodMonth;
    }

    public String getDataProtection_periodMonth_Str() {
        return dataProtection_periodMonth_Str;
    }

    public void setDataProtection_periodMonth_Str(String dataProtection_periodMonth_Str) {
        this.dataProtection_periodMonth_Str = dataProtection_periodMonth_Str;
    }

    public List<StringValue> getMonthlyList() {
        return monthlyList;
    }

    public void setMonthlyList(List<StringValue> monthlyList) {
        this.monthlyList = monthlyList;
    }

    public List<StringValue> getYearList() {
        return yearList;
    }

    public void setYearList(List<StringValue> yearList) {
        this.yearList = yearList;
    }
   
    
    
}
