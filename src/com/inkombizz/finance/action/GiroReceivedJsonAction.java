
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedBLL;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedTemp;
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
public class GiroReceivedJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroReceived giroReceived;
    private GiroReceived giroReceivedRejected;
    private GiroReceivedTemp giroReceivedTemp;
    private GiroReceivedTemp giroReceivedRejectedTemp;
    private List<GiroReceivedTemp> listGiroReceivedTemp;
    private String giroReceivedSearchCode="";
    private String giroReceivedSearchGiroStatus="Pending";
    private Date giroReceivedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority="";
    private String giroReceivedRejectedSearchCode="";
    private String giroReceivedRejectedSearchGiroStatus="Pending";
    private Date giroReceivedRejectedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedRejectedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }   
    
    @Action("giro-received-data")
    public String findData() {
        try {
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            ListPaging <GiroReceivedTemp> listPaging = giroReceivedBLL.findData(paging,giroReceivedSearchCode,giroReceivedSearchGiroStatus,giroReceivedSearchFirstDate,giroReceivedSearchLastDate);
            
            listGiroReceivedTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-received-rejected-data")
    public String findRejectedData() {
        try {
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            ListPaging <GiroReceivedTemp> listPaging = giroReceivedBLL.findData(paging,giroReceivedRejectedSearchCode,giroReceivedRejectedSearchGiroStatus,giroReceivedRejectedSearchFirstDate, giroReceivedRejectedSearchLastDate);
            
            listGiroReceivedTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-received-save")
    public String save(){
        String _Messg = "";
        try {
                        
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date transactionDateTemp = sdf.parse(giroReceivedTemp.getTransactionDateTemp());
            giroReceived.setTransactionDate(transactionDateTemp);
            
            Date dueDateTemp = sdf.parse(giroReceivedTemp.getDueDateTemp());
            giroReceived.setDueDate(dueDateTemp);
            
            Date createdDateTemp = sdf.parse(giroReceivedTemp.getCreatedDateTemp());
            giroReceived.setCreatedDate(createdDateTemp);
                    
            if(giroReceivedBLL.isExist(this.giroReceived.getCode())){
                _Messg="UPDATED ";
                giroReceivedBLL.update(giroReceived);
                
//                if(giroReceivedBLL.isGiroNoAndBankCodeExist(this.giroReceived.getGiroNo(),this.giroReceived.getBank().getCode())){
//                    this.error = true;
//                    this.errorMessage= "Giro No and Bank Is Exists";
//                }else{
//                    _Messg="UPDATED ";
//                    giroReceivedBLL.update(giroReceived);
//                }
                
            }else{
                if(giroReceivedBLL.isGiroNoAndBankCodeExist(this.giroReceived.getGiroNo(),this.giroReceived.getBank().getCode())){
                    this.error = true;
                    this.errorMessage= "Giro No and Bank Is Exists";
                }else{
                    _Messg = "SAVED ";
                    giroReceivedBLL.save(giroReceived);
                }
            }
            
            this.message = _Messg + " DATA SUCCESS.<br/>GIRO RECEIVED No : " + this.giroReceived.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-received-rejected-save")
    public String saveRejected(){
        String _Messg = "";
        try {
                        
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date transactionDateTemp = sdf.parse(giroReceivedRejectedTemp.getTransactionDateTemp());
            giroReceivedRejected.setTransactionDate(transactionDateTemp);
            
            Date dueDateTemp = sdf.parse(giroReceivedRejectedTemp.getDueDateTemp());
            giroReceivedRejected.setDueDate(dueDateTemp);
            
            Date createdDateTemp = sdf.parse(giroReceivedRejectedTemp.getCreatedDateTemp());
            giroReceivedRejected.setCreatedDate(createdDateTemp);
                    
            _Messg="UPDATED REJECTED";
            giroReceivedBLL.rejected(giroReceivedRejected);
            
            this.message = _Messg + " DATA SUCCESS.<br/>GIRO RECEIVED No : " + this.giroReceivedRejected.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-received-delete")
    public String delete(){
        try{
            
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            giroReceivedBLL.delete(this.giroReceived.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>GIRO RECEIVED No : " + this.giroReceived.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("giro-received-confirmation")
    public String confirmStatus(){
        try{
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            
            if(giroReceivedBLL.isRejected(this.giroReceived.getCode())){
                this.error = true;
                this.errorMessage = "Unable to Manipulate Data!<br/>this transaction ["+this.giroReceived.getCode()+"] has been rejected!";
                return SUCCESS;
            }
            
            listGiroReceivedTemp=giroReceivedBLL.isUsedByBankReceived(this.giroReceived.getCode());
            
            if (listGiroReceivedTemp.size() > 0) {
                this.error = true;
                this.errorMessage= "Unable to Manipulate Data!<br/>since used by: "+listGiroReceivedTemp.get(0).getCode();
                return SUCCESS;
            }
                        
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "ERROR DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public GiroReceived getGiroReceived() {
        return giroReceived;
    }

    public void setGiroReceived(GiroReceived giroReceived) {
        this.giroReceived = giroReceived;
    }

    public GiroReceived getGiroReceivedRejected() {
        return giroReceivedRejected;
    }

    public void setGiroReceivedRejected(GiroReceived giroReceivedRejected) {
        this.giroReceivedRejected = giroReceivedRejected;
    }

    public GiroReceivedTemp getGiroReceivedTemp() {
        return giroReceivedTemp;
    }

    public void setGiroReceivedTemp(GiroReceivedTemp giroReceivedTemp) {
        this.giroReceivedTemp = giroReceivedTemp;
    }

    public GiroReceivedTemp getGiroReceivedRejectedTemp() {
        return giroReceivedRejectedTemp;
    }

    public void setGiroReceivedRejectedTemp(GiroReceivedTemp giroReceivedRejectedTemp) {
        this.giroReceivedRejectedTemp = giroReceivedRejectedTemp;
    }

    public List<GiroReceivedTemp> getListGiroReceivedTemp() {
        return listGiroReceivedTemp;
    }

    public void setListGiroReceivedTemp(List<GiroReceivedTemp> listGiroReceivedTemp) {
        this.listGiroReceivedTemp = listGiroReceivedTemp;
    }

    public String getGiroReceivedSearchCode() {
        return giroReceivedSearchCode;
    }

    public void setGiroReceivedSearchCode(String giroReceivedSearchCode) {
        this.giroReceivedSearchCode = giroReceivedSearchCode;
    }

    public String getGiroReceivedSearchGiroStatus() {
        return giroReceivedSearchGiroStatus;
    }

    public void setGiroReceivedSearchGiroStatus(String giroReceivedSearchGiroStatus) {
        this.giroReceivedSearchGiroStatus = giroReceivedSearchGiroStatus;
    }

    public Date getGiroReceivedSearchFirstDate() {
        return giroReceivedSearchFirstDate;
    }

    public void setGiroReceivedSearchFirstDate(Date giroReceivedSearchFirstDate) {
        this.giroReceivedSearchFirstDate = giroReceivedSearchFirstDate;
    }

    public Date getGiroReceivedSearchLastDate() {
        return giroReceivedSearchLastDate;
    }

    public void setGiroReceivedSearchLastDate(Date giroReceivedSearchLastDate) {
        this.giroReceivedSearchLastDate = giroReceivedSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getGiroReceivedRejectedSearchCode() {
        return giroReceivedRejectedSearchCode;
    }

    public void setGiroReceivedRejectedSearchCode(String giroReceivedRejectedSearchCode) {
        this.giroReceivedRejectedSearchCode = giroReceivedRejectedSearchCode;
    }

    public String getGiroReceivedRejectedSearchGiroStatus() {
        return giroReceivedRejectedSearchGiroStatus;
    }

    public void setGiroReceivedRejectedSearchGiroStatus(String giroReceivedRejectedSearchGiroStatus) {
        this.giroReceivedRejectedSearchGiroStatus = giroReceivedRejectedSearchGiroStatus;
    }

    public Date getGiroReceivedRejectedSearchFirstDate() {
        return giroReceivedRejectedSearchFirstDate;
    }

    public void setGiroReceivedRejectedSearchFirstDate(Date giroReceivedRejectedSearchFirstDate) {
        this.giroReceivedRejectedSearchFirstDate = giroReceivedRejectedSearchFirstDate;
    }

    public Date getGiroReceivedRejectedSearchLastDate() {
        return giroReceivedRejectedSearchLastDate;
    }

    public void setGiroReceivedRejectedSearchLastDate(Date giroReceivedRejectedSearchLastDate) {
        this.giroReceivedRejectedSearchLastDate = giroReceivedRejectedSearchLastDate;
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
