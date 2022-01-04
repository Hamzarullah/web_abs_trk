
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerOrderDocumentBLL;
import com.inkombizz.sales.model.CustomerOrderDocument;
import com.inkombizz.sales.model.CustomerOrderDocumentDetail;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class CustomerOrderDocumentJsonAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private List<CustomerOrderDocument> listCustomerOrderDocument;
    private CustomerOrderDocument customerOrderDocument;
    
    private List<CustomerOrderDocumentDetail> listCustomerOrderDocumentDetail;
    
    private String financeDepositCode="";
    private Date financeDepositSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date financeDepositSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()); 
    @Override
    public String execute() {
        try {
            return findCustomerOrderDocument();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("customer-order-document-search")
    public String findCustomerOrderDocument() {
        try {
            CustomerOrderDocumentBLL customerOrderDocumentBLL = new CustomerOrderDocumentBLL(hbmSession);
            
            ListPaging<CustomerOrderDocument> listPaging = customerOrderDocumentBLL.findCustomerOrderDocument(paging,customerOrderDocument);
            
            listCustomerOrderDocument = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-order-document-detail-data")
    public String findCustomerOrderDocumentDetail() {
        try {
            CustomerOrderDocumentBLL customerOrderDocumentBLL = new CustomerOrderDocumentBLL(hbmSession);
            
            List<CustomerOrderDocumentDetail> list= customerOrderDocumentBLL.findCustomerOrderDocumentDetail(customerOrderDocument);
            
            listCustomerOrderDocumentDetail = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public List<CustomerOrderDocument> getListCustomerOrderDocument() {
        return listCustomerOrderDocument;
    }

    public void setListCustomerOrderDocument(List<CustomerOrderDocument> listCustomerOrderDocument) {
        this.listCustomerOrderDocument = listCustomerOrderDocument;
    }

    public CustomerOrderDocument getCustomerOrderDocument() {
        return customerOrderDocument;
    }

    public void setCustomerOrderDocument(CustomerOrderDocument customerOrderDocument) {
        this.customerOrderDocument = customerOrderDocument;
    }

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
    
    public List<CustomerOrderDocumentDetail> getListCustomerOrderDocumentDetail() {
        return listCustomerOrderDocumentDetail;
    }

    public void setListCustomerOrderDocumentDetail(List<CustomerOrderDocumentDetail> listCustomerOrderDocumentDetail) {
        this.listCustomerOrderDocumentDetail = listCustomerOrderDocumentDetail;
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
