
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
//import com.inkombizz.master.bll.AreaSalesManagerBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.JournalBLL;
import com.inkombizz.master.model.Journal;
import com.inkombizz.master.model.JournalChartOfAccount;
import com.inkombizz.master.model.JournalChartOfAccountTemp;
import com.inkombizz.master.model.JournalTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result(type = "json")
public class JournalJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;

    protected HBMSession hbmSession = new HBMSession();

    private Journal journal;
    private List<Journal> listJournal;
    private List<JournalTemp> listJournalTemp;
    
    private JournalChartOfAccountTemp journalChartOfAccountTemp;
    private List<JournalChartOfAccountTemp> listJournalChartOfAccountTemp;
    private List<JournalChartOfAccount> listJournalChartOfAccount;
    
//    private List<JournalTemp> listJournalTemp;
    
    
    private String journalSearchCode = "";
    private String journalSearchName = "";
    private String listJournalChartOfAccountJSON;
    private String actionAuthority="";
    

    @Override
    public String execute() {
        try {
            return findData();
        } catch (Exception ex) {
            ex.printStackTrace();
            return SUCCESS;
        }
    }
     
    @Action("journal-data")
    public String findData() {
        try {
            JournalBLL journalBLL = new JournalBLL(hbmSession);
            ListPaging<JournalTemp> listPaging = journalBLL.getData(journalSearchCode,journalSearchName,paging);
//
            listJournalTemp = listPaging.getList();

            return SUCCESS;
        } catch (Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
//    
//    @Action("journal-data-query")
//    public String populateDataQuerry() {
//        try {
//            JournalBLL journalBLL = new JournalBLL(hbmSession);
//            ListPaging<JournalTemp> listPaging = journalBLL.getData(journalSearchCode,journalSearchName,paging);
//
//            listJournalTemp = listPaging.getList();
//
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }


//    @Action("journal-get")
//    public String get() {
//        try {
//            JournalBLL journalBLL = new JournalBLL(hbmSession);
//            this.journalTemp = journalBLL.get(this.journalTemp.getCode());
//
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

    @Action("journal-save")
    public String save() {
        String _msg="";
        try {
            
            JournalBLL journalBLL = new JournalBLL(hbmSession);
            Gson gson = new Gson();
            gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            this.listJournalChartOfAccount=gson.fromJson(this.listJournalChartOfAccountJSON, new TypeToken<List<JournalChartOfAccount>>(){}.getType());
            journalBLL.save(this.journal,listJournalChartOfAccount);
            _msg="SAVE";
                
//            if(journalBLL.isExist(this.journal.getCode())){
//                 journalBLL.update(this.journal,listJournalDetailTemp);
//                 _msg="UPDATE";
//            }else{
//                
//            }
            
            this.message = _msg +" DATA SUCCESS. \n Code : " + this.journal.getCode();
            return SUCCESS;
        } catch (Exception ex) {
            this.error = true;
            this.errorMessage =_msg + " DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

//    @Action("journal-update")
//    public String update() {
//        try {
//            JournalBLL journalBLL = new JournalBLL(hbmSession);
//            journalBLL.update(this.journal);
//            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.journal.getCode();
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

//    @Action("journal-delete")
//    public String delete() {
//        try {
//            JournalBLL journalBLL = new JournalBLL(hbmSession);
//            boolean check = journalBLL.isExistToDelete(this.journal.getCode());
//            if(check == true){
//                this.message = "CODE "+this.journal.getCode() + " : IS READY BE USE...!!!  ";
//            }else{
//                journalBLL.delete(this.journal.getCode());
//                this.message = "DELETE DATA SUCCESS. \n Code : " + this.journal.getCode();
//            }
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        
//        }
//     }
    

//    @Action("journal-search-data")
//    public String searchData() {
//        try {
//            JournalBLL journalBLL = new JournalBLL(hbmSession);
//            ListPaging<Journal> listPaging = journalBLL.search(paging, getJournalSearchCode(), getJournalSearchName(), EnumTriState.Enum_TriState.ALL);
//
//            listJournal = listPaging.getList();
//
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

    
//    @Action("journal-search")
//    public String search() {
//        try {
//            JournalBLL journalBLL = new JournalBLL(hbmSession);
//            ListPaging<Journal> listPaging = journalBLL.search(paging, searchJournal.getCode(), searchJournal.getName(), EnumTriState.Enum_TriState.YES);
//
//            listJournal = listPaging.getList();
//
//            return SUCCESS;
//        } catch (Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("journal-detail-data")
    public String populateDataDetail() {
        try {
            JournalBLL journalBLL = new JournalBLL(hbmSession);
            List<JournalChartOfAccountTemp> list = journalBLL.listDataDetail(journal.getCode());

            listJournalChartOfAccountTemp = list;

            return SUCCESS;
        } catch (Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("journal-detail-get")
    public String populateDataGetDetail() {
        try {
            JournalBLL journalBLL = new JournalBLL(hbmSession);
            List<JournalChartOfAccountTemp> list = journalBLL.listDataGetDetail(journal.getCode());
            listJournalChartOfAccountTemp = list;

            return SUCCESS;
        } catch (Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
//    @Action("journal-authority")
//    public String areaSalesManagerAuthority(){
//        try{
//            
//            AreaSalesManagerBLL areaSalesManagerBLL = new AreaSalesManagerBLL(hbmSession);
//            
//            switch(actionAuthority){
//                case "INSERT":
//                    if (!BaseSession.loadProgramSession().hasAuthority(areaSalesManagerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                        this.error = true;
//                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
//                        return SUCCESS;
//                    }
//                    break;
//                case "UPDATE":
//                    if (!BaseSession.loadProgramSession().hasAuthority(areaSalesManagerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
//                        this.error = true;
//                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
//                        return SUCCESS;
//                    }
//                    break;
//                case "DELETE":
//                    if (!BaseSession.loadProgramSession().hasAuthority(areaSalesManagerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
//                        this.error = true;
//                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
//                        return SUCCESS;
//                    }
//                    break;
//                
//            }
//            
//            
//            return SUCCESS;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return SUCCESS;
//        }
//    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Journal getJournal() {
        return journal;
    }

    public void setJournal(Journal journal) {
        this.journal = journal;
    }

    public List<Journal> getListJournal() {
        return listJournal;
    }

    public void setListJournal(List<Journal> listJournal) {
        this.listJournal = listJournal;
    }

    public List<JournalTemp> getListJournalTemp() {
        return listJournalTemp;
    }

    public void setListJournalTemp(List<JournalTemp> listJournalTemp) {
        this.listJournalTemp = listJournalTemp;
    }

    public JournalChartOfAccountTemp getJournalChartOfAccountTemp() {
        return journalChartOfAccountTemp;
    }

    public void setJournalChartOfAccountTemp(JournalChartOfAccountTemp journalChartOfAccountTemp) {
        this.journalChartOfAccountTemp = journalChartOfAccountTemp;
    }

    public List<JournalChartOfAccountTemp> getListJournalChartOfAccountTemp() {
        return listJournalChartOfAccountTemp;
    }

    public void setListJournalChartOfAccountTemp(List<JournalChartOfAccountTemp> listJournalChartOfAccountTemp) {
        this.listJournalChartOfAccountTemp = listJournalChartOfAccountTemp;
    }

    public List<JournalChartOfAccount> getListJournalChartOfAccount() {
        return listJournalChartOfAccount;
    }

    public void setListJournalChartOfAccount(List<JournalChartOfAccount> listJournalChartOfAccount) {
        this.listJournalChartOfAccount = listJournalChartOfAccount;
    }

    public String getJournalSearchCode() {
        return journalSearchCode;
    }

    public void setJournalSearchCode(String journalSearchCode) {
        this.journalSearchCode = journalSearchCode;
    }

    public String getJournalSearchName() {
        return journalSearchName;
    }

    public void setJournalSearchName(String journalSearchName) {
        this.journalSearchName = journalSearchName;
    }

    public String getListJournalChartOfAccountJSON() {
        return listJournalChartOfAccountJSON;
    }

    public void setListJournalChartOfAccountJSON(String listJournalChartOfAccountJSON) {
        this.listJournalChartOfAccountJSON = listJournalChartOfAccountJSON;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    
    
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

        if (paging.getRecords() > 0 && paging.getRows() > 0) {
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        } else {
            paging.setTotal(0);
        }
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

}
