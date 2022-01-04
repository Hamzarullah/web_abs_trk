
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.VendorCreditNoteDetailTemp;
import com.inkombizz.finance.bll.VendorCreditNoteBLL;
import com.inkombizz.finance.model.VendorCreditNote;
import com.inkombizz.finance.model.VendorCreditNoteDetail;
import com.inkombizz.finance.model.VendorCreditNoteTemp;
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
public class VendorCreditNoteJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorCreditNote vendorCreditNote;
    private VendorCreditNote vendorCreditNoteAccSpv;
    private VendorCreditNoteTemp vendorCreditNoteTemp;
    private VendorCreditNoteTemp vendorCreditNoteAccSpvTemp;
    private List<VendorCreditNote> listVendorCreditNote;
    private List<VendorCreditNote> listVendorCreditNoteAccSpv;
    private List<VendorCreditNoteDetail> listVendorCreditNoteDetail;
    private List<VendorCreditNoteTemp> listVendorCreditNoteTemp;
    private List<VendorCreditNoteTemp> listVendorCreditNoteAccSpvTemp;
    private List<VendorCreditNoteDetailTemp> listVendorCreditNoteDetailTemp;
    
    private String listVendorCreditNoteDetailJSON;
    private String vendorCreditNoteSearchCode="";
    private String vendorCreditNoteVendorSearchCode="";
    private String vendorCreditNoteVendorSearchName="";
    private Date vendorCreditNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorCreditNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String vendorCreditNoteAccSpvSearchCode="";
    private String vendorCreditNoteAccSpvVendorSearchCode="";
    private String vendorCreditNoteAccSpvVendorSearchName="";
    private Date vendorCreditNoteAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorCreditNoteAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String vendorCreditNoteAccSpvSearchAccStatus="Open";   

    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("vendor-credit-note-data")
    public String findData() {
        try {
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            ListPaging <VendorCreditNoteTemp> listPaging = vendorCreditNoteBLL.findData(paging,vendorCreditNoteSearchCode,vendorCreditNoteVendorSearchCode,vendorCreditNoteVendorSearchName, vendorCreditNoteSearchFirstDate, vendorCreditNoteSearchLastDate);
            
            listVendorCreditNoteTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-credit-note-detail-data")
    public String findDataDetail(){
        try {
            
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            List<VendorCreditNoteDetailTemp> list = vendorCreditNoteBLL.findDataDetail(this.vendorCreditNote.getCode());

            listVendorCreditNoteDetailTemp = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    

    @Action("vendor-credit-note-save")
    public String save(){
        String _Messg = "";
        try {
                        
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            Gson gson = new Gson();
            
            this.listVendorCreditNoteDetail = gson.fromJson(this.listVendorCreditNoteDetailJSON, new TypeToken<List<VendorCreditNoteDetail>>(){}.getType());
            
           SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date transactionDateTemp = sdf.parse(vendorCreditNoteTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(transactionDateTemp.getTime());
            Date createdTemp = sdf.parse(vendorCreditNoteTemp.getCreatedDateTemp());
            Date getCreatedTemp = new java.sql.Timestamp(createdTemp.getTime()); 
            
            vendorCreditNote.setTransactionDate(getTransactionDateTemp);
            vendorCreditNote.setCreatedDate(getCreatedTemp);
            
            if(vendorCreditNoteBLL.isExist(this.vendorCreditNote.getCode())){
                _Messg="UPDATED ";

                vendorCreditNoteBLL.update(vendorCreditNote, listVendorCreditNoteDetail);
                
            }else{
                
                 _Messg = "SAVED ";
                 vendorCreditNoteBLL.save(vendorCreditNote, listVendorCreditNoteDetail);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>VCN No : " + this.vendorCreditNote.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    
    @Action("vendor-credit-note-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
                        
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(vendorCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            vendorCreditNoteBLL.delete(vendorCreditNote.getCode());

            this.message = _Messg + " DATA SUCCESS.<br/>SDN No : " + this.vendorCreditNote.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("vendor-credit-note-acc-spv-data")
    public String findDataAccSpv() {
        try {
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            ListPaging <VendorCreditNoteTemp> listPaging = vendorCreditNoteBLL.findDataAccSpv(paging,vendorCreditNoteAccSpvSearchCode,vendorCreditNoteAccSpvVendorSearchCode,vendorCreditNoteAccSpvVendorSearchName,vendorCreditNoteAccSpvSearchFirstDate,vendorCreditNoteAccSpvSearchLastDate,vendorCreditNoteAccSpvSearchAccStatus);
            
            listVendorCreditNoteAccSpvTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("vendor-credit-note-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            Gson gson = new Gson();
            this.listVendorCreditNoteDetail = gson.fromJson(this.listVendorCreditNoteDetailJSON, new TypeToken<List<VendorCreditNoteDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(vendorCreditNoteAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            vendorCreditNoteAccSpv.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(vendorCreditNoteAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            vendorCreditNoteAccSpv.setCreatedDate(getCreatedDateTemp);
            
            vendorCreditNoteBLL.updateAccSpv(vendorCreditNoteAccSpv, listVendorCreditNoteDetail);


            this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.vendorCreditNoteAccSpv.getCode();

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

    public VendorCreditNote getVendorCreditNote() {
        return vendorCreditNote;
    }

    public void setVendorCreditNote(VendorCreditNote vendorCreditNote) {
        this.vendorCreditNote = vendorCreditNote;
    }

    public VendorCreditNoteTemp getVendorCreditNoteTemp() {
        return vendorCreditNoteTemp;
    }

    public void setVendorCreditNoteTemp(VendorCreditNoteTemp vendorCreditNoteTemp) {
        this.vendorCreditNoteTemp = vendorCreditNoteTemp;
    }

    public List<VendorCreditNote> getListVendorCreditNote() {
        return listVendorCreditNote;
    }

    public void setListVendorCreditNote(List<VendorCreditNote> listVendorCreditNote) {
        this.listVendorCreditNote = listVendorCreditNote;
    }

    public List<VendorCreditNoteDetail> getListVendorCreditNoteDetail() {
        return listVendorCreditNoteDetail;
    }

    public void setListVendorCreditNoteDetail(List<VendorCreditNoteDetail> listVendorCreditNoteDetail) {
        this.listVendorCreditNoteDetail = listVendorCreditNoteDetail;
    }

    public List<VendorCreditNoteTemp> getListVendorCreditNoteTemp() {
        return listVendorCreditNoteTemp;
    }

    public void setListVendorCreditNoteTemp(List<VendorCreditNoteTemp> listVendorCreditNoteTemp) {
        this.listVendorCreditNoteTemp = listVendorCreditNoteTemp;
    }

    public List<VendorCreditNoteDetailTemp> getListVendorCreditNoteDetailTemp() {
        return listVendorCreditNoteDetailTemp;
    }

    public void setListVendorCreditNoteDetailTemp(List<VendorCreditNoteDetailTemp> listVendorCreditNoteDetailTemp) {
        this.listVendorCreditNoteDetailTemp = listVendorCreditNoteDetailTemp;
    }

    public String getListVendorCreditNoteDetailJSON() {
        return listVendorCreditNoteDetailJSON;
    }

    public void setListVendorCreditNoteDetailJSON(String listVendorCreditNoteDetailJSON) {
        this.listVendorCreditNoteDetailJSON = listVendorCreditNoteDetailJSON;
    }

    public String getVendorCreditNoteSearchCode() {
        return vendorCreditNoteSearchCode;
    }

    public void setVendorCreditNoteSearchCode(String vendorCreditNoteSearchCode) {
        this.vendorCreditNoteSearchCode = vendorCreditNoteSearchCode;
    }

    public String getVendorCreditNoteVendorSearchCode() {
        return vendorCreditNoteVendorSearchCode;
    }

    public void setVendorCreditNoteVendorSearchCode(String vendorCreditNoteVendorSearchCode) {
        this.vendorCreditNoteVendorSearchCode = vendorCreditNoteVendorSearchCode;
    }

    public String getVendorCreditNoteVendorSearchName() {
        return vendorCreditNoteVendorSearchName;
    }

    public void setVendorCreditNoteVendorSearchName(String vendorCreditNoteVendorSearchName) {
        this.vendorCreditNoteVendorSearchName = vendorCreditNoteVendorSearchName;
    }

    public Date getVendorCreditNoteSearchFirstDate() {
        return vendorCreditNoteSearchFirstDate;
    }

    public void setVendorCreditNoteSearchFirstDate(Date vendorCreditNoteSearchFirstDate) {
        this.vendorCreditNoteSearchFirstDate = vendorCreditNoteSearchFirstDate;
    }

    public Date getVendorCreditNoteSearchLastDate() {
        return vendorCreditNoteSearchLastDate;
    }

    public void setVendorCreditNoteSearchLastDate(Date vendorCreditNoteSearchLastDate) {
        this.vendorCreditNoteSearchLastDate = vendorCreditNoteSearchLastDate;
    }

    public VendorCreditNote getVendorCreditNoteAccSpv() {
        return vendorCreditNoteAccSpv;
    }

    public void setVendorCreditNoteAccSpv(VendorCreditNote vendorCreditNoteAccSpv) {
        this.vendorCreditNoteAccSpv = vendorCreditNoteAccSpv;
    }

    public VendorCreditNoteTemp getVendorCreditNoteAccSpvTemp() {
        return vendorCreditNoteAccSpvTemp;
    }

    public void setVendorCreditNoteAccSpvTemp(VendorCreditNoteTemp vendorCreditNoteAccSpvTemp) {
        this.vendorCreditNoteAccSpvTemp = vendorCreditNoteAccSpvTemp;
    }

    public List<VendorCreditNote> getListVendorCreditNoteAccSpv() {
        return listVendorCreditNoteAccSpv;
    }

    public void setListVendorCreditNoteAccSpv(List<VendorCreditNote> listVendorCreditNoteAccSpv) {
        this.listVendorCreditNoteAccSpv = listVendorCreditNoteAccSpv;
    }

    public List<VendorCreditNoteTemp> getListVendorCreditNoteAccSpvTemp() {
        return listVendorCreditNoteAccSpvTemp;
    }

    public void setListVendorCreditNoteAccSpvTemp(List<VendorCreditNoteTemp> listVendorCreditNoteAccSpvTemp) {
        this.listVendorCreditNoteAccSpvTemp = listVendorCreditNoteAccSpvTemp;
    }

    public String getVendorCreditNoteAccSpvSearchCode() {
        return vendorCreditNoteAccSpvSearchCode;
    }

    public void setVendorCreditNoteAccSpvSearchCode(String vendorCreditNoteAccSpvSearchCode) {
        this.vendorCreditNoteAccSpvSearchCode = vendorCreditNoteAccSpvSearchCode;
    }

    public String getVendorCreditNoteAccSpvVendorSearchCode() {
        return vendorCreditNoteAccSpvVendorSearchCode;
    }

    public void setVendorCreditNoteAccSpvVendorSearchCode(String vendorCreditNoteAccSpvVendorSearchCode) {
        this.vendorCreditNoteAccSpvVendorSearchCode = vendorCreditNoteAccSpvVendorSearchCode;
    }

    public String getVendorCreditNoteAccSpvVendorSearchName() {
        return vendorCreditNoteAccSpvVendorSearchName;
    }

    public void setVendorCreditNoteAccSpvVendorSearchName(String vendorCreditNoteAccSpvVendorSearchName) {
        this.vendorCreditNoteAccSpvVendorSearchName = vendorCreditNoteAccSpvVendorSearchName;
    }

    public Date getVendorCreditNoteAccSpvSearchFirstDate() {
        return vendorCreditNoteAccSpvSearchFirstDate;
    }

    public void setVendorCreditNoteAccSpvSearchFirstDate(Date vendorCreditNoteAccSpvSearchFirstDate) {
        this.vendorCreditNoteAccSpvSearchFirstDate = vendorCreditNoteAccSpvSearchFirstDate;
    }

    public Date getVendorCreditNoteAccSpvSearchLastDate() {
        return vendorCreditNoteAccSpvSearchLastDate;
    }

    public void setVendorCreditNoteAccSpvSearchLastDate(Date vendorCreditNoteAccSpvSearchLastDate) {
        this.vendorCreditNoteAccSpvSearchLastDate = vendorCreditNoteAccSpvSearchLastDate;
    }

    public String getVendorCreditNoteAccSpvSearchAccStatus() {
        return vendorCreditNoteAccSpvSearchAccStatus;
    }

    public void setVendorCreditNoteAccSpvSearchAccStatus(String vendorCreditNoteAccSpvSearchAccStatus) {
        this.vendorCreditNoteAccSpvSearchAccStatus = vendorCreditNoteAccSpvSearchAccStatus;
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
