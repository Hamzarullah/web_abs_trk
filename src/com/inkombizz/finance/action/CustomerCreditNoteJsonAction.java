
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CustomerCreditNoteBLL;
import com.inkombizz.finance.model.CustomerCreditNote;
import com.inkombizz.finance.model.CustomerCreditNoteDetail;
import com.inkombizz.finance.model.CustomerCreditNoteDetailTemp;
import com.inkombizz.finance.model.CustomerCreditNoteTemp;
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
public class CustomerCreditNoteJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerCreditNote customerCreditNote;
    private CustomerCreditNote customerCreditNoteAccSpv;
    private CustomerCreditNoteTemp customerCreditNoteTemp;
    private CustomerCreditNoteTemp customerCreditNoteAccSpvTemp;
    private List<CustomerCreditNote> listCustomerCreditNote;
    private List<CustomerCreditNote> listCustomerCreditNoteAccSpv;
    private List<CustomerCreditNoteDetail> listCustomerCreditNoteDetail;
    private List<CustomerCreditNoteTemp> listCustomerCreditNoteTemp;
    private List<CustomerCreditNoteTemp> listCustomerCreditNoteAccSpvTemp;
    private List<CustomerCreditNoteDetailTemp> listCustomerCreditNoteDetailTemp;
    
    private String listCustomerCreditNoteDetailJSON;
    private String customerCreditNoteSearchCode="";
    private String customerCreditNoteCustomerSearchCode="";
    private String customerCreditNoteCustomerSearchName="";
    private Date customerCreditNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date customerCreditNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String customerCreditNoteAccSpvSearchCode="";
    private String customerCreditNoteAccSpvCustomerSearchCode="";
    private String customerCreditNoteAccSpvCustomerSearchName="";
    private Date customerCreditNoteAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date customerCreditNoteAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String customerCreditNoteAccSpvSearchAccStatus="Open";        
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("customer-credit-note-data")
    public String findData() {
        try {
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            ListPaging <CustomerCreditNoteTemp> listPaging = customerCreditNoteBLL.findData(paging,customerCreditNoteSearchCode,customerCreditNoteCustomerSearchCode,customerCreditNoteCustomerSearchName,customerCreditNoteSearchFirstDate,customerCreditNoteSearchLastDate);
            
            listCustomerCreditNoteTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-credit-note-acc-spv-data")
    public String findDataAccSpv() {
        try {
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            ListPaging <CustomerCreditNoteTemp> listPaging = customerCreditNoteBLL.findDataAccSpv(paging,customerCreditNoteAccSpvSearchCode,customerCreditNoteAccSpvCustomerSearchCode,customerCreditNoteAccSpvCustomerSearchName,customerCreditNoteAccSpvSearchFirstDate,customerCreditNoteAccSpvSearchLastDate,customerCreditNoteAccSpvSearchAccStatus);
            
            listCustomerCreditNoteAccSpvTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-credit-note-detail-data")
    public String findDataDetail(){
        try {
            
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            List<CustomerCreditNoteDetailTemp> list = customerCreditNoteBLL.findDataDetail(customerCreditNote.getCode());

            listCustomerCreditNoteDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("customer-credit-note-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            Gson gson = new Gson();
            this.listCustomerCreditNoteDetail = gson.fromJson(this.listCustomerCreditNoteDetailJSON, new TypeToken<List<CustomerCreditNoteDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(customerCreditNoteTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            customerCreditNote.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(customerCreditNoteTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            customerCreditNote.setCreatedDate(getCreatedDateTemp);
            
            if(customerCreditNoteBLL.isExist(this.customerCreditNote.getCode())){
                _Messg="UPDATED ";

                customerCreditNoteBLL.update(customerCreditNote, listCustomerCreditNoteDetail);
                
            }else{
                
                 _Messg = "SAVED ";
                 customerCreditNoteBLL.save(customerCreditNote, listCustomerCreditNoteDetail);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.customerCreditNote.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-credit-note-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            Gson gson = new Gson();
            this.listCustomerCreditNoteDetail = gson.fromJson(this.listCustomerCreditNoteDetailJSON, new TypeToken<List<CustomerCreditNoteDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(customerCreditNoteAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            customerCreditNoteAccSpv.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(customerCreditNoteAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            customerCreditNoteAccSpv.setCreatedDate(getCreatedDateTemp);
            
            customerCreditNoteBLL.update(customerCreditNoteAccSpv, listCustomerCreditNoteDetail);


            this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.customerCreditNoteAccSpv.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("customer-credit-note-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(customerCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            customerCreditNoteBLL.delete(this.customerCreditNote.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.customerCreditNote.getCode();

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

    public CustomerCreditNote getCustomerCreditNote() {
        return customerCreditNote;
    }

    public void setCustomerCreditNote(CustomerCreditNote customerCreditNote) {
        this.customerCreditNote = customerCreditNote;
    }

    public CustomerCreditNoteTemp getCustomerCreditNoteTemp() {
        return customerCreditNoteTemp;
    }

    public void setCustomerCreditNoteTemp(CustomerCreditNoteTemp customerCreditNoteTemp) {
        this.customerCreditNoteTemp = customerCreditNoteTemp;
    }

    public List<CustomerCreditNote> getListCustomerCreditNote() {
        return listCustomerCreditNote;
    }

    public void setListCustomerCreditNote(List<CustomerCreditNote> listCustomerCreditNote) {
        this.listCustomerCreditNote = listCustomerCreditNote;
    }

    public List<CustomerCreditNoteDetail> getListCustomerCreditNoteDetail() {
        return listCustomerCreditNoteDetail;
    }

    public void setListCustomerCreditNoteDetail(List<CustomerCreditNoteDetail> listCustomerCreditNoteDetail) {
        this.listCustomerCreditNoteDetail = listCustomerCreditNoteDetail;
    }

    public List<CustomerCreditNoteTemp> getListCustomerCreditNoteTemp() {
        return listCustomerCreditNoteTemp;
    }

    public void setListCustomerCreditNoteTemp(List<CustomerCreditNoteTemp> listCustomerCreditNoteTemp) {
        this.listCustomerCreditNoteTemp = listCustomerCreditNoteTemp;
    }

    public List<CustomerCreditNoteDetailTemp> getListCustomerCreditNoteDetailTemp() {
        return listCustomerCreditNoteDetailTemp;
    }

    public void setListCustomerCreditNoteDetailTemp(List<CustomerCreditNoteDetailTemp> listCustomerCreditNoteDetailTemp) {
        this.listCustomerCreditNoteDetailTemp = listCustomerCreditNoteDetailTemp;
    }

    public String getListCustomerCreditNoteDetailJSON() {
        return listCustomerCreditNoteDetailJSON;
    }

    public void setListCustomerCreditNoteDetailJSON(String listCustomerCreditNoteDetailJSON) {
        this.listCustomerCreditNoteDetailJSON = listCustomerCreditNoteDetailJSON;
    }

    public String getCustomerCreditNoteSearchCode() {
        return customerCreditNoteSearchCode;
    }

    public void setCustomerCreditNoteSearchCode(String customerCreditNoteSearchCode) {
        this.customerCreditNoteSearchCode = customerCreditNoteSearchCode;
    }

    public String getCustomerCreditNoteCustomerSearchCode() {
        return customerCreditNoteCustomerSearchCode;
    }

    public void setCustomerCreditNoteCustomerSearchCode(String customerCreditNoteCustomerSearchCode) {
        this.customerCreditNoteCustomerSearchCode = customerCreditNoteCustomerSearchCode;
    }

    public String getCustomerCreditNoteCustomerSearchName() {
        return customerCreditNoteCustomerSearchName;
    }

    public void setCustomerCreditNoteCustomerSearchName(String customerCreditNoteCustomerSearchName) {
        this.customerCreditNoteCustomerSearchName = customerCreditNoteCustomerSearchName;
    }

    public Date getCustomerCreditNoteSearchFirstDate() {
        return customerCreditNoteSearchFirstDate;
    }

    public void setCustomerCreditNoteSearchFirstDate(Date customerCreditNoteSearchFirstDate) {
        this.customerCreditNoteSearchFirstDate = customerCreditNoteSearchFirstDate;
    }

    public Date getCustomerCreditNoteSearchLastDate() {
        return customerCreditNoteSearchLastDate;
    }

    public void setCustomerCreditNoteSearchLastDate(Date customerCreditNoteSearchLastDate) {
        this.customerCreditNoteSearchLastDate = customerCreditNoteSearchLastDate;
    }

    public CustomerCreditNote getCustomerCreditNoteAccSpv() {
        return customerCreditNoteAccSpv;
    }

    public void setCustomerCreditNoteAccSpv(CustomerCreditNote customerCreditNoteAccSpv) {
        this.customerCreditNoteAccSpv = customerCreditNoteAccSpv;
    }

    public CustomerCreditNoteTemp getCustomerCreditNoteAccSpvTemp() {
        return customerCreditNoteAccSpvTemp;
    }

    public void setCustomerCreditNoteAccSpvTemp(CustomerCreditNoteTemp customerCreditNoteAccSpvTemp) {
        this.customerCreditNoteAccSpvTemp = customerCreditNoteAccSpvTemp;
    }

    public List<CustomerCreditNote> getListCustomerCreditNoteAccSpv() {
        return listCustomerCreditNoteAccSpv;
    }

    public void setListCustomerCreditNoteAccSpv(List<CustomerCreditNote> listCustomerCreditNoteAccSpv) {
        this.listCustomerCreditNoteAccSpv = listCustomerCreditNoteAccSpv;
    }

    public List<CustomerCreditNoteTemp> getListCustomerCreditNoteAccSpvTemp() {
        return listCustomerCreditNoteAccSpvTemp;
    }

    public void setListCustomerCreditNoteAccSpvTemp(List<CustomerCreditNoteTemp> listCustomerCreditNoteAccSpvTemp) {
        this.listCustomerCreditNoteAccSpvTemp = listCustomerCreditNoteAccSpvTemp;
    }

    public String getCustomerCreditNoteAccSpvSearchCode() {
        return customerCreditNoteAccSpvSearchCode;
    }

    public void setCustomerCreditNoteAccSpvSearchCode(String customerCreditNoteAccSpvSearchCode) {
        this.customerCreditNoteAccSpvSearchCode = customerCreditNoteAccSpvSearchCode;
    }

    public String getCustomerCreditNoteAccSpvCustomerSearchCode() {
        return customerCreditNoteAccSpvCustomerSearchCode;
    }

    public void setCustomerCreditNoteAccSpvCustomerSearchCode(String customerCreditNoteAccSpvCustomerSearchCode) {
        this.customerCreditNoteAccSpvCustomerSearchCode = customerCreditNoteAccSpvCustomerSearchCode;
    }

    public String getCustomerCreditNoteAccSpvCustomerSearchName() {
        return customerCreditNoteAccSpvCustomerSearchName;
    }

    public void setCustomerCreditNoteAccSpvCustomerSearchName(String customerCreditNoteAccSpvCustomerSearchName) {
        this.customerCreditNoteAccSpvCustomerSearchName = customerCreditNoteAccSpvCustomerSearchName;
    }

    public Date getCustomerCreditNoteAccSpvSearchFirstDate() {
        return customerCreditNoteAccSpvSearchFirstDate;
    }

    public void setCustomerCreditNoteAccSpvSearchFirstDate(Date customerCreditNoteAccSpvSearchFirstDate) {
        this.customerCreditNoteAccSpvSearchFirstDate = customerCreditNoteAccSpvSearchFirstDate;
    }

    public Date getCustomerCreditNoteAccSpvSearchLastDate() {
        return customerCreditNoteAccSpvSearchLastDate;
    }

    public void setCustomerCreditNoteAccSpvSearchLastDate(Date customerCreditNoteAccSpvSearchLastDate) {
        this.customerCreditNoteAccSpvSearchLastDate = customerCreditNoteAccSpvSearchLastDate;
    }

    public String getCustomerCreditNoteAccSpvSearchAccStatus() {
        return customerCreditNoteAccSpvSearchAccStatus;
    }

    public void setCustomerCreditNoteAccSpvSearchAccStatus(String customerCreditNoteAccSpvSearchAccStatus) {
        this.customerCreditNoteAccSpvSearchAccStatus = customerCreditNoteAccSpvSearchAccStatus;
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
