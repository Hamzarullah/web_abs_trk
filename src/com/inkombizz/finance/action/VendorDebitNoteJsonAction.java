
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.VendorDebitNoteDetailTemp;
import com.inkombizz.finance.bll.VendorDebitNoteBLL;
import com.inkombizz.finance.model.VendorDebitNote;
import com.inkombizz.finance.model.VendorDebitNoteDetail;
import com.inkombizz.finance.model.VendorDebitNoteTemp;
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
public class VendorDebitNoteJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorDebitNote vendorDebitNote;
    private VendorDebitNote vendorDebitNoteAccSpv;
    private VendorDebitNoteTemp vendorDebitNoteTemp;
    private VendorDebitNoteTemp vendorDebitNoteAccSpvTemp;
    private List<VendorDebitNote> listVendorDebitNote;
    private List<VendorDebitNoteDetail> listVendorDebitNoteDetail;
    private List<VendorDebitNoteTemp> listVendorDebitNoteTemp;
    private List<VendorDebitNoteTemp> listVendorDebitNoteAccSpvTemp;
    private List<VendorDebitNoteDetailTemp> listVendorDebitNoteDetailTemp;
    
    private String listVendorDebitNoteDetailJSON;
    private String vendorDebitNoteSearchCode="";
    private String vendorDebitNoteVendorSearchCode="";
    private String vendorDebitNoteVendorSearchName="";
    private Date vendorDebitNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorDebitNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String vendorDebitNoteAccSpvSearchCode="";
    private String vendorDebitNoteAccSpvVendorSearchCode="";
    private String vendorDebitNoteAccSpvVendorSearchName="";
    private Date vendorDebitNoteAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorDebitNoteAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String vendorDebitNoteAccSpvSearchAccStatus="Open";        

    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("vendor-debit-note-data")
    public String findData() {
        try {
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            ListPaging <VendorDebitNoteTemp> listPaging = vendorDebitNoteBLL.findData(paging,vendorDebitNoteSearchCode,vendorDebitNoteVendorSearchCode,vendorDebitNoteVendorSearchName, vendorDebitNoteSearchFirstDate, vendorDebitNoteSearchLastDate);
            
            listVendorDebitNoteTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-debit-note-detail-data")
    public String findDataDetail(){
        try {
            
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            List<VendorDebitNoteDetailTemp> list = vendorDebitNoteBLL.findDataDetail(vendorDebitNote.getCode());

            listVendorDebitNoteDetailTemp = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("vendor-debit-note-acc-spv-data")
    public String findDataAccSpv() {
        try {
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            ListPaging <VendorDebitNoteTemp> listPaging = vendorDebitNoteBLL.findDataAccSpv(paging,vendorDebitNoteAccSpvSearchCode,vendorDebitNoteAccSpvVendorSearchCode,vendorDebitNoteAccSpvVendorSearchName,vendorDebitNoteAccSpvSearchFirstDate,vendorDebitNoteAccSpvSearchLastDate,vendorDebitNoteAccSpvSearchAccStatus);
            
            listVendorDebitNoteAccSpvTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("vendor-debit-note-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            Gson gson = new Gson();
            this.listVendorDebitNoteDetail = gson.fromJson(this.listVendorDebitNoteDetailJSON, new TypeToken<List<VendorDebitNoteDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(vendorDebitNoteAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            vendorDebitNoteAccSpv.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(vendorDebitNoteAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            vendorDebitNoteAccSpv.setCreatedDate(getCreatedDateTemp);
            
            vendorDebitNoteBLL.updateAccSpv(vendorDebitNoteAccSpv, listVendorDebitNoteDetail);


            this.message = _Messg + " DATA SUCCESS.<br/>VDN No : " + this.vendorDebitNoteAccSpv.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("vendor-debit-note-save")
    public String save(){
        String _Messg = "";
        try {
                        
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            Gson gson = new Gson();
            
            this.listVendorDebitNoteDetail = gson.fromJson(this.listVendorDebitNoteDetailJSON, new TypeToken<List<VendorDebitNoteDetail>>(){}.getType());
            
           SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date transactionDateTemp = sdf.parse(vendorDebitNoteTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(transactionDateTemp.getTime());
            Date createdTemp = sdf.parse(vendorDebitNoteTemp.getCreatedDateTemp());
            Date getCreatedTemp = new java.sql.Timestamp(createdTemp.getTime()); 
            
            vendorDebitNote.setTransactionDate(getTransactionDateTemp);
            vendorDebitNote.setCreatedDate(getCreatedTemp);
            
            if(vendorDebitNoteBLL.isExist(this.vendorDebitNote.getCode())){
                _Messg="UPDATED ";

                vendorDebitNoteBLL.update(vendorDebitNote, listVendorDebitNoteDetail);
                
            }else{
                
                 _Messg = "SAVED ";
                 vendorDebitNoteBLL.save(vendorDebitNote, listVendorDebitNoteDetail);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>SDN No : " + this.vendorDebitNote.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    
    @Action("vendor-debit-note-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
                        
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(vendorDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            vendorDebitNoteBLL.delete(vendorDebitNote.getCode());

            this.message = _Messg + " DATA SUCCESS.<br/>SDN No : " + this.vendorDebitNote.getCode();

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

    public VendorDebitNote getVendorDebitNote() {
        return vendorDebitNote;
    }

    public void setVendorDebitNote(VendorDebitNote vendorDebitNote) {
        this.vendorDebitNote = vendorDebitNote;
    }

    public VendorDebitNoteTemp getVendorDebitNoteTemp() {
        return vendorDebitNoteTemp;
    }

    public void setVendorDebitNoteTemp(VendorDebitNoteTemp vendorDebitNoteTemp) {
        this.vendorDebitNoteTemp = vendorDebitNoteTemp;
    }

    public List<VendorDebitNote> getListVendorDebitNote() {
        return listVendorDebitNote;
    }

    public void setListVendorDebitNote(List<VendorDebitNote> listVendorDebitNote) {
        this.listVendorDebitNote = listVendorDebitNote;
    }

    public List<VendorDebitNoteDetail> getListVendorDebitNoteDetail() {
        return listVendorDebitNoteDetail;
    }

    public void setListVendorDebitNoteDetail(List<VendorDebitNoteDetail> listVendorDebitNoteDetail) {
        this.listVendorDebitNoteDetail = listVendorDebitNoteDetail;
    }

    public List<VendorDebitNoteTemp> getListVendorDebitNoteTemp() {
        return listVendorDebitNoteTemp;
    }

    public void setListVendorDebitNoteTemp(List<VendorDebitNoteTemp> listVendorDebitNoteTemp) {
        this.listVendorDebitNoteTemp = listVendorDebitNoteTemp;
    }

    public List<VendorDebitNoteDetailTemp> getListVendorDebitNoteDetailTemp() {
        return listVendorDebitNoteDetailTemp;
    }

    public void setListVendorDebitNoteDetailTemp(List<VendorDebitNoteDetailTemp> listVendorDebitNoteDetailTemp) {
        this.listVendorDebitNoteDetailTemp = listVendorDebitNoteDetailTemp;
    }

    public String getListVendorDebitNoteDetailJSON() {
        return listVendorDebitNoteDetailJSON;
    }

    public void setListVendorDebitNoteDetailJSON(String listVendorDebitNoteDetailJSON) {
        this.listVendorDebitNoteDetailJSON = listVendorDebitNoteDetailJSON;
    }

    public String getVendorDebitNoteSearchCode() {
        return vendorDebitNoteSearchCode;
    }

    public void setVendorDebitNoteSearchCode(String vendorDebitNoteSearchCode) {
        this.vendorDebitNoteSearchCode = vendorDebitNoteSearchCode;
    }

    public String getVendorDebitNoteVendorSearchCode() {
        return vendorDebitNoteVendorSearchCode;
    }

    public void setVendorDebitNoteVendorSearchCode(String vendorDebitNoteVendorSearchCode) {
        this.vendorDebitNoteVendorSearchCode = vendorDebitNoteVendorSearchCode;
    }

    public String getVendorDebitNoteVendorSearchName() {
        return vendorDebitNoteVendorSearchName;
    }

    public void setVendorDebitNoteVendorSearchName(String vendorDebitNoteVendorSearchName) {
        this.vendorDebitNoteVendorSearchName = vendorDebitNoteVendorSearchName;
    }

    public Date getVendorDebitNoteSearchFirstDate() {
        return vendorDebitNoteSearchFirstDate;
    }

    public void setVendorDebitNoteSearchFirstDate(Date vendorDebitNoteSearchFirstDate) {
        this.vendorDebitNoteSearchFirstDate = vendorDebitNoteSearchFirstDate;
    }

    public Date getVendorDebitNoteSearchLastDate() {
        return vendorDebitNoteSearchLastDate;
    }

    public void setVendorDebitNoteSearchLastDate(Date vendorDebitNoteSearchLastDate) {
        this.vendorDebitNoteSearchLastDate = vendorDebitNoteSearchLastDate;
    }

    public VendorDebitNote getVendorDebitNoteAccSpv() {
        return vendorDebitNoteAccSpv;
    }

    public void setVendorDebitNoteAccSpv(VendorDebitNote vendorDebitNoteAccSpv) {
        this.vendorDebitNoteAccSpv = vendorDebitNoteAccSpv;
    }

    public VendorDebitNoteTemp getVendorDebitNoteAccSpvTemp() {
        return vendorDebitNoteAccSpvTemp;
    }

    public void setVendorDebitNoteAccSpvTemp(VendorDebitNoteTemp vendorDebitNoteAccSpvTemp) {
        this.vendorDebitNoteAccSpvTemp = vendorDebitNoteAccSpvTemp;
    }

    public List<VendorDebitNoteTemp> getListVendorDebitNoteAccSpvTemp() {
        return listVendorDebitNoteAccSpvTemp;
    }

    public void setListVendorDebitNoteAccSpvTemp(List<VendorDebitNoteTemp> listVendorDebitNoteAccSpvTemp) {
        this.listVendorDebitNoteAccSpvTemp = listVendorDebitNoteAccSpvTemp;
    }

    public String getVendorDebitNoteAccSpvSearchCode() {
        return vendorDebitNoteAccSpvSearchCode;
    }

    public void setVendorDebitNoteAccSpvSearchCode(String vendorDebitNoteAccSpvSearchCode) {
        this.vendorDebitNoteAccSpvSearchCode = vendorDebitNoteAccSpvSearchCode;
    }

    public String getVendorDebitNoteAccSpvVendorSearchCode() {
        return vendorDebitNoteAccSpvVendorSearchCode;
    }

    public void setVendorDebitNoteAccSpvVendorSearchCode(String vendorDebitNoteAccSpvVendorSearchCode) {
        this.vendorDebitNoteAccSpvVendorSearchCode = vendorDebitNoteAccSpvVendorSearchCode;
    }

    public String getVendorDebitNoteAccSpvVendorSearchName() {
        return vendorDebitNoteAccSpvVendorSearchName;
    }

    public void setVendorDebitNoteAccSpvVendorSearchName(String vendorDebitNoteAccSpvVendorSearchName) {
        this.vendorDebitNoteAccSpvVendorSearchName = vendorDebitNoteAccSpvVendorSearchName;
    }

    public Date getVendorDebitNoteAccSpvSearchFirstDate() {
        return vendorDebitNoteAccSpvSearchFirstDate;
    }

    public void setVendorDebitNoteAccSpvSearchFirstDate(Date vendorDebitNoteAccSpvSearchFirstDate) {
        this.vendorDebitNoteAccSpvSearchFirstDate = vendorDebitNoteAccSpvSearchFirstDate;
    }

    public Date getVendorDebitNoteAccSpvSearchLastDate() {
        return vendorDebitNoteAccSpvSearchLastDate;
    }

    public void setVendorDebitNoteAccSpvSearchLastDate(Date vendorDebitNoteAccSpvSearchLastDate) {
        this.vendorDebitNoteAccSpvSearchLastDate = vendorDebitNoteAccSpvSearchLastDate;
    }

    public String getVendorDebitNoteAccSpvSearchAccStatus() {
        return vendorDebitNoteAccSpvSearchAccStatus;
    }

    public void setVendorDebitNoteAccSpvSearchAccStatus(String vendorDebitNoteAccSpvSearchAccStatus) {
        this.vendorDebitNoteAccSpvSearchAccStatus = vendorDebitNoteAccSpvSearchAccStatus;
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
