
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.finance.bll.GeneralJournalBLL;
import com.inkombizz.finance.model.GeneralJournal;
import com.inkombizz.finance.model.GeneralJournalDetail;
import com.inkombizz.finance.model.GeneralJournalDetailTemp;
import com.inkombizz.finance.model.GeneralJournalTemp;

@Result (type = "json")
public class GeneralJournalJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GeneralJournal generalJournal;
    private GeneralJournalTemp generalJournalTemp;
    private List<GeneralJournal> listGeneralJournal;
    private List<GeneralJournalTemp> listGeneralJournalTemp;
    private List<GeneralJournalDetail> listGeneralJournalDetail;
    private List<GeneralJournalDetailTemp> listGeneralJournalDetailTemp;
            
    private String listGeneralJournalDetailJSON;
    private String generalJournalSearchCode="";
    private String generalJournalSearchRefNo="";
    private String generalJournalSearchRemark="";
    Date generalJournalSearchFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date generalJournalSearchLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private Double forexAmount;
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
    
    @Action("general-journal-data")
    public String findData() {
        try {
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);
            ListPaging <GeneralJournalTemp> listPaging = generalJournalBLL.findData(paging,generalJournalSearchCode,generalJournalSearchRefNo,generalJournalSearchRemark, generalJournalSearchFirstDate, generalJournalSearchLastDate);
            
            listGeneralJournalTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("general-journal-detail-data")
    public String findDataDetail(){
        try {
            
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);
            List<GeneralJournalDetailTemp> list = generalJournalBLL.findDataDetail(generalJournal.getCode());

            listGeneralJournalDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("general-journal-save")
    public String save(){
        String _Messg = "";
        try {
                        
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);
            Gson gson = new Gson();
            this.listGeneralJournalDetail = gson.fromJson(this.listGeneralJournalDetailJSON, new TypeToken<List<GeneralJournalDetail>>(){}.getType());

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(generalJournalTemp.getTransactionDateTemp());
            generalJournal.setTransactionDate(TransactionDateTemp);

        
            if(generalJournalBLL.isExist(this.generalJournal.getCode())){
                _Messg="UPDATED ";

                generalJournalBLL.update(generalJournal, listGeneralJournalDetail, forexAmount);
                
            }else{
                
                 _Messg = "SAVED ";
                 generalJournalBLL.save(generalJournal, listGeneralJournalDetail, forexAmount);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>GENERAL JOURNAL No : " + this.generalJournal.getCode();

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("general-journal-delete") 
    public String delete(){
        try{
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);
                        
            generalJournalBLL.delete(this.generalJournal.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>GENERAL JOURNAL No : " + this.generalJournal.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("general-journal-authority-delete")
    public String generalJournalAuthorityDelete(){
        try{
            
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);
            
            switch(actionAuthority){
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(generalJournalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
            }
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public GeneralJournal getGeneralJournal() {
        return generalJournal;
    }

    public void setGeneralJournal(GeneralJournal generalJournal) {
        this.generalJournal = generalJournal;
    }

    public GeneralJournalTemp getGeneralJournalTemp() {
        return generalJournalTemp;
    }

    public void setGeneralJournalTemp(GeneralJournalTemp generalJournalTemp) {
        this.generalJournalTemp = generalJournalTemp;
    }

    public List<GeneralJournal> getListGeneralJournal() {
        return listGeneralJournal;
    }

    public void setListGeneralJournal(List<GeneralJournal> listGeneralJournal) {
        this.listGeneralJournal = listGeneralJournal;
    }

    public List<GeneralJournalTemp> getListGeneralJournalTemp() {
        return listGeneralJournalTemp;
    }

    public void setListGeneralJournalTemp(List<GeneralJournalTemp> listGeneralJournalTemp) {
        this.listGeneralJournalTemp = listGeneralJournalTemp;
    }

    public List<GeneralJournalDetail> getListGeneralJournalDetail() {
        return listGeneralJournalDetail;
    }

    public void setListGeneralJournalDetail(List<GeneralJournalDetail> listGeneralJournalDetail) {
        this.listGeneralJournalDetail = listGeneralJournalDetail;
    }

    public List<GeneralJournalDetailTemp> getListGeneralJournalDetailTemp() {
        return listGeneralJournalDetailTemp;
    }

    public void setListGeneralJournalDetailTemp(List<GeneralJournalDetailTemp> listGeneralJournalDetailTemp) {
        this.listGeneralJournalDetailTemp = listGeneralJournalDetailTemp;
    }

    public String getListGeneralJournalDetailJSON() {
        return listGeneralJournalDetailJSON;
    }

    public void setListGeneralJournalDetailJSON(String listGeneralJournalDetailJSON) {
        this.listGeneralJournalDetailJSON = listGeneralJournalDetailJSON;
    }

    public String getGeneralJournalSearchCode() {
        return generalJournalSearchCode;
    }

    public void setGeneralJournalSearchCode(String generalJournalSearchCode) {
        this.generalJournalSearchCode = generalJournalSearchCode;
    }

    public Date getGeneralJournalSearchFirstDate() {
        return generalJournalSearchFirstDate;
    }

    public void setGeneralJournalSearchFirstDate(Date generalJournalSearchFirstDate) {
        this.generalJournalSearchFirstDate = generalJournalSearchFirstDate;
    }

    public Date getGeneralJournalSearchLastDate() {
        return generalJournalSearchLastDate;
    }

    public void setGeneralJournalSearchLastDate(Date generalJournalSearchLastDate) {
        this.generalJournalSearchLastDate = generalJournalSearchLastDate;
    }

    public Double getForexAmount() {
        return forexAmount;
    }

    public void setForexAmount(Double forexAmount) {
        this.forexAmount = forexAmount;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getGeneralJournalSearchRefNo() {
        return generalJournalSearchRefNo;
    }

    public void setGeneralJournalSearchRefNo(String generalJournalSearchRefNo) {
        this.generalJournalSearchRefNo = generalJournalSearchRefNo;
    }

    public String getGeneralJournalSearchRemark() {
        return generalJournalSearchRemark;
    }

    public void setGeneralJournalSearchRemark(String generalJournalSearchRemark) {
        this.generalJournalSearchRemark = generalJournalSearchRemark;
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

