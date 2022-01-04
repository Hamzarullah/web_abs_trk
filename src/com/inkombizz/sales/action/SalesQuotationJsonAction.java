
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.SalesQuotationBLL;
import com.inkombizz.sales.model.SalesQuotation;
import com.inkombizz.sales.model.SalesQuotationDetail;
import com.inkombizz.sales.model.SalesQuotationDetailTemp;
import com.inkombizz.sales.model.SalesQuotationTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class SalesQuotationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private String actionAuthority="";
    private String valveType;
    private SalesQuotation salesQuotation;
    private SalesQuotationTemp salesQuotationTemp;
    private List<SalesQuotation> listSalesQuotation;
    private List<SalesQuotation> listSalesQuotationAccSpv;
    private List<SalesQuotationDetail> listSalesQuotationDetail;
    private List<SalesQuotationTemp> listSalesQuotationTemp;
    private List<SalesQuotationTemp> listSalesQuotationStatusTemp;
    private List<SalesQuotationDetailTemp> listSalesQuotationDetailTemp;
    
    private String listSalesQuotationDetailJSON;
    private String salesQuotationSearchCode="";
    private String salesQuotationCustomerSearchCode="";
    private String salesQuotationCustomerSearchName="";
    private String salesQuotationSearchRemark="";
    private String salesQuotationSearchRefNo="";
    private String salesQuotationSearchValidStatus="true";
    private String salesQuotationSearchSALQUOStatus="NO_STATUS";
    private String salesQuotationEndUserSearchCode="";
    private String salesQuotationEndUserSearchName="";
    private Date salesQuotationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date salesQuotationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private String salesQuotationStatusSearchCode="";
    private String salesQuotationStatusCustomerSearchCode="";
    private String salesQuotationStatusCustomerSearchName="";
    private String salesQuotationStatusSearchRemark="";
    private String salesQuotationStatusSearchRefNo="";
    private String salesQuotationStatusSearchValidStatus="true";
    private String salesQuotationStatusSearchSALQUOStatus="NO_STATUS";
    private Date salesQuotationStatusSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date salesQuotationStatusSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
     
    private String salesQuotationAccSpvSearchCode="";
    private String salesQuotationAccSpvCustomerSearchCode="";
    private String salesQuotationAccSpvCustomerSearchName="";
    private Date salesQuotationAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date salesQuotationAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    private String salesQuotationAccSpvSearchAccStatus="Open";     
    private File sqExcel;
    private ArrayList arrSalesQuotationNo;
    private ArrayList sQCode;
    private String salesQuotationCode="";
    private String salQuoStatus="APPROVED";
    private String salQuoRemark="";
    private String salQuoReasonCode="";
    private String salesQuotationSearchCodeConcat="";
    private String salesQuotationSearchDetailCodeConcat="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("sales-quotation-data")
    public String findData() {
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            ListPaging <SalesQuotationTemp> listPaging = salesQuotationBLL.findData(paging,salesQuotationSearchCode,salesQuotationSearchRemark, salesQuotationSearchRefNo, salesQuotationCustomerSearchCode,salesQuotationCustomerSearchName,
                                                                                    salesQuotationEndUserSearchCode, salesQuotationEndUserSearchName, salesQuotationSearchSALQUOStatus, 
                                                                                    salesQuotationSearchValidStatus, salesQuotationSearchFirstDate,salesQuotationSearchLastDate);
            
            listSalesQuotationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    //Used in: Customer Purchase Order -> search SalesQuotation
    @Action("sales-quotation-search-data")
    public String findSearchData() {
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            ListPaging <SalesQuotationTemp> listPaging = salesQuotationBLL.findSearchData(paging,salesQuotationTemp);
            
            listSalesQuotationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-quotation-getgroupby-data")
    public String findDataGetGroupBySalesQuotation(){
        try {
            
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            ListPaging<SalesQuotationTemp> listPaging = salesQuotationBLL.findDataArray(paging,salesQuotationTemp,salesQuotationSearchCodeConcat);
            
            listSalesQuotationTemp = listPaging.getList();
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-quotation-detail-getgroupby-data")
    public String findDataGetGroupBySalesQuotationDetail(){
        try {
            
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            ListPaging<SalesQuotationDetailTemp> listPaging = salesQuotationBLL.findDataDetailArray(paging,salesQuotationSearchDetailCodeConcat);
            
            listSalesQuotationDetailTemp = listPaging.getList();
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
//     @Action("sales-quotation-in-data")
//    public String findDataDetailIn() {
//        try {
//            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
//            listSalesQuotationTemp = salesQuotationBLL.findDataSales(this.SQCode);
//            
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
     @Action("sales-quotation-status-data")
    public String finapprovaldata(){
        try{
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);      

            ListPaging<SalesQuotationTemp> listPaging = salesQuotationBLL.findStatusData(paging,salesQuotationStatusSearchCode,salesQuotationStatusSearchRemark,salesQuotationStatusSearchRefNo,salesQuotationStatusCustomerSearchCode,salesQuotationStatusCustomerSearchName, salesQuotationStatusSearchSALQUOStatus, salesQuotationStatusSearchValidStatus, salesQuotationStatusSearchFirstDate,salesQuotationStatusSearchLastDate);
            
            listSalesQuotationStatusTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }

    @Action("sales-quotation-detail-data")
    public String findDataDetail(){
        try {
            
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            List<SalesQuotationDetailTemp> list = salesQuotationBLL.findDataDetail(salesQuotation.getCode());

            listSalesQuotationDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul customer purchase order
    @Action("sales-quotation-detail-getgroupby-sales-quotation-data")
    public String findDataDetailGetGroupBySalesQuotation(){
        try {
            
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            List<SalesQuotationDetailTemp> list = salesQuotationBLL.findDataDetail(arrSalesQuotationNo);
            
            listSalesQuotationDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-quotation-excel-import")
    public String sqExcelImport() {
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            
            listSalesQuotationDetailTemp = salesQuotationBLL.importExcel(valveType,sqExcel);
            
            return SUCCESS;
        } catch (Exception ex) {
            ex.printStackTrace();
            this.error = true;
            this.errorMessage = "IMPORT DATA FAILED!<br/>MESSAGE : <br/>" + ex.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("sales-quotation-save")
    public String save(){
        String _Messg = "";
        try {
                        
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            Gson gson = new Gson();
            this.listSalesQuotationDetail = gson.fromJson(this.listSalesQuotationDetailJSON, new TypeToken<List<SalesQuotationDetail>>(){}.getType());

            salesQuotation.setTransactionDate(DateUtils.newDateTime(salesQuotation.getTransactionDate(),true));
            if(salesQuotationBLL.isExist(this.salesQuotation.getCode())){
                this.errorMessage = "CODE "+this.salesQuotation.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
            
                _Messg = "SAVED ";
                salesQuotationBLL.save(salesQuotation, listSalesQuotationDetail);

                this.message = _Messg + " DATA SUCCESS.<br/>Sales Qoutation No : " + this.salesQuotation.getCode();
            }
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-quotation-update")
    public String update(){
        String _Messg = "";
        try {
                        
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            Gson gson = new Gson();
            this.listSalesQuotationDetail = gson.fromJson(this.listSalesQuotationDetailJSON, new TypeToken<List<SalesQuotationDetail>>(){}.getType());
            
            _Messg="UPDATED ";
            salesQuotationBLL.update(salesQuotation, listSalesQuotationDetail);
            this.message = _Messg + " DATA SUCCESS. <br/>Sal Quo No : " + this.salesQuotation.getCode();
              
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }


    @Action("sales-quotation-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            salesQuotationBLL.delete(this.salesQuotation.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>Sal Quo No : " + this.salesQuotation.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
     @Action("sales-quotation-authority")
    public String salesOrderAuthority(){
        try{
            
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
     @Action("sales-quotation-save-revise")
    public String saveRevise(){
        String _Messg = "";
        try {
                        
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            Gson gson = new Gson();
            this.listSalesQuotationDetail = gson.fromJson(this.listSalesQuotationDetailJSON, new TypeToken<List<SalesQuotationDetail>>(){}.getType());
            salesQuotation.setTransactionDate(DateUtils.newDateTime(salesQuotation.getTransactionDate(),true));
            
                 _Messg = "SAVED "; 
                 salesQuotationBLL.saveRevise(salesQuotation, listSalesQuotationDetail);
            this.message = _Messg + " DATA SUCCESS. <br/>Sal Quo No : " + this.salesQuotation.getCode();

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-quotation-status-save")
    public String saveStatus(){
        String _Messg = "";
        try {
            
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
        
            salesQuotationBLL.approval(salesQuotationCode,salQuoStatus,salQuoRemark,salQuoReasonCode);

            this.message = _Messg + " DATA SUCCESS.<br/>Sal Quo No : " + salesQuotationCode;

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public SalesQuotation getSalesQuotation() {
        return salesQuotation;
    }

    public void setSalesQuotation(SalesQuotation salesQuotation) {
        this.salesQuotation = salesQuotation;
    }

    public SalesQuotationTemp getSalesQuotationTemp() {
        return salesQuotationTemp;
    }

    public void setSalesQuotationTemp(SalesQuotationTemp salesQuotationTemp) {
        this.salesQuotationTemp = salesQuotationTemp;
    }

    public List<SalesQuotation> getListSalesQuotation() {
        return listSalesQuotation;
    }

    public void setListSalesQuotation(List<SalesQuotation> listSalesQuotation) {
        this.listSalesQuotation = listSalesQuotation;
    }

    public List<SalesQuotationDetail> getListSalesQuotationDetail() {
        return listSalesQuotationDetail;
    }

    public void setListSalesQuotationDetail(List<SalesQuotationDetail> listSalesQuotationDetail) {
        this.listSalesQuotationDetail = listSalesQuotationDetail;
    }

    public List<SalesQuotationTemp> getListSalesQuotationTemp() {
        return listSalesQuotationTemp;
    }

    public void setListSalesQuotationTemp(List<SalesQuotationTemp> listSalesQuotationTemp) {
        this.listSalesQuotationTemp = listSalesQuotationTemp;
    }

    public List<SalesQuotationDetailTemp> getListSalesQuotationDetailTemp() {
        return listSalesQuotationDetailTemp;
    }

    public void setListSalesQuotationDetailTemp(List<SalesQuotationDetailTemp> listSalesQuotationDetailTemp) {
        this.listSalesQuotationDetailTemp = listSalesQuotationDetailTemp;
    }

    public String getListSalesQuotationDetailJSON() {
        return listSalesQuotationDetailJSON;
    }

    public void setListSalesQuotationDetailJSON(String listSalesQuotationDetailJSON) {
        this.listSalesQuotationDetailJSON = listSalesQuotationDetailJSON;
    }

    public String getSalesQuotationSearchCode() {
        return salesQuotationSearchCode;
    }

    public void setSalesQuotationSearchCode(String salesQuotationSearchCode) {
        this.salesQuotationSearchCode = salesQuotationSearchCode;
    }

    public String getSalesQuotationCustomerSearchCode() {
        return salesQuotationCustomerSearchCode;
    }

    public void setSalesQuotationCustomerSearchCode(String salesQuotationCustomerSearchCode) {
        this.salesQuotationCustomerSearchCode = salesQuotationCustomerSearchCode;
    }

    public String getSalesQuotationCustomerSearchName() {
        return salesQuotationCustomerSearchName;
    }

    public void setSalesQuotationCustomerSearchName(String salesQuotationCustomerSearchName) {
        this.salesQuotationCustomerSearchName = salesQuotationCustomerSearchName;
    }

    public Date getSalesQuotationSearchFirstDate() {
        return salesQuotationSearchFirstDate;
    }

    public void setSalesQuotationSearchFirstDate(Date salesQuotationSearchFirstDate) {
        this.salesQuotationSearchFirstDate = salesQuotationSearchFirstDate;
    }

    public Date getSalesQuotationSearchLastDate() {
        return salesQuotationSearchLastDate;
    }

    public void setSalesQuotationSearchLastDate(Date salesQuotationSearchLastDate) {
        this.salesQuotationSearchLastDate = salesQuotationSearchLastDate;
    }

    public List<SalesQuotation> getListSalesQuotationAccSpv() {
        return listSalesQuotationAccSpv;
    }

    public void setListSalesQuotationAccSpv(List<SalesQuotation> listSalesQuotationAccSpv) {
        this.listSalesQuotationAccSpv = listSalesQuotationAccSpv;
    }

    public String getSalesQuotationAccSpvSearchCode() {
        return salesQuotationAccSpvSearchCode;
    }

    public void setSalesQuotationAccSpvSearchCode(String salesQuotationAccSpvSearchCode) {
        this.salesQuotationAccSpvSearchCode = salesQuotationAccSpvSearchCode;
    }

    public String getSalesQuotationAccSpvCustomerSearchCode() {
        return salesQuotationAccSpvCustomerSearchCode;
    }

    public void setSalesQuotationAccSpvCustomerSearchCode(String salesQuotationAccSpvCustomerSearchCode) {
        this.salesQuotationAccSpvCustomerSearchCode = salesQuotationAccSpvCustomerSearchCode;
    }

    public String getSalesQuotationAccSpvCustomerSearchName() {
        return salesQuotationAccSpvCustomerSearchName;
    }

    public void setSalesQuotationAccSpvCustomerSearchName(String salesQuotationAccSpvCustomerSearchName) {
        this.salesQuotationAccSpvCustomerSearchName = salesQuotationAccSpvCustomerSearchName;
    }

    public Date getSalesQuotationAccSpvSearchFirstDate() {
        return salesQuotationAccSpvSearchFirstDate;
    }

    public void setSalesQuotationAccSpvSearchFirstDate(Date salesQuotationAccSpvSearchFirstDate) {
        this.salesQuotationAccSpvSearchFirstDate = salesQuotationAccSpvSearchFirstDate;
    }

    public Date getSalesQuotationAccSpvSearchLastDate() {
        return salesQuotationAccSpvSearchLastDate;
    }

    public void setSalesQuotationAccSpvSearchLastDate(Date salesQuotationAccSpvSearchLastDate) {
        this.salesQuotationAccSpvSearchLastDate = salesQuotationAccSpvSearchLastDate;
    }

    public String getSalesQuotationAccSpvSearchAccStatus() {
        return salesQuotationAccSpvSearchAccStatus;
    }

    public void setSalesQuotationAccSpvSearchAccStatus(String salesQuotationAccSpvSearchAccStatus) {
        this.salesQuotationAccSpvSearchAccStatus = salesQuotationAccSpvSearchAccStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public ArrayList getArrSalesQuotationNo() {
        return arrSalesQuotationNo;
    }

    public void setArrSalesQuotationNo(ArrayList arrSalesQuotationNo) {
        this.arrSalesQuotationNo = arrSalesQuotationNo;
    }

    public List<SalesQuotationTemp> getListSalesQuotationStatusTemp() {
        return listSalesQuotationStatusTemp;
    }

    public void setListSalesQuotationStatusTemp(List<SalesQuotationTemp> listSalesQuotationStatusTemp) {
        this.listSalesQuotationStatusTemp = listSalesQuotationStatusTemp;
    }

    public String getSalesQuotationSearchRemark() {
        return salesQuotationSearchRemark;
    }

    public void setSalesQuotationSearchRemark(String salesQuotationSearchRemark) {
        this.salesQuotationSearchRemark = salesQuotationSearchRemark;
    }

    public String getSalesQuotationSearchRefNo() {
        return salesQuotationSearchRefNo;
    }

    public void setSalesQuotationSearchRefNo(String salesQuotationSearchRefNo) {
        this.salesQuotationSearchRefNo = salesQuotationSearchRefNo;
    }

    public String getSalesQuotationSearchValidStatus() {
        return salesQuotationSearchValidStatus;
    }

    public void setSalesQuotationSearchValidStatus(String salesQuotationSearchValidStatus) {
        this.salesQuotationSearchValidStatus = salesQuotationSearchValidStatus;
    }

    public String getSalesQuotationSearchSALQUOStatus() {
        return salesQuotationSearchSALQUOStatus;
    }

    public void setSalesQuotationSearchSALQUOStatus(String salesQuotationSearchSALQUOStatus) {
        this.salesQuotationSearchSALQUOStatus = salesQuotationSearchSALQUOStatus;
    }

    public String getSalesQuotationStatusSearchCode() {
        return salesQuotationStatusSearchCode;
    }

    public void setSalesQuotationStatusSearchCode(String salesQuotationStatusSearchCode) {
        this.salesQuotationStatusSearchCode = salesQuotationStatusSearchCode;
    }

    public String getSalesQuotationStatusCustomerSearchCode() {
        return salesQuotationStatusCustomerSearchCode;
    }

    public void setSalesQuotationStatusCustomerSearchCode(String salesQuotationStatusCustomerSearchCode) {
        this.salesQuotationStatusCustomerSearchCode = salesQuotationStatusCustomerSearchCode;
    }

    public String getSalesQuotationStatusCustomerSearchName() {
        return salesQuotationStatusCustomerSearchName;
    }

    public void setSalesQuotationStatusCustomerSearchName(String salesQuotationStatusCustomerSearchName) {
        this.salesQuotationStatusCustomerSearchName = salesQuotationStatusCustomerSearchName;
    }

    public String getSalesQuotationStatusSearchRemark() {
        return salesQuotationStatusSearchRemark;
    }

    public void setSalesQuotationStatusSearchRemark(String salesQuotationStatusSearchRemark) {
        this.salesQuotationStatusSearchRemark = salesQuotationStatusSearchRemark;
    }

    public String getSalesQuotationStatusSearchRefNo() {
        return salesQuotationStatusSearchRefNo;
    }

    public void setSalesQuotationStatusSearchRefNo(String salesQuotationStatusSearchRefNo) {
        this.salesQuotationStatusSearchRefNo = salesQuotationStatusSearchRefNo;
    }

    public String getSalesQuotationStatusSearchValidStatus() {
        return salesQuotationStatusSearchValidStatus;
    }

    public void setSalesQuotationStatusSearchValidStatus(String salesQuotationStatusSearchValidStatus) {
        this.salesQuotationStatusSearchValidStatus = salesQuotationStatusSearchValidStatus;
    }

    public String getSalesQuotationStatusSearchSALQUOStatus() {
        return salesQuotationStatusSearchSALQUOStatus;
    }

    public void setSalesQuotationStatusSearchSALQUOStatus(String salesQuotationStatusSearchSALQUOStatus) {
        this.salesQuotationStatusSearchSALQUOStatus = salesQuotationStatusSearchSALQUOStatus;
    }

    public Date getSalesQuotationStatusSearchFirstDate() {
        return salesQuotationStatusSearchFirstDate;
    }

    public void setSalesQuotationStatusSearchFirstDate(Date salesQuotationStatusSearchFirstDate) {
        this.salesQuotationStatusSearchFirstDate = salesQuotationStatusSearchFirstDate;
    }

    public Date getSalesQuotationStatusSearchLastDate() {
        return salesQuotationStatusSearchLastDate;
    }

    public void setSalesQuotationStatusSearchLastDate(Date salesQuotationStatusSearchLastDate) {
        this.salesQuotationStatusSearchLastDate = salesQuotationStatusSearchLastDate;
    }

    public String getSalesQuotationCode() {
        return salesQuotationCode;
    }

    public void setSalesQuotationCode(String salesQuotationCode) {
        this.salesQuotationCode = salesQuotationCode;
    }

    public String getSalQuoStatus() {
        return salQuoStatus;
    }

    public void setSalQuoStatus(String salQuoStatus) {
        this.salQuoStatus = salQuoStatus;
    }

    public String getSalQuoRemark() {
        return salQuoRemark;
    }

    public void setSalQuoRemark(String salQuoRemark) {
        this.salQuoRemark = salQuoRemark;
    }

    public String getSalQuoReasonCode() {
        return salQuoReasonCode;
    }

    public void setSalQuoReasonCode(String salQuoReasonCode) {
        this.salQuoReasonCode = salQuoReasonCode;
    }

    public ArrayList getsQCode() {
        return sQCode;
    }

    public void setsQCode(ArrayList sQCode) {
        this.sQCode = sQCode;
    }

    public String getSalesQuotationEndUserSearchCode() {
        return salesQuotationEndUserSearchCode;
    }

    public void setSalesQuotationEndUserSearchCode(String salesQuotationEndUserSearchCode) {
        this.salesQuotationEndUserSearchCode = salesQuotationEndUserSearchCode;
    }

    public String getSalesQuotationEndUserSearchName() {
        return salesQuotationEndUserSearchName;
    }

    public void setSalesQuotationEndUserSearchName(String salesQuotationEndUserSearchName) {
        this.salesQuotationEndUserSearchName = salesQuotationEndUserSearchName;
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
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
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

    public File getSqExcel() {
        return sqExcel;
    }

    public void setSqExcel(File sqExcel) {
        this.sqExcel = sqExcel;
    }

    public String getSalesQuotationSearchCodeConcat() {
        return salesQuotationSearchCodeConcat;
    }

    public void setSalesQuotationSearchCodeConcat(String salesQuotationSearchCodeConcat) {
        this.salesQuotationSearchCodeConcat = salesQuotationSearchCodeConcat;
    }

    public String getSalesQuotationSearchDetailCodeConcat() {
        return salesQuotationSearchDetailCodeConcat;
    }

    public void setSalesQuotationSearchDetailCodeConcat(String salesQuotationSearchDetailCodeConcat) {
        this.salesQuotationSearchDetailCodeConcat = salesQuotationSearchDetailCodeConcat;
    }

    public String getValveType() {
        return valveType;
    }

    public void setValveType(String valveType) {
        this.valveType = valveType;
    }

   
}
