
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CustomerDebitNoteBLL;
import com.inkombizz.finance.model.CustomerDebitNote;
import com.inkombizz.finance.model.CustomerDebitNoteDetail;
import com.inkombizz.finance.model.CustomerDebitNoteDetailTemp;
import com.inkombizz.finance.model.CustomerDebitNoteTemp;
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
public class CustomerDebitNoteJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerDebitNote customerDebitNote;
    private CustomerDebitNote customerDebitNoteAccSpv;
    private CustomerDebitNoteTemp customerDebitNoteTemp;
    private CustomerDebitNoteTemp customerDebitNoteAccSpvTemp;
    private List<CustomerDebitNote> listCustomerDebitNote;
    private List<CustomerDebitNoteDetail> listCustomerDebitNoteDetail;
    private List<CustomerDebitNoteTemp> listCustomerDebitNoteTemp;
    private List<CustomerDebitNoteTemp> listCustomerDebitNoteAccSpvTemp;
    private List<CustomerDebitNoteDetailTemp> listCustomerDebitNoteDetailTemp;
    
    private String listCustomerDebitNoteDetailJSON;
    private String customerDebitNoteSearchCode="";
    private String customerDebitNoteCustomerSearchCode="";
    private String customerDebitNoteCustomerSearchName="";
    private Date customerDebitNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date customerDebitNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String customerDebitNoteAccSpvSearchCode="";
    private String customerDebitNoteAccSpvCustomerSearchCode="";
    private String customerDebitNoteAccSpvCustomerSearchName="";
    private Date customerDebitNoteAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date customerDebitNoteAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String customerDebitNoteAccSpvSearchAccStatus="Open";      
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("customer-debit-note-data")
    public String findData() {
        try {
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            ListPaging <CustomerDebitNoteTemp> listPaging = customerDebitNoteBLL.findData(paging,customerDebitNoteSearchCode,customerDebitNoteCustomerSearchCode,customerDebitNoteCustomerSearchName,customerDebitNoteSearchFirstDate,customerDebitNoteSearchLastDate);
            
            listCustomerDebitNoteTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-debit-note-detail-data")
    public String findDataDetail(){
        try {
            
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            List<CustomerDebitNoteDetailTemp> list = customerDebitNoteBLL.findDataDetail(customerDebitNote.getCode());

            listCustomerDebitNoteDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   @Action("customer-debit-note-acc-spv-data")
    public String findDataAccSpv() {
        try {
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            ListPaging <CustomerDebitNoteTemp> listPaging = customerDebitNoteBLL.findDataAccSpv(paging,customerDebitNoteAccSpvSearchCode,customerDebitNoteAccSpvCustomerSearchCode,customerDebitNoteAccSpvCustomerSearchName,customerDebitNoteAccSpvSearchFirstDate,customerDebitNoteAccSpvSearchLastDate,customerDebitNoteAccSpvSearchAccStatus);
            
            listCustomerDebitNoteAccSpvTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-debit-note-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            Gson gson = new Gson();
            this.listCustomerDebitNoteDetail = gson.fromJson(this.listCustomerDebitNoteDetailJSON, new TypeToken<List<CustomerDebitNoteDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(customerDebitNoteAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            customerDebitNoteAccSpv.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(customerDebitNoteAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            customerDebitNoteAccSpv.setCreatedDate(getCreatedDateTemp);
            
            customerDebitNoteBLL.update(customerDebitNoteAccSpv, listCustomerDebitNoteDetail);


            this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.customerDebitNoteAccSpv.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-debit-note-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            Gson gson = new Gson();
            this.listCustomerDebitNoteDetail = gson.fromJson(this.listCustomerDebitNoteDetailJSON, new TypeToken<List<CustomerDebitNoteDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(customerDebitNoteTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            customerDebitNote.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(customerDebitNoteTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            customerDebitNote.setCreatedDate(getCreatedDateTemp);
            
            if(customerDebitNoteBLL.isExist(this.customerDebitNote.getCode())){
                _Messg="UPDATED ";

                customerDebitNoteBLL.update(customerDebitNote, listCustomerDebitNoteDetail);
                
            }else{
                
                 _Messg = "SAVED ";
                 customerDebitNoteBLL.save(customerDebitNote, listCustomerDebitNoteDetail);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.customerDebitNote.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("customer-debit-note-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(customerDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            customerDebitNoteBLL.delete(this.customerDebitNote.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.customerDebitNote.getCode();

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

    public CustomerDebitNote getCustomerDebitNote() {
        return customerDebitNote;
    }

    public void setCustomerDebitNote(CustomerDebitNote customerDebitNote) {
        this.customerDebitNote = customerDebitNote;
    }

    public CustomerDebitNoteTemp getCustomerDebitNoteTemp() {
        return customerDebitNoteTemp;
    }

    public void setCustomerDebitNoteTemp(CustomerDebitNoteTemp customerDebitNoteTemp) {
        this.customerDebitNoteTemp = customerDebitNoteTemp;
    }

    public List<CustomerDebitNote> getListCustomerDebitNote() {
        return listCustomerDebitNote;
    }

    public void setListCustomerDebitNote(List<CustomerDebitNote> listCustomerDebitNote) {
        this.listCustomerDebitNote = listCustomerDebitNote;
    }

    public List<CustomerDebitNoteDetail> getListCustomerDebitNoteDetail() {
        return listCustomerDebitNoteDetail;
    }

    public void setListCustomerDebitNoteDetail(List<CustomerDebitNoteDetail> listCustomerDebitNoteDetail) {
        this.listCustomerDebitNoteDetail = listCustomerDebitNoteDetail;
    }

    public List<CustomerDebitNoteTemp> getListCustomerDebitNoteTemp() {
        return listCustomerDebitNoteTemp;
    }

    public void setListCustomerDebitNoteTemp(List<CustomerDebitNoteTemp> listCustomerDebitNoteTemp) {
        this.listCustomerDebitNoteTemp = listCustomerDebitNoteTemp;
    }

    public List<CustomerDebitNoteDetailTemp> getListCustomerDebitNoteDetailTemp() {
        return listCustomerDebitNoteDetailTemp;
    }

    public void setListCustomerDebitNoteDetailTemp(List<CustomerDebitNoteDetailTemp> listCustomerDebitNoteDetailTemp) {
        this.listCustomerDebitNoteDetailTemp = listCustomerDebitNoteDetailTemp;
    }

    public String getListCustomerDebitNoteDetailJSON() {
        return listCustomerDebitNoteDetailJSON;
    }

    public void setListCustomerDebitNoteDetailJSON(String listCustomerDebitNoteDetailJSON) {
        this.listCustomerDebitNoteDetailJSON = listCustomerDebitNoteDetailJSON;
    }

    public String getCustomerDebitNoteSearchCode() {
        return customerDebitNoteSearchCode;
    }

    public void setCustomerDebitNoteSearchCode(String customerDebitNoteSearchCode) {
        this.customerDebitNoteSearchCode = customerDebitNoteSearchCode;
    }

    public String getCustomerDebitNoteCustomerSearchCode() {
        return customerDebitNoteCustomerSearchCode;
    }

    public void setCustomerDebitNoteCustomerSearchCode(String customerDebitNoteCustomerSearchCode) {
        this.customerDebitNoteCustomerSearchCode = customerDebitNoteCustomerSearchCode;
    }

    public String getCustomerDebitNoteCustomerSearchName() {
        return customerDebitNoteCustomerSearchName;
    }

    public void setCustomerDebitNoteCustomerSearchName(String customerDebitNoteCustomerSearchName) {
        this.customerDebitNoteCustomerSearchName = customerDebitNoteCustomerSearchName;
    }

    public Date getCustomerDebitNoteSearchFirstDate() {
        return customerDebitNoteSearchFirstDate;
    }

    public void setCustomerDebitNoteSearchFirstDate(Date customerDebitNoteSearchFirstDate) {
        this.customerDebitNoteSearchFirstDate = customerDebitNoteSearchFirstDate;
    }

    public Date getCustomerDebitNoteSearchLastDate() {
        return customerDebitNoteSearchLastDate;
    }

    public void setCustomerDebitNoteSearchLastDate(Date customerDebitNoteSearchLastDate) {
        this.customerDebitNoteSearchLastDate = customerDebitNoteSearchLastDate;
    }

    public String getCustomerDebitNoteAccSpvSearchCode() {
        return customerDebitNoteAccSpvSearchCode;
    }

    public void setCustomerDebitNoteAccSpvSearchCode(String customerDebitNoteAccSpvSearchCode) {
        this.customerDebitNoteAccSpvSearchCode = customerDebitNoteAccSpvSearchCode;
    }

    public String getCustomerDebitNoteAccSpvCustomerSearchCode() {
        return customerDebitNoteAccSpvCustomerSearchCode;
    }

    public void setCustomerDebitNoteAccSpvCustomerSearchCode(String customerDebitNoteAccSpvCustomerSearchCode) {
        this.customerDebitNoteAccSpvCustomerSearchCode = customerDebitNoteAccSpvCustomerSearchCode;
    }

    public String getCustomerDebitNoteAccSpvCustomerSearchName() {
        return customerDebitNoteAccSpvCustomerSearchName;
    }

    public void setCustomerDebitNoteAccSpvCustomerSearchName(String customerDebitNoteAccSpvCustomerSearchName) {
        this.customerDebitNoteAccSpvCustomerSearchName = customerDebitNoteAccSpvCustomerSearchName;
    }

    public Date getCustomerDebitNoteAccSpvSearchFirstDate() {
        return customerDebitNoteAccSpvSearchFirstDate;
    }

    public void setCustomerDebitNoteAccSpvSearchFirstDate(Date customerDebitNoteAccSpvSearchFirstDate) {
        this.customerDebitNoteAccSpvSearchFirstDate = customerDebitNoteAccSpvSearchFirstDate;
    }

    public Date getCustomerDebitNoteAccSpvSearchLastDate() {
        return customerDebitNoteAccSpvSearchLastDate;
    }

    public void setCustomerDebitNoteAccSpvSearchLastDate(Date customerDebitNoteAccSpvSearchLastDate) {
        this.customerDebitNoteAccSpvSearchLastDate = customerDebitNoteAccSpvSearchLastDate;
    }

    public String getCustomerDebitNoteAccSpvSearchAccStatus() {
        return customerDebitNoteAccSpvSearchAccStatus;
    }

    public void setCustomerDebitNoteAccSpvSearchAccStatus(String customerDebitNoteAccSpvSearchAccStatus) {
        this.customerDebitNoteAccSpvSearchAccStatus = customerDebitNoteAccSpvSearchAccStatus;
    }

    public List<CustomerDebitNoteTemp> getListCustomerDebitNoteAccSpvTemp() {
        return listCustomerDebitNoteAccSpvTemp;
    }

    public void setListCustomerDebitNoteAccSpvTemp(List<CustomerDebitNoteTemp> listCustomerDebitNoteAccSpvTemp) {
        this.listCustomerDebitNoteAccSpvTemp = listCustomerDebitNoteAccSpvTemp;
    }

    public CustomerDebitNote getCustomerDebitNoteAccSpv() {
        return customerDebitNoteAccSpv;
    }

    public void setCustomerDebitNoteAccSpv(CustomerDebitNote customerDebitNoteAccSpv) {
        this.customerDebitNoteAccSpv = customerDebitNoteAccSpv;
    }

    public CustomerDebitNoteTemp getCustomerDebitNoteAccSpvTemp() {
        return customerDebitNoteAccSpvTemp;
    }

    public void setCustomerDebitNoteAccSpvTemp(CustomerDebitNoteTemp customerDebitNoteAccSpvTemp) {
        this.customerDebitNoteAccSpvTemp = customerDebitNoteAccSpvTemp;
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
