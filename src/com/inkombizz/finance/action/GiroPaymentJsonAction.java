
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentBLL;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentTemp;
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
public class GiroPaymentJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroPayment giroPayment;
    private GiroPayment giroPaymentRejected;
    private GiroPaymentTemp giroPaymentTemp;
    private GiroPaymentTemp giroPaymentRejectedTemp;
    private List<GiroPaymentTemp> listGiroPaymentTemp;
    private String giroPaymentSearchCode="";
    private String giroPaymentSearchGiroStatus="Pending";
    private Date giroPaymentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority="";
    private String giroPaymentRejectedSearchCode="";
    private String giroPaymentRejectedSearchGiroStatus="Pending";
    private Date giroPaymentRejectedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentRejectedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }   
    
    @Action("giro-payment-data")
    public String findData() {
        try {
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            ListPaging <GiroPaymentTemp> listPaging = giroPaymentBLL.findData(paging,giroPaymentSearchCode,giroPaymentSearchGiroStatus,giroPaymentSearchFirstDate, giroPaymentSearchLastDate);
            
            listGiroPaymentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-payment-rejected-data")
    public String findRejectedData() {
        try {
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            ListPaging <GiroPaymentTemp> listPaging = giroPaymentBLL.findData(paging,giroPaymentRejectedSearchCode,giroPaymentRejectedSearchGiroStatus,giroPaymentRejectedSearchFirstDate, giroPaymentRejectedSearchLastDate);
            
            listGiroPaymentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-payment-get-data")
    public String findData1() {
        try {
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            this.giroPaymentTemp = giroPaymentBLL.findData(this.giroPayment.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("giro-payment-save")
    public String save(){
        String _Messg = "";
        try {
                        
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date transactionDateTemp = sdf.parse(giroPaymentTemp.getTransactionDateTemp());
            giroPayment.setTransactionDate(transactionDateTemp);
            
            Date dueDateTemp = sdf.parse(giroPaymentTemp.getDueDateTemp());
            giroPayment.setDueDate(dueDateTemp);
            
            Date createdDateTemp = sdf.parse(giroPaymentTemp.getCreatedDateTemp());
            giroPayment.setCreatedDate(createdDateTemp);
                    
            if(giroPaymentBLL.isExist(this.giroPayment.getCode())){
                _Messg="UPDATED ";
                giroPaymentBLL.update(giroPayment);
                
//                if(giroPaymentBLL.isGiroNoAndBankCodeExist(this.giroPayment.getGiroNo(),this.giroPayment.getBank().getCode())){
//                    this.error = true;
//                    this.errorMessage= "Giro No and Bank Is Exists";
//                }else{
//                    _Messg="UPDATED ";
//                    giroPaymentBLL.update(giroPayment);
//                }
                
            }else{
                if(giroPaymentBLL.isGiroNoAndBankCodeExist(this.giroPayment.getGiroNo(),this.giroPayment.getBank().getCode())){
                    this.error = true;
                    this.errorMessage= "Giro No and Bank Is Exists";
                }else{
                    _Messg = "SAVED ";
                    giroPaymentBLL.save(giroPayment);
                }
            }
            
            this.message = _Messg + " DATA SUCCESS.<br/>GIRO PAYMENT No : " + this.giroPayment.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-payment-rejected-save")
    public String saveRejected(){
        String _Messg = "";
        try {
                        
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date transactionDateTemp = sdf.parse(giroPaymentRejectedTemp.getTransactionDateTemp());
            giroPaymentRejected.setTransactionDate(transactionDateTemp);
            
            Date dueDateTemp = sdf.parse(giroPaymentRejectedTemp.getDueDateTemp());
            giroPaymentRejected.setDueDate(dueDateTemp);
            
            Date createdDateTemp = sdf.parse(giroPaymentRejectedTemp.getCreatedDateTemp());
            giroPaymentRejected.setCreatedDate(createdDateTemp);
                    
            _Messg="UPDATED REJECTED";
            giroPaymentBLL.rejected(giroPaymentRejected);
            
            this.message = _Messg + " DATA SUCCESS.<br/>GIRO PAYMENT No : " + this.giroPaymentRejected.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("giro-payment-delete")
    public String delete(){
        try{
            
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            giroPaymentBLL.delete(this.giroPayment.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>GIRO PAYMENT No : " + this.giroPayment.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("giro-payment-confirmation")
    public String confirmStatus(){
        try{
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            
            if(giroPaymentBLL.isRejected(this.giroPayment.getCode())){
                this.error = true;
                this.errorMessage = "Unable to Manipulate Data!<br/>this transaction ["+this.giroPayment.getCode()+"] has been rejected!";
                return SUCCESS;
            }
            
            listGiroPaymentTemp=giroPaymentBLL.isUsedByBankPayment(this.giroPayment.getCode());
            
            if (listGiroPaymentTemp.size() > 0) {
                this.error = true;
                this.errorMessage= "Unable to Manipulate Data!<br/>since used by: "+listGiroPaymentTemp.get(0).getCode();
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

    public GiroPayment getGiroPayment() {
        return giroPayment;
    }

    public void setGiroPayment(GiroPayment giroPayment) {
        this.giroPayment = giroPayment;
    }

    public GiroPayment getGiroPaymentRejected() {
        return giroPaymentRejected;
    }

    public void setGiroPaymentRejected(GiroPayment giroPaymentRejected) {
        this.giroPaymentRejected = giroPaymentRejected;
    }

    public GiroPaymentTemp getGiroPaymentTemp() {
        return giroPaymentTemp;
    }

    public void setGiroPaymentTemp(GiroPaymentTemp giroPaymentTemp) {
        this.giroPaymentTemp = giroPaymentTemp;
    }

    public GiroPaymentTemp getGiroPaymentRejectedTemp() {
        return giroPaymentRejectedTemp;
    }

    public void setGiroPaymentRejectedTemp(GiroPaymentTemp giroPaymentRejectedTemp) {
        this.giroPaymentRejectedTemp = giroPaymentRejectedTemp;
    }

    public List<GiroPaymentTemp> getListGiroPaymentTemp() {
        return listGiroPaymentTemp;
    }

    public void setListGiroPaymentTemp(List<GiroPaymentTemp> listGiroPaymentTemp) {
        this.listGiroPaymentTemp = listGiroPaymentTemp;
    }

    public String getGiroPaymentSearchCode() {
        return giroPaymentSearchCode;
    }

    public void setGiroPaymentSearchCode(String giroPaymentSearchCode) {
        this.giroPaymentSearchCode = giroPaymentSearchCode;
    }

    public String getGiroPaymentSearchGiroStatus() {
        return giroPaymentSearchGiroStatus;
    }

    public void setGiroPaymentSearchGiroStatus(String giroPaymentSearchGiroStatus) {
        this.giroPaymentSearchGiroStatus = giroPaymentSearchGiroStatus;
    }

    public Date getGiroPaymentSearchFirstDate() {
        return giroPaymentSearchFirstDate;
    }

    public void setGiroPaymentSearchFirstDate(Date giroPaymentSearchFirstDate) {
        this.giroPaymentSearchFirstDate = giroPaymentSearchFirstDate;
    }

    public Date getGiroPaymentSearchLastDate() {
        return giroPaymentSearchLastDate;
    }

    public void setGiroPaymentSearchLastDate(Date giroPaymentSearchLastDate) {
        this.giroPaymentSearchLastDate = giroPaymentSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getGiroPaymentRejectedSearchCode() {
        return giroPaymentRejectedSearchCode;
    }

    public void setGiroPaymentRejectedSearchCode(String giroPaymentRejectedSearchCode) {
        this.giroPaymentRejectedSearchCode = giroPaymentRejectedSearchCode;
    }

    public String getGiroPaymentRejectedSearchGiroStatus() {
        return giroPaymentRejectedSearchGiroStatus;
    }

    public void setGiroPaymentRejectedSearchGiroStatus(String giroPaymentRejectedSearchGiroStatus) {
        this.giroPaymentRejectedSearchGiroStatus = giroPaymentRejectedSearchGiroStatus;
    }

    public Date getGiroPaymentRejectedSearchFirstDate() {
        return giroPaymentRejectedSearchFirstDate;
    }

    public void setGiroPaymentRejectedSearchFirstDate(Date giroPaymentRejectedSearchFirstDate) {
        this.giroPaymentRejectedSearchFirstDate = giroPaymentRejectedSearchFirstDate;
    }

    public Date getGiroPaymentRejectedSearchLastDate() {
        return giroPaymentRejectedSearchLastDate;
    }

    public void setGiroPaymentRejectedSearchLastDate(Date giroPaymentRejectedSearchLastDate) {
        this.giroPaymentRejectedSearchLastDate = giroPaymentRejectedSearchLastDate;
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
