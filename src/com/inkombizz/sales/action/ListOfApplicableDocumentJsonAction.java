
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ListOfApplicableDocumentBLL;
import com.inkombizz.sales.model.ListOfApplicableDocument;
import com.inkombizz.sales.model.ListOfApplicableDocumentDetail;
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
public class ListOfApplicableDocumentJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
        
    private ListOfApplicableDocument listOfApplicableDocument=new ListOfApplicableDocument();
    private List<ListOfApplicableDocument> listListOfApplicableDocument;
    private List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail;
    
    private String listListOfApplicableDocumentDetailJSON;
    
    private Date listOfApplicableDocumentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date listOfApplicableDocumentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String actionAuthority="";
    private String codeLad = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("list-of-applicable-document-data")
    public String findData() {
        try {
            ListOfApplicableDocumentBLL listOfApplicableDocumentBLL = new ListOfApplicableDocumentBLL(hbmSession);
            ListPaging <ListOfApplicableDocument> listPaging = listOfApplicableDocumentBLL.findData(paging,listOfApplicableDocument);
            
            listListOfApplicableDocument = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("list-of-applicable-document-detail-data")
    public String findDataItemDetail(){
        try {
            
            ListOfApplicableDocumentBLL listOfApplicableDocumentBLL = new ListOfApplicableDocumentBLL(hbmSession);
            List<ListOfApplicableDocumentDetail> list = listOfApplicableDocumentBLL.findDataDetail(listOfApplicableDocument.getCode());
            
            listListOfApplicableDocumentDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("list-of-applicable-document-save")
    public String save(){
        String _Messg = "";
        try {
                        
            ListOfApplicableDocumentBLL listOfApplicableDocumentBLL = new ListOfApplicableDocumentBLL(hbmSession);
            Gson gson = new Gson();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            this.listListOfApplicableDocumentDetail = gson.fromJson(this.listListOfApplicableDocumentDetailJSON, new TypeToken<List<ListOfApplicableDocumentDetail>>(){}.getType());
            
            listOfApplicableDocument.setTransactionDate(DateUtils.newDateTime(listOfApplicableDocument.getTransactionDate(),true));
            
            Date createdDate = sdf.parse(listOfApplicableDocument.getCreatedDateTemp());
            Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
            listOfApplicableDocument.setCreatedDate(createdDatetime);
            
            listOfApplicableDocument.setBranch(listOfApplicableDocument.getSalesOrder().getBranch());
            
            if(listOfApplicableDocumentBLL.isExist(this.listOfApplicableDocument.getCode())){
                               
                _Messg="UPDATE ";
                listOfApplicableDocumentBLL.update(listOfApplicableDocument,listListOfApplicableDocumentDetail);
                                
            }else{
                                
                _Messg = "SAVE";
                listOfApplicableDocumentBLL.save(listOfApplicableDocument,listListOfApplicableDocumentDetail);
                 
            }
            
            this.message = _Messg + " DATA SUCCESS.<br/>LAD No : " + this.listOfApplicableDocument.getCode();
            this.codeLad = this.listOfApplicableDocument.getCode();
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("list-of-applicable-document-delete")
    public String delete(){
        String _messg = "";
        try{
            ListOfApplicableDocumentBLL listOfApplicableDocumentBLL = new ListOfApplicableDocumentBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            listOfApplicableDocumentBLL.delete(listOfApplicableDocument);
            
            this.message = _messg + "DATA SUCCESS.<br/> LAD No : " + this.listOfApplicableDocument.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("list-of-applicable-document-authority")
    public String listOfApplicableDocumentAuthority(){
        try{
            
            ListOfApplicableDocumentBLL listOfApplicableDocumentBLL = new ListOfApplicableDocumentBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    public ListOfApplicableDocument getListOfApplicableDocument() {
        return listOfApplicableDocument;
    }

    public void setListOfApplicableDocument(ListOfApplicableDocument listOfApplicableDocument) {
        this.listOfApplicableDocument = listOfApplicableDocument;
    }

    public List<ListOfApplicableDocument> getListListOfApplicableDocument() {
        return listListOfApplicableDocument;
    }

    public void setListListOfApplicableDocument(List<ListOfApplicableDocument> listListOfApplicableDocument) {
        this.listListOfApplicableDocument = listListOfApplicableDocument;
    }

    public List<ListOfApplicableDocumentDetail> getListListOfApplicableDocumentDetail() {
        return listListOfApplicableDocumentDetail;
    }

    public void setListListOfApplicableDocumentDetail(List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail) {
        this.listListOfApplicableDocumentDetail = listListOfApplicableDocumentDetail;
    }

    public String getListListOfApplicableDocumentDetailJSON() {
        return listListOfApplicableDocumentDetailJSON;
    }

    public void setListListOfApplicableDocumentDetailJSON(String listListOfApplicableDocumentDetailJSON) {
        this.listListOfApplicableDocumentDetailJSON = listListOfApplicableDocumentDetailJSON;
    }

    public Date getListOfApplicableDocumentSearchFirstDate() {
        return listOfApplicableDocumentSearchFirstDate;
    }

    public void setListOfApplicableDocumentSearchFirstDate(Date listOfApplicableDocumentSearchFirstDate) {
        this.listOfApplicableDocumentSearchFirstDate = listOfApplicableDocumentSearchFirstDate;
    }

    public Date getListOfApplicableDocumentSearchLastDate() {
        return listOfApplicableDocumentSearchLastDate;
    }

    public void setListOfApplicableDocumentSearchLastDate(Date listOfApplicableDocumentSearchLastDate) {
        this.listOfApplicableDocumentSearchLastDate = listOfApplicableDocumentSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getCodeLad() {
        return codeLad;
    }

    public void setCodeLad(String codeLad) {
        this.codeLad = codeLad;
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
