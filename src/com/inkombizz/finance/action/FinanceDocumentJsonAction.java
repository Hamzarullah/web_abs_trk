
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.FinanceDocumentBLL;
import com.inkombizz.finance.model.FinanceDocumentTemp;
//import com.inkombizz.inventory.model.GoodsReceivedNoteDepositDetailTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class FinanceDocumentJsonAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private List<FinanceDocumentTemp> listFinanceDocumentTemp;
//    private List<GoodsReceivedNoteDepositDetailTemp> listGoodsReceivedNoteDepositDetailTemp;
    private FinanceDocumentTemp financeDocument;
    private FinanceDocumentTemp financeRequest;
    
    private String financeDepositCode="";
    private Date financeDepositSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date financeDepositSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()); 
    @Override
    public String execute() {
        try {
            return findFinanceDocument();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("finance-document-search")
    public String findFinanceDocument() {
        try {
            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
            
            ListPaging <FinanceDocumentTemp> listPaging = financeDocumentBLL.findFinanceDocument(paging,financeDocument);
            
            listFinanceDocumentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("finance-request-search")
    public String findFinanceRequest() {
        try {
            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
            
            ListPaging <FinanceDocumentTemp> listPaging = financeDocumentBLL.findFinanceDocument(paging,financeDocument);
            
            listFinanceDocumentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("finance-deposit-search")
//    public String findFinanceDeposit() {
//        try {
//            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
//            
//            ListPaging <GoodsReceivedNoteDepositDetailTemp> listPaging = financeDocumentBLL.findFinanceDeposit(paging,financeDepositCode,financeDepositSearchFirstDate,financeDepositSearchLastDate);
//            
//            listGoodsReceivedNoteDepositDetailTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
//    @Action("finance-deposit-payment-search")
//    public String findFinanceDepositPayment() {
//        try {
//            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
//            
//            ListPaging <GoodsReceivedNoteDepositDetailTemp> listPaging = financeDocumentBLL.findFinanceDepositPayment(paging,financeDepositCode,financeDepositSearchFirstDate,financeDepositSearchLastDate);
//            
//            listGoodsReceivedNoteDepositDetailTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("finance-document-existing")
    public String findDataFinanceExisting() {
        try {
            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
            List<FinanceDocumentTemp> list = financeDocumentBLL.findDataFinanceExisting(this.financeDocument.getDocumentNo());
            
            listFinanceDocumentTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("finance-document-existing-payment-request")
    public String findDataFinanceExistingPaymentRequest() {
        try {
            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
            List<FinanceDocumentTemp> list = financeDocumentBLL.findDataPaymentRequestExisting(this.financeDocument.getDocumentNo());
            
            listFinanceDocumentTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("finance-document-existing-payment-request-in-bank-payment")
    public String findDataFinanceExistingPaymentRequestInBankPayment() {
        try {
            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);
            List<FinanceDocumentTemp> list = financeDocumentBLL.findDataPaymentRequestExistingBankPayment(this.financeDocument.getDocumentNo());
            
            listFinanceDocumentTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public List<FinanceDocumentTemp> getListFinanceDocumentTemp() {
        return listFinanceDocumentTemp;
    }

    public void setListFinanceDocumentTemp(List<FinanceDocumentTemp> listFinanceDocumentTemp) {
        this.listFinanceDocumentTemp = listFinanceDocumentTemp;
    }

    public FinanceDocumentTemp getFinanceDocument() {
        return financeDocument;
    }

    public void setFinanceDocument(FinanceDocumentTemp financeDocument) {
        this.financeDocument = financeDocument;
    }

//    public List<GoodsReceivedNoteDepositDetailTemp> getListGoodsReceivedNoteDepositDetailTemp() {
//        return listGoodsReceivedNoteDepositDetailTemp;
//    }
//
//    public void setListGoodsReceivedNoteDepositDetailTemp(List<GoodsReceivedNoteDepositDetailTemp> listGoodsReceivedNoteDepositDetailTemp) {
//        this.listGoodsReceivedNoteDepositDetailTemp = listGoodsReceivedNoteDepositDetailTemp;
//    }

    public String getFinanceDepositCode() {
        return financeDepositCode;
    }

    public void setFinanceDepositCode(String financeDepositCode) {
        this.financeDepositCode = financeDepositCode;
    }

    public Date getFinanceDepositSearchFirstDate() {
        return financeDepositSearchFirstDate;
    }

    public void setFinanceDepositSearchFirstDate(Date financeDepositSearchFirstDate) {
        this.financeDepositSearchFirstDate = financeDepositSearchFirstDate;
    }

    public Date getFinanceDepositSearchLastDate() {
        return financeDepositSearchLastDate;
    }

    public void setFinanceDepositSearchLastDate(Date financeDepositSearchLastDate) {
        this.financeDepositSearchLastDate = financeDepositSearchLastDate;
    }

    public FinanceDocumentTemp getFinanceRequest() {
        return financeRequest;
    }

    public void setFinanceRequest(FinanceDocumentTemp financeRequest) {
        this.financeRequest = financeRequest;
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
