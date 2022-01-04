package com.inkombizz.system.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.bll.TransactionLogBLL;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.system.model.TransactionLog;
import com.inkombizz.system.model.TransactionLogTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import org.apache.struts2.convention.annotation.Action;

@Result(type = "json")
public class TransactionLogJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private TransactionLog transactionLog;
    private TransactionLogTemp transactionLogTemp;
    private List<TransactionLog> listTransactionLog;
    private List<TransactionLogTemp> listTransactionLogTemp;
    

  
    private String transactionLogSearchTransactionCode="";
    private String transactionLogSearchActionType="ALL";
    private String transactionLogSearchModuleCode="";
    private String transactionLogSearchUserCode="";
    Date transactionLogSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date transactionLogSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
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
    

    @Action("transaction-log-data")
    public String findData() {
        try {
            TransactionLogBLL transactionLogBLL = new TransactionLogBLL(hbmSession);
            
            ListPaging<TransactionLogTemp> listPaging = transactionLogBLL.findData(paging,transactionLogSearchTransactionCode,transactionLogSearchActionType,transactionLogSearchModuleCode,transactionLogSearchUserCode,transactionLogSearchFirstDate,transactionLogSearchLastDate);

            listTransactionLogTemp = listPaging.getList();

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

    public TransactionLog getTransactionLog() {
        return transactionLog;
    }

    public void setTransactionLog(TransactionLog transactionLog) {
        this.transactionLog = transactionLog;
    }

    public TransactionLogTemp getTransactionLogTemp() {
        return transactionLogTemp;
    }

    public void setTransactionLogTemp(TransactionLogTemp transactionLogTemp) {
        this.transactionLogTemp = transactionLogTemp;
    }

    public List<TransactionLog> getListTransactionLog() {
        return listTransactionLog;
    }

    public void setListTransactionLog(List<TransactionLog> listTransactionLog) {
        this.listTransactionLog = listTransactionLog;
    }

    public List<TransactionLogTemp> getListTransactionLogTemp() {
        return listTransactionLogTemp;
    }

    public void setListTransactionLogTemp(List<TransactionLogTemp> listTransactionLogTemp) {
        this.listTransactionLogTemp = listTransactionLogTemp;
    }

    
    public String getTransactionLogSearchTransactionCode() {
        return transactionLogSearchTransactionCode;
    }

    public void setTransactionLogSearchTransactionCode(String transactionLogSearchTransactionCode) {
        this.transactionLogSearchTransactionCode = transactionLogSearchTransactionCode;
    }

    public Date getTransactionLogSearchFirstDate() {
        return transactionLogSearchFirstDate;
    }

    public void setTransactionLogSearchFirstDate(Date transactionLogSearchFirstDate) {
        this.transactionLogSearchFirstDate = transactionLogSearchFirstDate;
    }

    public Date getTransactionLogSearchLastDate() {
        return transactionLogSearchLastDate;
    }

    public void setTransactionLogSearchLastDate(Date transactionLogSearchLastDate) {
        this.transactionLogSearchLastDate = transactionLogSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getTransactionLogSearchActionType() {
        return transactionLogSearchActionType;
    }

    public void setTransactionLogSearchActionType(String transactionLogSearchActionType) {
        this.transactionLogSearchActionType = transactionLogSearchActionType;
    }

    public String getTransactionLogSearchModuleCode() {
        return transactionLogSearchModuleCode;
    }

    public void setTransactionLogSearchModuleCode(String transactionLogSearchModuleCode) {
        this.transactionLogSearchModuleCode = transactionLogSearchModuleCode;
    }

    public String getTransactionLogSearchUserCode() {
        return transactionLogSearchUserCode;
    }

    public void setTransactionLogSearchUserCode(String transactionLogSearchUserCode) {
        this.transactionLogSearchUserCode = transactionLogSearchUserCode;
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