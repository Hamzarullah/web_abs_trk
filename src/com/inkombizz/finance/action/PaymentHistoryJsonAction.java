/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.PaymentHistoryBLL;
import com.inkombizz.finance.model.PaymentHistoryDetailTemp;
import com.inkombizz.finance.model.PaymentHistoryTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class PaymentHistoryJsonAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private PaymentHistoryTemp paymentHistorySearchTemp = new PaymentHistoryTemp();
    private Date paymentHistoryFirstDate;
    private Date paymentHistoryLastDate;
    private String paymentHistoryDocumentNo;
    private String paymentHistoryDocumentType;
    
    private List<PaymentHistoryTemp> listPaymentHistoryTemp;
    private List<PaymentHistoryDetailTemp> listPaymentHistoryDetailTemp;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("payment-history-data")
    public String findData() {
        try {
            PaymentHistoryBLL paymentHistoryBLL = new PaymentHistoryBLL(hbmSession);
            if(paymentHistoryFirstDate == null){
                paymentHistoryFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            }
            if(paymentHistoryLastDate == null){
                paymentHistoryLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            }
            ListPaging <PaymentHistoryTemp> listPaging = paymentHistoryBLL.findData(paging, paymentHistoryFirstDate, paymentHistoryLastDate, paymentHistorySearchTemp);
            
            listPaymentHistoryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-history-detail-data")
    public String findDataPaymentRequest() {
        try {
            PaymentHistoryBLL paymentHistoryBLL = new PaymentHistoryBLL(hbmSession);
            List<PaymentHistoryDetailTemp> list = paymentHistoryBLL.getDataPaymentHistoryDetail(paymentHistoryDocumentType, paymentHistoryDocumentNo);
            
            listPaymentHistoryDetailTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public PaymentHistoryTemp getPaymentHistorySearchTemp() {
        return paymentHistorySearchTemp;
    }

    public void setPaymentHistorySearchTemp(PaymentHistoryTemp paymentHistorySearchTemp) {
        this.paymentHistorySearchTemp = paymentHistorySearchTemp;
    }

    public Date getPaymentHistoryFirstDate() {
        return paymentHistoryFirstDate;
    }

    public void setPaymentHistoryFirstDate(Date paymentHistoryFirstDate) {
        this.paymentHistoryFirstDate = paymentHistoryFirstDate;
    }

    public Date getPaymentHistoryLastDate() {
        return paymentHistoryLastDate;
    }

    public void setPaymentHistoryLastDate(Date paymentHistoryLastDate) {
        this.paymentHistoryLastDate = paymentHistoryLastDate;
    }

    public String getPaymentHistoryDocumentNo() {
        return paymentHistoryDocumentNo;
    }

    public void setPaymentHistoryDocumentNo(String paymentHistoryDocumentNo) {
        this.paymentHistoryDocumentNo = paymentHistoryDocumentNo;
    }

    public String getPaymentHistoryDocumentType() {
        return paymentHistoryDocumentType;
    }

    public void setPaymentHistoryDocumentType(String paymentHistoryDocumentType) {
        this.paymentHistoryDocumentType = paymentHistoryDocumentType;
    }

    public List<PaymentHistoryTemp> getListPaymentHistoryTemp() {
        return listPaymentHistoryTemp;
    }

    public void setListPaymentHistoryTemp(List<PaymentHistoryTemp> listPaymentHistoryTemp) {
        this.listPaymentHistoryTemp = listPaymentHistoryTemp;
    }

    public List<PaymentHistoryDetailTemp> getListPaymentHistoryDetailTemp() {
        return listPaymentHistoryDetailTemp;
    }

    public void setListPaymentHistoryDetailTemp(List<PaymentHistoryDetailTemp> listPaymentHistoryDetailTemp) {
        this.listPaymentHistoryDetailTemp = listPaymentHistoryDetailTemp;
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
