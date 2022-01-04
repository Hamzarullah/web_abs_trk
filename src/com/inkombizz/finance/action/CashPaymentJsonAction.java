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
import com.inkombizz.finance.bll.CashPaymentBLL;
import com.inkombizz.finance.model.CashPayment;
import com.inkombizz.finance.model.CashPaymentDetail;
import com.inkombizz.finance.model.CashPaymentDetailTemp;
import com.inkombizz.finance.model.CashPaymentPaymentRequest;
import com.inkombizz.finance.model.CashPaymentPaymentRequestTemp;
import com.inkombizz.finance.model.CashPaymentTemp;
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
public class CashPaymentJsonAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CashPayment cashPayment;
    private CashPaymentTemp cashPaymentTemp;
    private CashPayment cashPaymentAccSpv;
    private CashPaymentTemp cashPaymentAccSpvTemp;
    private CashPaymentPaymentRequest cashPaymentDetailPaymentRequest;
    private CashPaymentPaymentRequestTemp cashPaymentDetailPaymentRequestTemp;
    private CashPaymentDetail cashPaymentDetail;
    private CashPaymentDetailTemp cashPaymentDetailTemp;
    
    private String cashPaymentAccSpvSearchCode = "";
    private String cashPaymentAccSpvSearchPaymentTo = "";
    private Date cashPaymentAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date cashPaymentAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private List<CashPayment> listCashPayment;
    private List<CashPaymentTemp> listCashPaymentTemp;
    private List<CashPaymentPaymentRequest> listCashPaymentDetailPaymentRequest;
    private List<CashPaymentPaymentRequestTemp> listCashPaymentDetailPaymentRequestTemp;
    private List<CashPaymentDetail> listCashPaymentDetail;
    private List<CashPaymentDetailTemp> listCashPaymentDetailTemp;   
    
    private String listCashPaymentDetailJSON;
    
    private CashPaymentTemp cashPaymentSearchTemp = new CashPaymentTemp();
    
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
    
    @Action("cash-payment-data")
    public String findData() {
        try {
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            if(cashPaymentSearchTemp.getFirstDate() == null){
                cashPaymentSearchTemp.setFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            }
            if(cashPaymentSearchTemp.getLastDate() == null){
                cashPaymentSearchTemp.setLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            }
            ListPaging <CashPaymentTemp> listPaging = cashPaymentBLL.findData(paging, cashPaymentSearchTemp);
            
            listCashPaymentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-payment-payment-request-data")
    public String findDataPaymentRequest() {
        try {
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            List<CashPaymentPaymentRequestTemp> list = cashPaymentBLL.findDataCashPaymentRequest(cashPayment.getCode());
            
            listCashPaymentDetailPaymentRequestTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-payment-acc-spv-data")
    public String findDataAccSpv() {
        try {
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            ListPaging<CashPaymentTemp> listPaging = cashPaymentBLL.findData(paging, cashPaymentAccSpvSearchCode, cashPaymentAccSpvSearchPaymentTo,cashPaymentAccSpvSearchFirstDate, cashPaymentAccSpvSearchLastDate);

            listCashPaymentTemp = listPaging.getList();

            return SUCCESS;
        } catch (Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-payment-detail-data")
    public String findDataDetail(){
        try {
            
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            List<CashPaymentDetailTemp> list = cashPaymentBLL.findDataCashPaymentDetail(cashPayment.getCode());

            listCashPaymentDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("cash-payment-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            Gson gson = new Gson();
            this.listCashPaymentDetail = gson.fromJson(this.listCashPaymentDetailJSON, new TypeToken<List<CashPaymentDetail>>(){}.getType());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(cashPaymentTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            cashPayment.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(cashPaymentTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            cashPayment.setCreatedDate(getCreatedDateTemp);
            
            if(cashPaymentBLL.isExist(this.cashPayment.getCode())){
                _Messg="UPDATED ";
              
                cashPaymentBLL.update(cashPayment, listCashPaymentDetail, forexAmount);
                
            }else{
                _Messg = "SAVED ";
                cashPaymentBLL.save(cashPayment, listCashPaymentDetail, forexAmount);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>BANK PAYMENT No : " + this.cashPayment.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-payment-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            Gson gson = new Gson();
            this.listCashPaymentDetail = gson.fromJson(this.listCashPaymentDetailJSON, new TypeToken<List<CashPaymentDetail>>(){}.getType());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(cashPaymentAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            cashPaymentAccSpv.setTransactionDate(getTransactionDateTemp);
                        
            Date createdDateTemp = sdf.parse(cashPaymentAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            cashPaymentAccSpv.setCreatedDate(getCreatedDateTemp);
            
            _Messg="ACC UPDATED ";
              
            cashPaymentBLL.updateAccSpv(cashPaymentAccSpv, listCashPaymentDetail, forexAmount);

            this.message = _Messg + " DATA SUCCESS.<br/>CASH PAYMENT No : " + this.cashPaymentAccSpv.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("cash-payment-update")
//    public String updateDownPayment(){
//        try {
//                        
//            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
//            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
//            
//            Date TransactionDateTemp = sdf.parse(cashPaymentDownPaymentTemp.getTransactionDateTemp());
//            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
//            cashPaymentDownPaymentUpdate.setTransactionDate(getTransactionDateTemp);
//                        
//            Date createdDateTemp = sdf.parse(cashPaymentDownPaymentTemp.getCreatedDateTemp());
//            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
//            cashPaymentDownPaymentUpdate.setCreatedDate(getCreatedDateTemp);            
//            cashPaymentBLL.updateDownPayment(cashPaymentDownPaymentUpdate);
//
//            this.message ="UPDATE DOWN PAYMENT SUPPLIER DATA SUCCESS.<br/>BANK PAYMENT No : " + this.cashPaymentDownPaymentUpdate.getCode();
//
//            return SUCCESS;
//        } catch (Exception e) {
//            this.error = true;
//            this.errorMessage ="UPDATE DOWN PAYMENT SUPPLIER DATA FAILED.<br/>MESSAGE : " + e.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("cash-payment-delete")
    public String delete(){
        try{
            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(cashPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            cashPaymentBLL.delete(this.cashPayment.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>BANK PAYMENT No : " + this.cashPayment.getCode();
            
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

    public CashPayment getCashPayment() {
        return cashPayment;
    }

    public void setCashPayment(CashPayment cashPayment) {
        this.cashPayment = cashPayment;
    }

    public CashPaymentTemp getCashPaymentTemp() {
        return cashPaymentTemp;
    }

    public void setCashPaymentTemp(CashPaymentTemp cashPaymentTemp) {
        this.cashPaymentTemp = cashPaymentTemp;
    }

    public CashPaymentPaymentRequest getCashPaymentDetailPaymentRequest() {
        return cashPaymentDetailPaymentRequest;
    }

    public void setCashPaymentDetailPaymentRequest(CashPaymentPaymentRequest cashPaymentDetailPaymentRequest) {
        this.cashPaymentDetailPaymentRequest = cashPaymentDetailPaymentRequest;
    }

    public CashPaymentPaymentRequestTemp getCashPaymentDetailPaymentRequestTemp() {
        return cashPaymentDetailPaymentRequestTemp;
    }

    public void setCashPaymentDetailPaymentRequestTemp(CashPaymentPaymentRequestTemp cashPaymentDetailPaymentRequestTemp) {
        this.cashPaymentDetailPaymentRequestTemp = cashPaymentDetailPaymentRequestTemp;
    }

    public CashPaymentDetail getCashPaymentDetail() {
        return cashPaymentDetail;
    }

    public void setCashPaymentDetail(CashPaymentDetail cashPaymentDetail) {
        this.cashPaymentDetail = cashPaymentDetail;
    }

    public CashPaymentDetailTemp getCashPaymentDetailTemp() {
        return cashPaymentDetailTemp;
    }

    public void setCashPaymentDetailTemp(CashPaymentDetailTemp cashPaymentDetailTemp) {
        this.cashPaymentDetailTemp = cashPaymentDetailTemp;
    }

    public List<CashPayment> getListCashPayment() {
        return listCashPayment;
    }

    public void setListCashPayment(List<CashPayment> listCashPayment) {
        this.listCashPayment = listCashPayment;
    }

    public List<CashPaymentTemp> getListCashPaymentTemp() {
        return listCashPaymentTemp;
    }

    public void setListCashPaymentTemp(List<CashPaymentTemp> listCashPaymentTemp) {
        this.listCashPaymentTemp = listCashPaymentTemp;
    }

    public List<CashPaymentPaymentRequest> getListCashPaymentDetailPaymentRequest() {
        return listCashPaymentDetailPaymentRequest;
    }

    public void setListCashPaymentDetailPaymentRequest(List<CashPaymentPaymentRequest> listCashPaymentDetailPaymentRequest) {
        this.listCashPaymentDetailPaymentRequest = listCashPaymentDetailPaymentRequest;
    }

    public List<CashPaymentPaymentRequestTemp> getListCashPaymentDetailPaymentRequestTemp() {
        return listCashPaymentDetailPaymentRequestTemp;
    }

    public void setListCashPaymentDetailPaymentRequestTemp(List<CashPaymentPaymentRequestTemp> listCashPaymentDetailPaymentRequestTemp) {
        this.listCashPaymentDetailPaymentRequestTemp = listCashPaymentDetailPaymentRequestTemp;
    }

    public List<CashPaymentDetail> getListCashPaymentDetail() {
        return listCashPaymentDetail;
    }

    public void setListCashPaymentDetail(List<CashPaymentDetail> listCashPaymentDetail) {
        this.listCashPaymentDetail = listCashPaymentDetail;
    }

    public List<CashPaymentDetailTemp> getListCashPaymentDetailTemp() {
        return listCashPaymentDetailTemp;
    }

    public void setListCashPaymentDetailTemp(List<CashPaymentDetailTemp> listCashPaymentDetailTemp) {
        this.listCashPaymentDetailTemp = listCashPaymentDetailTemp;
    }

    public String getListCashPaymentDetailJSON() {
        return listCashPaymentDetailJSON;
    }

    public void setListCashPaymentDetailJSON(String listCashPaymentDetailJSON) {
        this.listCashPaymentDetailJSON = listCashPaymentDetailJSON;
    }

    public CashPaymentTemp getCashPaymentSearchTemp() {
        return cashPaymentSearchTemp;
    }

    public void setCashPaymentSearchTemp(CashPaymentTemp cashPaymentSearchTemp) {
        this.cashPaymentSearchTemp = cashPaymentSearchTemp;
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

    public String getCashPaymentAccSpvSearchCode() {
        return cashPaymentAccSpvSearchCode;
    }

    public void setCashPaymentAccSpvSearchCode(String cashPaymentAccSpvSearchCode) {
        this.cashPaymentAccSpvSearchCode = cashPaymentAccSpvSearchCode;
    }

    public String getCashPaymentAccSpvSearchPaymentTo() {
        return cashPaymentAccSpvSearchPaymentTo;
    }

    public void setCashPaymentAccSpvSearchPaymentTo(String cashPaymentAccSpvSearchPaymentTo) {
        this.cashPaymentAccSpvSearchPaymentTo = cashPaymentAccSpvSearchPaymentTo;
    }

    public Date getCashPaymentAccSpvSearchFirstDate() {
        return cashPaymentAccSpvSearchFirstDate;
    }

    public void setCashPaymentAccSpvSearchFirstDate(Date cashPaymentAccSpvSearchFirstDate) {
        this.cashPaymentAccSpvSearchFirstDate = cashPaymentAccSpvSearchFirstDate;
    }

    public Date getCashPaymentAccSpvSearchLastDate() {
        return cashPaymentAccSpvSearchLastDate;
    }

    public void setCashPaymentAccSpvSearchLastDate(Date cashPaymentAccSpvSearchLastDate) {
        this.cashPaymentAccSpvSearchLastDate = cashPaymentAccSpvSearchLastDate;
    }

    public CashPayment getCashPaymentAccSpv() {
        return cashPaymentAccSpv;
    }

    public void setCashPaymentAccSpv(CashPayment cashPaymentAccSpv) {
        this.cashPaymentAccSpv = cashPaymentAccSpv;
    }

    public CashPaymentTemp getCashPaymentAccSpvTemp() {
        return cashPaymentAccSpvTemp;
    }

    public void setCashPaymentAccSpvTemp(CashPaymentTemp cashPaymentAccSpvTemp) {
        this.cashPaymentAccSpvTemp = cashPaymentAccSpvTemp;
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
