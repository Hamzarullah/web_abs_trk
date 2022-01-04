/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.VendorDepositTypeBLL;
import com.inkombizz.master.model.VendorDepositType;
import com.inkombizz.master.model.VendorDepositTypeChartOfAccount;
import com.inkombizz.master.model.VendorDepositTypeChartOfAccountTemp;
import com.inkombizz.master.model.VendorDepositTypeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author CHRIST
 */
@Result (type="json")
public class VendorDepositTypeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorDepositTypeTemp vendorDepositTypeTemp;
    private VendorDepositType vendorDepositType;
    private VendorDepositType vendorDepositTypeForReport;
    private List <VendorDepositTypeTemp> listVendorDepositTypeTemp;
    private List <VendorDepositTypeChartOfAccountTemp> listVendorDepositTypeChartOfAccountTemp;
    private List <VendorDepositTypeChartOfAccount> listVendorDepositTypeChartOfAccount;
    private String code="";
    private String vendorDepositTypeSearchCode="";
    private String vendorDepositTypeSearchName="";
    private String listVendorDepositTypeChartOfAccountJSON="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("vendor-deposit-type-data")
    public String findData() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            ListPaging <VendorDepositTypeTemp> listPaging = vendorDepositTypeBLL.findData(this.paging);
            listVendorDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("vendor-deposit-type-data-detail-coa")
    public String findDataCoaDetail() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            ListPaging <VendorDepositTypeChartOfAccount> listPaging = vendorDepositTypeBLL.findDataCoaDetail(this.paging,vendorDepositType);
            listVendorDepositTypeChartOfAccount = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-type-search-data")
    public String searchData() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            ListPaging <VendorDepositTypeTemp> listPaging = vendorDepositTypeBLL.searchData(this.paging,vendorDepositType);
            listVendorDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("search-vendor-deposit-type-report-data-paging")
    public String findDataForReportPaging() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            ListPaging <VendorDepositTypeTemp> listPaging = vendorDepositTypeBLL.findDataReportPaging(paging,vendorDepositTypeSearchCode,vendorDepositTypeSearchName);
            
            listVendorDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-type-search-data-for-report")
    public String searchDataReport() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            ListPaging <VendorDepositTypeTemp> listPaging = vendorDepositTypeBLL.searchDataForReport(this.paging,vendorDepositTypeForReport);
            listVendorDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-type-get-report")
    public String getDataReport() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            this.vendorDepositTypeTemp = vendorDepositTypeBLL.findDataForReport(vendorDepositType);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-type-get-min")
    public String populateDataVendorMin() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL=new VendorDepositTypeBLL(hbmSession);
            this.vendorDepositTypeTemp = vendorDepositTypeBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-type-get-max")
    public String populateDataVendorMax() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL=new VendorDepositTypeBLL(hbmSession);
            this.vendorDepositTypeTemp = vendorDepositTypeBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    //get
    @Action("vendor-deposit-type-get")
    public String getData() {
        try {
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            this.vendorDepositTypeTemp = vendorDepositTypeBLL.findData(vendorDepositType);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("vendor-deposit-type-chart-of-account")
    public String findDataCOA(){
        try{
            
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            List<VendorDepositTypeChartOfAccount> list = vendorDepositTypeBLL.findDataChartOfAccount(code); 
            
            listVendorDepositTypeChartOfAccount=list;
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("vendor-deposit-type-save")
    public String save() {
        String _Messg = "";
        try {
                VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);

                Gson gson = new Gson();
                
                this.listVendorDepositTypeChartOfAccount = gson.fromJson(this.listVendorDepositTypeChartOfAccountJSON, new TypeToken<List<VendorDepositTypeChartOfAccount>>(){}.getType());
                       
                vendorDepositTypeBLL.save(vendorDepositType, listVendorDepositTypeChartOfAccount);
                
                this.message = "UPDATE DATA SUCCESS.<br/> Code : " + this.vendorDepositType.getCode();

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public VendorDepositTypeTemp getVendorDepositTypeTemp() {
        return vendorDepositTypeTemp;
    }

    public void setVendorDepositTypeTemp(VendorDepositTypeTemp vendorDepositTypeTemp) {
        this.vendorDepositTypeTemp = vendorDepositTypeTemp;
    }

    public List<VendorDepositTypeTemp> getListVendorDepositTypeTemp() {
        return listVendorDepositTypeTemp;
    }

    public void setListVendorDepositTypeTemp(List<VendorDepositTypeTemp> listVendorDepositTypeTemp) {
        this.listVendorDepositTypeTemp = listVendorDepositTypeTemp;
    }

    public List<VendorDepositTypeChartOfAccountTemp> getListVendorDepositTypeChartOfAccountTemp() {
        return listVendorDepositTypeChartOfAccountTemp;
    }

    public void setListVendorDepositTypeChartOfAccountTemp(List<VendorDepositTypeChartOfAccountTemp> listVendorDepositTypeChartOfAccountTemp) {
        this.listVendorDepositTypeChartOfAccountTemp = listVendorDepositTypeChartOfAccountTemp;
    }

    public List<VendorDepositTypeChartOfAccount> getListVendorDepositTypeChartOfAccount() {
        return listVendorDepositTypeChartOfAccount;
    }

    public void setListVendorDepositTypeChartOfAccount(List<VendorDepositTypeChartOfAccount> listVendorDepositTypeChartOfAccount) {
        this.listVendorDepositTypeChartOfAccount = listVendorDepositTypeChartOfAccount;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public VendorDepositType getVendorDepositType() {
        return vendorDepositType;
    }

    public void setVendorDepositType(VendorDepositType vendorDepositType) {
        this.vendorDepositType = vendorDepositType;
    }

    public String getListVendorDepositTypeChartOfAccountJSON() {
        return listVendorDepositTypeChartOfAccountJSON;
    }

    public void setListVendorDepositTypeChartOfAccountJSON(String listVendorDepositTypeChartOfAccountJSON) {
        this.listVendorDepositTypeChartOfAccountJSON = listVendorDepositTypeChartOfAccountJSON;
    }

    public VendorDepositType getVendorDepositTypeForReport() {
        return vendorDepositTypeForReport;
    }

    public void setVendorDepositTypeForReport(VendorDepositType vendorDepositTypeForReport) {
        this.vendorDepositTypeForReport = vendorDepositTypeForReport;
    }

    public String getVendorDepositTypeSearchCode() {
        return vendorDepositTypeSearchCode;
    }

    public void setVendorDepositTypeSearchCode(String vendorDepositTypeSearchCode) {
        this.vendorDepositTypeSearchCode = vendorDepositTypeSearchCode;
    }

    public String getVendorDepositTypeSearchName() {
        return vendorDepositTypeSearchName;
    }

    public void setVendorDepositTypeSearchName(String vendorDepositTypeSearchName) {
        this.vendorDepositTypeSearchName = vendorDepositTypeSearchName;
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

    // </editor-fold>
}



