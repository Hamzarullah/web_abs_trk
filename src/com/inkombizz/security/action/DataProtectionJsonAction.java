/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.action.ProgramSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.DataProtectionBLL;
import com.inkombizz.security.model.DataProtectionTemp;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result(type="json")
public class DataProtectionJsonAction extends ActionSupport {
    private static final long serialVersionUID=1L;
    protected HBMSession hbmSession=new HBMSession();
    private ProgramSession prgSession = new ProgramSession();
    
    private String code = "";
    private List <DataProtectionTemp> listDataProtectionTemp;
    private String actionAuthority="";
    private BigDecimal dataProtection_periodMonth;
    private BigDecimal dataProtection_periodYear;
    private Date transactionDateForDataProtection = DateUtils.newDate(1900, 1, 1);
    
    @Override
    public String execute(){
        try{
            return findData();
        }
        catch(Exception Ex){
            return SUCCESS;
        }
    }
    
    @Action("data-protection-data")
    public String findData() {
        try {
            DataProtectionBLL dataProtectionBLL = new DataProtectionBLL(hbmSession);
            ListPaging <DataProtectionTemp> listPaging = dataProtectionBLL.findData(paging,code);
            
            listDataProtectionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("data-protection-authority")
    public String branchAuthority(){
        try{
            
            DataProtectionBLL dataProtectionBLL = new DataProtectionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dataProtectionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dataProtectionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dataProtectionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                
            }
            
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("data-protection-confirmation")
    public String ConfirmDataProtection(){
        try{
            DataProtectionBLL dataProtectionBLL = new DataProtectionBLL(hbmSession);
            BigDecimal month=BigDecimal.valueOf(BaseSession.loadProgramSession().getPeriodMonth()) ;
            BigDecimal year=BigDecimal.valueOf(BaseSession.loadProgramSession().getPeriodYear());
            
            SimpleDateFormat DATE_FORMAT_MONTH = new SimpleDateFormat("MM");
            SimpleDateFormat DATE_FORMAT_YEAR = new SimpleDateFormat("yyyy");
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String nullDate = DATE_FORMAT.format(transactionDateForDataProtection);
            
            String monthData = DATE_FORMAT_MONTH.format(transactionDateForDataProtection);
            String yearData = DATE_FORMAT_YEAR.format(transactionDateForDataProtection);
            
            String alertData="";
            if( !nullDate.equals("1900-01-01") ){
                alertData = "Unable to Manipulate Data!<br/>Period "+monthData+" - "+yearData+" Has Been Closed.";
            }else {
                alertData = "Unable to Manipulate Data!<br/>Period "+month+" - "+year+" Has Been Closed.";
            }
            
            if(dataProtectionBLL.isExist(month,year,transactionDateForDataProtection)){
                this.error = true;
                this.errorMessage = alertData;
                return SUCCESS;
            }
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "ERROR DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("data-protection-save")
    public String save() {
        try {
            DataProtectionBLL dataProtectionBLL = new DataProtectionBLL(hbmSession);
           
            if(dataProtectionBLL.isExist(dataProtection_periodMonth,dataProtection_periodYear,transactionDateForDataProtection)){
                this.error = true;
                this.errorMessage = "Unable to Create Period ("+dataProtection_periodMonth+"-"+dataProtection_periodYear+"). Duplicate Period";
                return SUCCESS;
            }else{

                dataProtectionBLL.save(dataProtection_periodMonth,dataProtection_periodYear);
                this.message = "SAVE DATA SUCCESS!";
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("data-protection-delete")
    public String delete(){
        try{
            DataProtectionBLL dataProtectionBLL = new DataProtectionBLL(hbmSession);
            
            dataProtectionBLL.delete(dataProtection_periodMonth,dataProtection_periodYear);
            this.message ="DELETE DATA SUCCESS!";
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ProgramSession getPrgSession() {
        return prgSession;
    }

    public void setPrgSession(ProgramSession prgSession) {
        this.prgSession = prgSession;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public List<DataProtectionTemp> getListDataProtectionTemp() {
        return listDataProtectionTemp;
    }

    public void setListDataProtectionTemp(List<DataProtectionTemp> listDataProtectionTemp) {
        this.listDataProtectionTemp = listDataProtectionTemp;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public BigDecimal getDataProtection_periodMonth() {
        return dataProtection_periodMonth;
    }

    public void setDataProtection_periodMonth(BigDecimal dataProtection_periodMonth) {
        this.dataProtection_periodMonth = dataProtection_periodMonth;
    }

    public BigDecimal getDataProtection_periodYear() {
        return dataProtection_periodYear;
    }

    public void setDataProtection_periodYear(BigDecimal dataProtection_periodYear) {
        this.dataProtection_periodYear = dataProtection_periodYear;
    }

    public Date getTransactionDateForDataProtection() {
        return transactionDateForDataProtection;
    }

    public void setTransactionDateForDataProtection(Date transactionDateForDataProtection) {
        this.transactionDateForDataProtection = transactionDateForDataProtection;
    }

   

    
    
    
    
    
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
    Paging paging=new Paging();

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
    
    public Integer getRows() {
        return paging.getRows();
    }
    public void setRows(Integer rows) {
        paging.setRows(rows);
    }
    
    public Integer getPage() {
        return paging.getPage();
    }
    public void setPage(Integer page) {
        paging.setPage(page);
    }
    
    public Integer getTotal() {
        return paging.getTotal();
    }
    public void setTotal(Integer total) {
        paging.setTotal(total);
    }
    
    public Integer getRecords() {
        return paging.getRecords();
    }
    public void setRecords(Integer records) {
        paging.setRecords(records);
        
        if (paging.getRecords() > 0 && paging.getRows() > 0)
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        else
            paging.setTotal(0);
    }
    
    public String getSord() {
        return paging.getSord();
    }
    public void setSord(String sord) {
        paging.setSord(sord);
    }
    
    public String getSidx() {
        return paging.getSidx();
    }
    public void setSidx(String sidx) {
        paging.setSidx(sidx);
    }
    
    public void setSearchField(String searchField) {
        paging.setSearchField(searchField);
    }
    public void setSearchString(String searchString) {
        paging.setSearchString(searchString);
    }
    public void setSearchOper(String searchOper) {
        paging.setSearchOper(searchOper);
    }
    
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Message Info">
    private boolean error = false;
    private String errorMessage = "";
    private String message = "";

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    // </editor-fold>
    
}
