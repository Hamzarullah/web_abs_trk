/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.finance.model.VendorDownPayment;
import com.inkombizz.finance.model.VendorDownPaymentTemp;
import com.inkombizz.finance.bll.VendorDownPaymentBLL;
import com.inkombizz.utils.DateUtils;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Results({
    @Result(name="success", type = "json"),
    @Result(name="pageHTML", location="finance/vendor-down-payment.jsp")
})
public class VendorDownPaymentJsonAction extends ActionSupport{
    
     private static final long serialVersionUID = 1L;    
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorDownPayment vendorDownPayment;
    private VendorDownPaymentTemp vendorDownPaymentTemp;
    private String vendorDownPaymentSearchCode="";
    private String vendorDownPaymentVendorSearchCode="";
    private String vendorDownPaymentVendorSearchName="";
    private String vendorDownPaymentCurrencySearchCode="";
    private Date vendorDownPaymentSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorDownPaymentSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());;
    private List<VendorDownPaymentTemp> listVendorDownPaymentTemp;
    private String sinNo="";
    private String actionAuthority="";
    private boolean isExisting;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    
    @Action("vendor-down-payment-data")
    public String findData(){
        try{
            
            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
            ListPaging<VendorDownPaymentTemp> listPaging = vendorDownPaymentBLL.findData(paging, vendorDownPaymentSearchCode,vendorDownPaymentVendorSearchCode,vendorDownPaymentVendorSearchName,vendorDownPaymentCurrencySearchCode,vendorDownPaymentSearchFirstDate,vendorDownPaymentSearchLastDate); 
            
            listVendorDownPaymentTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("vendor-down-payment-save")
    public String save(){
        String _Messg = "";
        try{
            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
         
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                
                Date TransactionDateTemp = sdf.parse(vendorDownPaymentTemp.getTransactionDateTemp());
                vendorDownPayment.setTransactionDate(TransactionDateTemp);
                
                Date CreatedDateTemp = sdf.parse(vendorDownPaymentTemp.getCreatedDateTemp());
                vendorDownPayment.setCreatedDate(CreatedDateTemp);
                            
                if(vendorDownPaymentBLL.isExist(this.vendorDownPayment.getCode())){
                    _Messg="UPDATED ";
                    vendorDownPaymentBLL.update(this.vendorDownPayment);
                }else{
                    _Messg = "SAVED ";
                    vendorDownPaymentBLL.save(this.vendorDownPayment);
                }
            
                
            this.message = _Messg+ "DATA SUCCESED. \n CODE : " +vendorDownPayment.getCode();
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = _Messg+"DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    
//    @Action("vendor-down-payment-search-data")
//    public String searchData() {
//        try {
//            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
//            ListPaging <VendorDownPaymentTemp> listPaging = vendorDownPaymentBLL.search(paging, getVendorDownPaymentSearchCode(),getVendorDownPaymentVendorSearchCode(),getVendorDownPaymentVendorSearchName(),getVendorDownPaymentCurrencySearchCode());
//            
//            listVendorDownPaymentTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

    @Action("vendor-down-payment-by-purchase-order-data")
    public String searchDataByPurchaseOrder() {
        try {

            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
            listVendorDownPaymentTemp =  vendorDownPaymentBLL.findByPurchaseOrder(vendorDownPaymentVendorSearchCode);

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-down-payment-by-vendor-invoice-data")
    public String searchDataByVendorInvoice() {
        try {

            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
            listVendorDownPaymentTemp =  vendorDownPaymentBLL.findByVendorInvoice(vendorDownPaymentVendorSearchCode);

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("vendor-down-payment-by-vendor-invoice-update")
    public String searchSDPByVendorInvoiceUpdate(){
        try{
            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
           
            List<VendorDownPaymentTemp> list = vendorDownPaymentBLL.listDataHeaderByVendorInvoiceUpdate(this.sinNo,this.vendorDownPayment.getVendor().getCode(),this.vendorDownPayment.getCurrency().getCode());
            
            listVendorDownPaymentTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("vendor-down-payment-existing")
    public String existingVendorInvoice(){
        try{
            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
            switch(actionAuthority){
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
            }
            isExisting=vendorDownPaymentBLL.checkExistInUsedPaidAmount(this.vendorDownPayment.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-down-payment-delete")
    public String deleteVendorDownPayment(){
        try{
            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);

            vendorDownPaymentBLL.delete(vendorDownPayment.getCode());
            this.message ="DELETE DATA SUCCESS. \n SDP No : " + this.vendorDownPayment.getCode();
            
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

    public VendorDownPayment getVendorDownPayment() {
        return vendorDownPayment;
    }

    public void setVendorDownPayment(VendorDownPayment vendorDownPayment) {
        this.vendorDownPayment = vendorDownPayment;
    }

    public VendorDownPaymentTemp getVendorDownPaymentTemp() {
        return vendorDownPaymentTemp;
    }

    public void setVendorDownPaymentTemp(VendorDownPaymentTemp vendorDownPaymentTemp) {
        this.vendorDownPaymentTemp = vendorDownPaymentTemp;
    }

    public String getVendorDownPaymentSearchCode() {
        return vendorDownPaymentSearchCode;
    }

    public void setVendorDownPaymentSearchCode(String vendorDownPaymentSearchCode) {
        this.vendorDownPaymentSearchCode = vendorDownPaymentSearchCode;
    }

    public String getVendorDownPaymentVendorSearchCode() {
        return vendorDownPaymentVendorSearchCode;
    }

    public void setVendorDownPaymentVendorSearchCode(String vendorDownPaymentVendorSearchCode) {
        this.vendorDownPaymentVendorSearchCode = vendorDownPaymentVendorSearchCode;
    }

    public String getVendorDownPaymentVendorSearchName() {
        return vendorDownPaymentVendorSearchName;
    }

    public void setVendorDownPaymentVendorSearchName(String vendorDownPaymentVendorSearchName) {
        this.vendorDownPaymentVendorSearchName = vendorDownPaymentVendorSearchName;
    }

    public String getVendorDownPaymentCurrencySearchCode() {
        return vendorDownPaymentCurrencySearchCode;
    }

    public void setVendorDownPaymentCurrencySearchCode(String vendorDownPaymentCurrencySearchCode) {
        this.vendorDownPaymentCurrencySearchCode = vendorDownPaymentCurrencySearchCode;
    }

    public Date getVendorDownPaymentSearchFirstDate() {
        return vendorDownPaymentSearchFirstDate;
    }

    public void setVendorDownPaymentSearchFirstDate(Date vendorDownPaymentSearchFirstDate) {
        this.vendorDownPaymentSearchFirstDate = vendorDownPaymentSearchFirstDate;
    }

    public Date getVendorDownPaymentSearchLastDate() {
        return vendorDownPaymentSearchLastDate;
    }

    public void setVendorDownPaymentSearchLastDate(Date vendorDownPaymentSearchLastDate) {
        this.vendorDownPaymentSearchLastDate = vendorDownPaymentSearchLastDate;
    }

    public List<VendorDownPaymentTemp> getListVendorDownPaymentTemp() {
        return listVendorDownPaymentTemp;
    }

    public void setListVendorDownPaymentTemp(List<VendorDownPaymentTemp> listVendorDownPaymentTemp) {
        this.listVendorDownPaymentTemp = listVendorDownPaymentTemp;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public boolean isIsExisting() {
        return isExisting;
    }

    public void setIsExisting(boolean isExisting) {
        this.isExisting = isExisting;
    }

    public String getSinNo() {
        return sinNo;
    }

    public void setSinNo(String sinNo) {
        this.sinNo = sinNo;
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
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">\
    
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
