package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;

import com.inkombizz.master.bll.ChartOfAccountBLL;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.ChartOfAccountTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;



@Result(type = "json")
public class ChartOfAccountJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ChartOfAccount chartOfAccount;  
    private ChartOfAccountTemp chartOfAccountTemp;
    private List<ChartOfAccountTemp> listChartOfAccountTemp;
    private String chartOfAccountSearchCode = "";
    private String chartOfAccountSearchName = "";
    private String chartOfAccountSearchAccountType = "";
    private String chartOfAccountSearchActiveStatus="true";
    private String actionAuthority="";
    
    
    private ChartOfAccount searchChartOfAccount;
    private List<ChartOfAccount> listChartOfAccount;
    private String chartOfAccountSearchType="S";
    private String chartOfAccountSearchHeaderCode="05";
    
    
    
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
   @Action("chart-of-account-data")
    public String findData() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            ListPaging<ChartOfAccountTemp> listPaging = chartOfAccountBLL.findData(chartOfAccountSearchCode,chartOfAccountSearchName,chartOfAccountSearchAccountType,chartOfAccountSearchActiveStatus,paging);

            listChartOfAccountTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    

    @Action("chart-of-account-get-data")
    public String findData1() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            this.chartOfAccountTemp = chartOfAccountBLL.findData(this.chartOfAccount.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("chart-of-account-get")
    public String findData2() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            this.chartOfAccountTemp = chartOfAccountBLL.findData(this.chartOfAccount.getCode(),this.chartOfAccount.getAccountType(),this.chartOfAccount.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("chart-of-account-authority")
    public String chartOfAccountAuthority(){
        try{
            
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(chartOfAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(chartOfAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(chartOfAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("chart-of-account-get-min")
    public String dataMin() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            this.chartOfAccountTemp = chartOfAccountBLL.min();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("chart-of-account-get-max")
    public String dataMax() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            this.chartOfAccountTemp = chartOfAccountBLL.max();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("chart-of-account-get-min-sub")
    public String dataMinSub() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            this.chartOfAccountTemp = chartOfAccountBLL.minSub();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    
    @Action("chart-of-account-get-max-sub")
    public String dataMaxSub() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            this.chartOfAccountTemp = chartOfAccountBLL.maxSub();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("chart-of-account-save")
    public String save() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            if(chartOfAccountBLL.isExist(this.chartOfAccount.getCode())){
                this.errorMessage = "CODE "+this.chartOfAccount.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                chartOfAccountBLL.save(this.chartOfAccount);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.chartOfAccount.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("chart-of-account-update")
    public String update() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            chartOfAccountBLL.update(this.chartOfAccount);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.chartOfAccount.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
                return SUCCESS;
        }
    }

    @Action("chart-of-account-delete")
    public String delete() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            boolean check=false;// = chartOfAccountBLL.isExistToDelete(this.chartOfAccount.getCode());
            if(check == true){
                this.message = "CODE "+this.chartOfAccount.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                chartOfAccountBLL.delete(this.chartOfAccount.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.chartOfAccount.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("search-chart-of-account-data-header-query")
    public String populateDataByHeader() {
        try {
            ChartOfAccountBLL chartOfAccountBLL = new ChartOfAccountBLL(hbmSession);
            ListPaging<ChartOfAccountTemp> listPaging = chartOfAccountBLL.DataLookUpHeader(chartOfAccountSearchCode,chartOfAccountSearchName,chartOfAccountSearchType,chartOfAccountSearchHeaderCode,paging);

            listChartOfAccountTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    
    public ChartOfAccount getChartOfAccount() {
        return chartOfAccount;
    }

    public void setChartOfAccount(ChartOfAccount chartOfAccount) {
        this.chartOfAccount = chartOfAccount;
    }

    public ChartOfAccountTemp getChartOfAccountTemp() {
        return chartOfAccountTemp;
    }

    public void setChartOfAccountTemp(ChartOfAccountTemp chartOfAccountTemp) {
        this.chartOfAccountTemp = chartOfAccountTemp;
    }

    public List<ChartOfAccountTemp> getListChartOfAccountTemp() {
        return listChartOfAccountTemp;
    }

    public void setListChartOfAccountTemp(List<ChartOfAccountTemp> listChartOfAccountTemp) {
        this.listChartOfAccountTemp = listChartOfAccountTemp;
    }

    public String getChartOfAccountSearchCode() {
        return chartOfAccountSearchCode;
    }

    public void setChartOfAccountSearchCode(String chartOfAccountSearchCode) {
        this.chartOfAccountSearchCode = chartOfAccountSearchCode;
    }

    public String getChartOfAccountSearchName() {
        return chartOfAccountSearchName;
    }

    public void setChartOfAccountSearchName(String chartOfAccountSearchName) {
        this.chartOfAccountSearchName = chartOfAccountSearchName;
    }

    public String getChartOfAccountSearchAccountType() {
        return chartOfAccountSearchAccountType;
    }

    public void setChartOfAccountSearchAccountType(String chartOfAccountSearchAccountType) {
        this.chartOfAccountSearchAccountType = chartOfAccountSearchAccountType;
    }

    public String getChartOfAccountSearchActiveStatus() {
        return chartOfAccountSearchActiveStatus;
    }

    public void setChartOfAccountSearchActiveStatus(String chartOfAccountSearchActiveStatus) {
        this.chartOfAccountSearchActiveStatus = chartOfAccountSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public ChartOfAccount getSearchChartOfAccount() {
        return searchChartOfAccount;
    }

    public void setSearchChartOfAccount(ChartOfAccount searchChartOfAccount) {
        this.searchChartOfAccount = searchChartOfAccount;
    }

    public List<ChartOfAccount> getListChartOfAccount() {
        return listChartOfAccount;
    }

    public void setListChartOfAccount(List<ChartOfAccount> listChartOfAccount) {
        this.listChartOfAccount = listChartOfAccount;
    }

    public String getChartOfAccountSearchType() {
        return chartOfAccountSearchType;
    }

    public void setChartOfAccountSearchType(String chartOfAccountSearchType) {
        this.chartOfAccountSearchType = chartOfAccountSearchType;
    }

    public String getChartOfAccountSearchHeaderCode() {
        return chartOfAccountSearchHeaderCode;
    }

    public void setChartOfAccountSearchHeaderCode(String chartOfAccountSearchHeaderCode) {
        this.chartOfAccountSearchHeaderCode = chartOfAccountSearchHeaderCode;
    }

    
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
    
    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
    
    Paging paging = new Paging();

    
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    // </editor-fold>
    
}