/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.BankPaymentBLL;
import com.inkombizz.finance.model.BankPayment;
import com.inkombizz.finance.model.BankPaymentDetail;
import com.inkombizz.finance.model.BankPaymentDetailTemp;
import com.inkombizz.finance.model.BankPaymentPaymentRequest;
import com.inkombizz.finance.model.BankPaymentPaymentRequestTemp;
import com.inkombizz.finance.model.BankPaymentTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class BankPaymentJsonAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private BankPayment bankPayment;
    private BankPaymentTemp bankPaymentTemp;
    private BankPaymentPaymentRequest bankPaymentDetailPaymentRequest;
    private BankPaymentPaymentRequestTemp bankPaymentDetailPaymentRequestTemp;
    private BankPaymentDetail bankPaymentDetail;
    private BankPaymentDetailTemp bankPaymentDetailTemp;
    
    
    private BankPayment bankPaymentAccSpv;
    private BankPaymentTemp bankPaymentAccSpvTemp;
    
    private String bankPaymentAccSpvSearchCode="";
    private String bankPaymentAccSpvSearchPaymentTo = "";
    private String bankPaymentAccSpvSearchAccStatus = "Open";
    private Date bankPaymentAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date bankPaymentAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private List<BankPayment> listBankPayment;
    private List<BankPaymentTemp> listBankPaymentTemp;
    private List<BankPaymentPaymentRequest> listBankPaymentDetailPaymentRequest;
    private List<BankPaymentPaymentRequestTemp> listBankPaymentDetailPaymentRequestTemp;
    private List<BankPaymentDetail> listBankPaymentDetail;
    private List<BankPaymentDetailTemp> listBankPaymentDetailTemp;   
    
    private String listBankPaymentDetailJSON;
    
    private BankPaymentTemp bankPaymentSearchTemp = new BankPaymentTemp();
    
    private Double forexAmount;
    private String actionAuthority="";
            
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("bank-payment-data")
    public String findData() {
        try {
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            if(bankPaymentSearchTemp.getFirstDate() == null){
                bankPaymentSearchTemp.setFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            }
            if(bankPaymentSearchTemp.getLastDate() == null){
                bankPaymentSearchTemp.setLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            }
            ListPaging <BankPaymentTemp> listPaging = bankPaymentBLL.findData(paging, bankPaymentSearchTemp);
            
            listBankPaymentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-payment-acc-spv-data")
    public String findDataAccSpv() {
        try {
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            ListPaging <BankPaymentTemp> listPaging = bankPaymentBLL.findDataAccSpv(paging, bankPaymentAccSpvSearchCode,bankPaymentAccSpvSearchPaymentTo,bankPaymentAccSpvSearchAccStatus,bankPaymentAccSpvSearchFirstDate,bankPaymentAccSpvSearchLastDate);
            
            listBankPaymentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-payment-payment-request-data")
    public String findDataPaymentRequest() {
        try {
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            List<BankPaymentPaymentRequestTemp> list = bankPaymentBLL.findDataBankPaymentRequest(bankPayment.getCode());
            
            listBankPaymentDetailPaymentRequestTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-payment-detail-data")
    public String findDataDetail(){
        try {
            
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            List<BankPaymentDetailTemp> list = bankPaymentBLL.findDataBankPaymentDetail(bankPayment.getCode());

            listBankPaymentDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("bank-payment-save")
    public String save(){
        String _Messg = "";
        try {
                        
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            Gson gson = new Gson();
            this.listBankPaymentDetail = gson.fromJson(this.listBankPaymentDetailJSON, new TypeToken<List<BankPaymentDetail>>(){}.getType());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(bankPaymentTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            bankPayment.setTransactionDate(getTransactionDateTemp);
            
            Date transferPaymentDateTemp = sdf.parse(bankPaymentTemp.getTransferPaymentDateTemp());
            Date getTransferPaymentDateTemp = new java.sql.Timestamp(transferPaymentDateTemp.getTime());
            bankPayment.setTransferPaymentDate(getTransferPaymentDateTemp);
            
            Date createdDateTemp = sdf.parse(bankPaymentTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            bankPayment.setCreatedDate(getCreatedDateTemp);
            
            if(bankPaymentBLL.isExist(this.bankPayment.getCode())){
                _Messg="UPDATED ";
              
                bankPaymentBLL.update(bankPayment, listBankPaymentDetail, forexAmount);
                
            }else{
                _Messg = "SAVED ";
                bankPaymentBLL.save(bankPayment, listBankPaymentDetail, forexAmount);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>BANK PAYMENT No : " + this.bankPayment.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-payment-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            Gson gson = new Gson();
            this.listBankPaymentDetail = gson.fromJson(this.listBankPaymentDetailJSON, new TypeToken<List<BankPaymentDetail>>(){}.getType());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(bankPaymentAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            bankPaymentAccSpv.setTransactionDate(getTransactionDateTemp);
            
            Date transferPaymentDateTemp = sdf.parse(bankPaymentAccSpvTemp.getTransferPaymentDateTemp());
            Date getTransferPaymentDateTemp = new java.sql.Timestamp(transferPaymentDateTemp.getTime());
            bankPaymentAccSpv.setTransferPaymentDate(getTransferPaymentDateTemp);
            
            Date createdDateTemp = sdf.parse(bankPaymentAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            bankPaymentAccSpv.setCreatedDate(getCreatedDateTemp);
            
            _Messg="ACC UPDATED ";
              
            bankPaymentBLL.updateAccSpv(bankPaymentAccSpv, listBankPaymentDetail, forexAmount);

            this.message = _Messg + " DATA SUCCESS.<br/>BANK PAYMENT No : " + this.bankPaymentAccSpv.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
//    @Action("bank-payment-update")
//    public String updateDownPayment(){
//        try {
//                        
//            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
//            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
//            
//            Date TransactionDateTemp = sdf.parse(bankPaymentDownPaymentTemp.getTransactionDateTemp());
//            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
//            bankPaymentDownPaymentUpdate.setTransactionDate(getTransactionDateTemp);
//                        
//            Date createdDateTemp = sdf.parse(bankPaymentDownPaymentTemp.getCreatedDateTemp());
//            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
//            bankPaymentDownPaymentUpdate.setCreatedDate(getCreatedDateTemp);            
//            bankPaymentBLL.updateDownPayment(bankPaymentDownPaymentUpdate);
//
//            this.message ="UPDATE DOWN PAYMENT SUPPLIER DATA SUCCESS.<br/>BANK PAYMENT No : " + this.bankPaymentDownPaymentUpdate.getCode();
//
//            return SUCCESS;
//        } catch (Exception e) {
//            this.error = true;
//            this.errorMessage ="UPDATE DOWN PAYMENT SUPPLIER DATA FAILED.<br/>MESSAGE : " + e.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("bank-payment-delete")
    public String delete(){
        try{
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(bankPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            bankPaymentBLL.delete(this.bankPayment.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>BANK PAYMENT No : " + this.bankPayment.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public BankPayment getBankPayment() {
        return bankPayment;
    }

    public void setBankPayment(BankPayment bankPayment) {
        this.bankPayment = bankPayment;
    }

    public BankPaymentTemp getBankPaymentTemp() {
        return bankPaymentTemp;
    }

    public void setBankPaymentTemp(BankPaymentTemp bankPaymentTemp) {
        this.bankPaymentTemp = bankPaymentTemp;
    }

    public BankPaymentPaymentRequest getBankPaymentDetailPaymentRequest() {
        return bankPaymentDetailPaymentRequest;
    }

    public void setBankPaymentDetailPaymentRequest(BankPaymentPaymentRequest bankPaymentDetailPaymentRequest) {
        this.bankPaymentDetailPaymentRequest = bankPaymentDetailPaymentRequest;
    }

    public BankPaymentPaymentRequestTemp getBankPaymentDetailPaymentRequestTemp() {
        return bankPaymentDetailPaymentRequestTemp;
    }

    public void setBankPaymentDetailPaymentRequestTemp(BankPaymentPaymentRequestTemp bankPaymentDetailPaymentRequestTemp) {
        this.bankPaymentDetailPaymentRequestTemp = bankPaymentDetailPaymentRequestTemp;
    }

    public BankPaymentDetail getBankPaymentDetail() {
        return bankPaymentDetail;
    }

    public void setBankPaymentDetail(BankPaymentDetail bankPaymentDetail) {
        this.bankPaymentDetail = bankPaymentDetail;
    }

    public BankPaymentDetailTemp getBankPaymentDetailTemp() {
        return bankPaymentDetailTemp;
    }

    public void setBankPaymentDetailTemp(BankPaymentDetailTemp bankPaymentDetailTemp) {
        this.bankPaymentDetailTemp = bankPaymentDetailTemp;
    }

    public List<BankPayment> getListBankPayment() {
        return listBankPayment;
    }

    public void setListBankPayment(List<BankPayment> listBankPayment) {
        this.listBankPayment = listBankPayment;
    }

    public List<BankPaymentTemp> getListBankPaymentTemp() {
        return listBankPaymentTemp;
    }

    public void setListBankPaymentTemp(List<BankPaymentTemp> listBankPaymentTemp) {
        this.listBankPaymentTemp = listBankPaymentTemp;
    }

    public List<BankPaymentPaymentRequest> getListBankPaymentDetailPaymentRequest() {
        return listBankPaymentDetailPaymentRequest;
    }

    public void setListBankPaymentDetailPaymentRequest(List<BankPaymentPaymentRequest> listBankPaymentDetailPaymentRequest) {
        this.listBankPaymentDetailPaymentRequest = listBankPaymentDetailPaymentRequest;
    }

    public List<BankPaymentPaymentRequestTemp> getListBankPaymentDetailPaymentRequestTemp() {
        return listBankPaymentDetailPaymentRequestTemp;
    }

    public void setListBankPaymentDetailPaymentRequestTemp(List<BankPaymentPaymentRequestTemp> listBankPaymentDetailPaymentRequestTemp) {
        this.listBankPaymentDetailPaymentRequestTemp = listBankPaymentDetailPaymentRequestTemp;
    }

    public List<BankPaymentDetail> getListBankPaymentDetail() {
        return listBankPaymentDetail;
    }

    public void setListBankPaymentDetail(List<BankPaymentDetail> listBankPaymentDetail) {
        this.listBankPaymentDetail = listBankPaymentDetail;
    }

    public List<BankPaymentDetailTemp> getListBankPaymentDetailTemp() {
        return listBankPaymentDetailTemp;
    }

    public void setListBankPaymentDetailTemp(List<BankPaymentDetailTemp> listBankPaymentDetailTemp) {
        this.listBankPaymentDetailTemp = listBankPaymentDetailTemp;
    }

    public String getListBankPaymentDetailJSON() {
        return listBankPaymentDetailJSON;
    }

    public void setListBankPaymentDetailJSON(String listBankPaymentDetailJSON) {
        this.listBankPaymentDetailJSON = listBankPaymentDetailJSON;
    }

    public BankPaymentTemp getBankPaymentSearchTemp() {
        return bankPaymentSearchTemp;
    }

    public void setBankPaymentSearchTemp(BankPaymentTemp bankPaymentSearchTemp) {
        this.bankPaymentSearchTemp = bankPaymentSearchTemp;
    }

    public Double getForexAmount() {
        return forexAmount;
    }

    public void setForexAmount(Double forexAmount) {
        this.forexAmount = forexAmount;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public BankPayment getBankPaymentAccSpv() {
        return bankPaymentAccSpv;
    }

    public void setBankPaymentAccSpv(BankPayment bankPaymentAccSpv) {
        this.bankPaymentAccSpv = bankPaymentAccSpv;
    }

    public BankPaymentTemp getBankPaymentAccSpvTemp() {
        return bankPaymentAccSpvTemp;
    }

    public void setBankPaymentAccSpvTemp(BankPaymentTemp bankPaymentAccSpvTemp) {
        this.bankPaymentAccSpvTemp = bankPaymentAccSpvTemp;
    }

    public String getBankPaymentAccSpvSearchCode() {
        return bankPaymentAccSpvSearchCode;
    }

    public void setBankPaymentAccSpvSearchCode(String bankPaymentAccSpvSearchCode) {
        this.bankPaymentAccSpvSearchCode = bankPaymentAccSpvSearchCode;
    }

    public String getBankPaymentAccSpvSearchPaymentTo() {
        return bankPaymentAccSpvSearchPaymentTo;
    }

    public void setBankPaymentAccSpvSearchPaymentTo(String bankPaymentAccSpvSearchPaymentTo) {
        this.bankPaymentAccSpvSearchPaymentTo = bankPaymentAccSpvSearchPaymentTo;
    }

    public String getBankPaymentAccSpvSearchAccStatus() {
        return bankPaymentAccSpvSearchAccStatus;
    }

    public void setBankPaymentAccSpvSearchAccStatus(String bankPaymentAccSpvSearchAccStatus) {
        this.bankPaymentAccSpvSearchAccStatus = bankPaymentAccSpvSearchAccStatus;
    }

    public Date getBankPaymentAccSpvSearchFirstDate() {
        return bankPaymentAccSpvSearchFirstDate;
    }

    public void setBankPaymentAccSpvSearchFirstDate(Date bankPaymentAccSpvSearchFirstDate) {
        this.bankPaymentAccSpvSearchFirstDate = bankPaymentAccSpvSearchFirstDate;
    }

    public Date getBankPaymentAccSpvSearchLastDate() {
        return bankPaymentAccSpvSearchLastDate;
    }

    public void setBankPaymentAccSpvSearchLastDate(Date bankPaymentAccSpvSearchLastDate) {
        this.bankPaymentAccSpvSearchLastDate = bankPaymentAccSpvSearchLastDate;
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
}
