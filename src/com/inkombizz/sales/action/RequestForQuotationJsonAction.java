
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;

import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.sales.bll.RequestForQuotationBLL;
//import com.inkombizz.sales.model.PurchaseOrder;
import com.inkombizz.sales.model.RequestForQuotation;
import com.inkombizz.sales.model.RequestForQuotationTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;

@Result (type = "json")
public class RequestForQuotationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;    
    
    protected HBMSession hbmSession = new HBMSession();
    private String actionAuthority="";
    private RequestForQuotation requestForQuotation;
    private RequestForQuotation requestForQuotationApproval;
    private List<RequestForQuotation> listRequestForQuotation;
    private RequestForQuotationTemp requestForQuotationTemp;
    private List<RequestForQuotationTemp> listRequestForQuotationTemp;
    private List<RequestForQuotationTemp> listRequestForQuotationApprovalTemp;
    private List<RequestForQuotationTemp> listRequestForQuotationClosingTemp;
    private RequestForQuotation searchRequestForQuotation=new RequestForQuotation();
    
    private String requestForQuotationSearchCode="";
    private String requestForQuotationSearchTenderNo="";
    private String requestForQuotationSearchCustomerCode="";
    private String requestForQuotationSearchCustomerName="";
    private String requestForQuotationSearchEndUserCode="";
    private String requestForQuotationSearchEndUserName="";
    private String requestForQuotationSearchSubject="";
    private String requestForQuotationSearchProjectCode="";
    private String requestForQuotationSearchRefNo="";
    private String requestForQuotationSearchRemark="";
    private String requestForQuotationSearchValidStatus="true";
    private String requestForQuotationSearchApprovalStatus="PENDING";
    private Date requestForQuotationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date requestForQuotationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private String requestForQuotationApprovalSearchCode="";
    private String requestForQuotationApprovalSearchTenderNo="";
    private String requestForQuotationApprovalSearchCustomerCode="";
    private String requestForQuotationApprovalSearchCustomerName="";
    private String requestForQuotationApprovalSearchSubject="";
    private String requestForQuotationApprovalSearchProjectCode="";
    private String requestForQuotationApprovalSearchValidStatus="true";
    private String requestForQuotationApprovalSearchApprovalStatus="PENDING";
    private String requestForQuotationApprovalSearchEndUserCode="";
    private String requestForQuotationApprovalSearchEndUserName="";
    private String requestForQuotationApprovalSearchRefNo = "";
    private String requestForQuotationApprovalSearchRemark = "";
    private Date requestForQuotationApprovalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date requestForQuotationApprovalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private String requestForQuotationClosingSearchCode="";
    private String requestForQuotationClosingSearchTenderNo="";
    private String requestForQuotationClosingSearchCustomerCode="";
    private String requestForQuotationClosingSearchCustomerName="";
    private String requestForQuotationClosingSearchSubject="";
    private String requestForQuotationClosingSearchProjectCode="";
    private String requestForQuotationClosingSearchValidStatus="true";
    private String requestForQuotationClosingSearchClosingStatus="";
    private String requestForQuotationClosingSearchEndUserCode="";
    private String requestForQuotationClosingSearchEndUserName="";
    private Date requestForQuotationClosingSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date requestForQuotationClosingSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private String listRequestForQuotationDetailJSON="";
    private ArrayList listRequestForQuotationCode;
    private String usedModule = "";
                
    @Override 
    public String execute(){
        try{
            return findata();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
        
    @Action("request-for-quotation-data")
    public String findata(){
        try{
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);        

            ListPaging<RequestForQuotationTemp> listPaging = requestForQuotationBLL.findData(paging,requestForQuotationSearchCode, requestForQuotationSearchTenderNo, requestForQuotationSearchCustomerCode, 
                                                                                             requestForQuotationSearchCustomerName, requestForQuotationSearchSubject, requestForQuotationSearchProjectCode, 
                                                                                             requestForQuotationSearchValidStatus, requestForQuotationSearchEndUserCode, requestForQuotationSearchEndUserName,
                                                                                             requestForQuotationSearchRefNo, requestForQuotationSearchRemark, requestForQuotationSearchApprovalStatus, 
                                                                                             requestForQuotationSearchFirstDate, requestForQuotationSearchLastDate);
            
            listRequestForQuotationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("request-for-quotation-approval-data")
    public String finapprovaldata(){
        try{
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);        

            ListPaging<RequestForQuotationTemp> listPaging = requestForQuotationBLL.findApprovalData(paging,requestForQuotationApprovalSearchCode,requestForQuotationApprovalSearchTenderNo,requestForQuotationApprovalSearchCustomerCode,
                                                                                                     requestForQuotationApprovalSearchCustomerName,requestForQuotationApprovalSearchSubject, requestForQuotationApprovalSearchProjectCode, 
                                                                                                     requestForQuotationApprovalSearchApprovalStatus,requestForQuotationApprovalSearchValidStatus,requestForQuotationApprovalSearchEndUserCode, 
                                                                                                     requestForQuotationApprovalSearchEndUserName, requestForQuotationApprovalSearchRefNo, requestForQuotationApprovalSearchRemark,
                                                                                                     requestForQuotationApprovalSearchFirstDate,requestForQuotationApprovalSearchLastDate);
            
            listRequestForQuotationApprovalTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("request-for-quotation-closing-data")
    public String findClosingdata(){
        try{
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);        

            ListPaging<RequestForQuotationTemp> listPaging = requestForQuotationBLL.findClosingData(paging, requestForQuotationClosingSearchCode, requestForQuotationClosingSearchTenderNo,
                                                                                                    requestForQuotationClosingSearchCustomerCode, requestForQuotationClosingSearchCustomerName, requestForQuotationClosingSearchSubject,
                                                                                                    requestForQuotationClosingSearchProjectCode, requestForQuotationClosingSearchClosingStatus, 
                                                                                                    requestForQuotationClosingSearchEndUserCode, requestForQuotationClosingSearchEndUserName, 
                                                                                                    requestForQuotationClosingSearchFirstDate, requestForQuotationClosingSearchLastDate);
            
            listRequestForQuotationClosingTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("request-for-quotation-search-data")
    public String findSearchData(){
        try{
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);        

            ListPaging<RequestForQuotationTemp> listPaging = requestForQuotationBLL.findDataRequestForQuotation(paging,requestForQuotationSearchCode,requestForQuotationSearchFirstDate,requestForQuotationSearchLastDate);
            
            listRequestForQuotationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
//    
//     //untuk lookup po
//    @Action("request-for-quotation-search")
//    public String search() {
//        try {
//            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
//
////            ListPaging <RequestForQuotationTemp> listPaging = requestForQuotationBLL.getPodForLookUpInGRN(paging,searchRequestForQuotation, firstDate, lastDate);
//
//            listRequestForQuotationTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
//    

////    @Action("request-for-quotation-in-purchase-order-data")
////    public String findataPRQInPOD(){
////        try{
////            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);        
////            
////            listRequestForQuotationTemp = requestForQuotationBLL.findDataPRQInPOD(purchaseOrder.getCode());
////            
////            return SUCCESS;
////        }
////        catch(Exception ex){
////            ex.printStackTrace();
////            return SUCCESS;
////        }
////    }
//     
    @Action("request-for-quotation-save")
    public String save(){
        String _Messg = "";
        try {
                        
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            Gson gson = new Gson();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            requestForQuotation.setTransactionDate(DateUtils.newDateTime(requestForQuotation.getTransactionDate(),true));
                 _Messg = "SAVED ";
                    
                 requestForQuotationBLL.save(requestForQuotation);
                 this.message = _Messg + " DATA SUCCESS. <br/>RFQ No : " + this.requestForQuotation.getCode();


            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("request-for-quotation-check")
    public String checkItemInWo() {
      
           try {
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            this.requestForQuotationTemp = requestForQuotationBLL.check(this.requestForQuotation.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("request-for-quotation-update")
    public String update(){
        String _Messg = "";
        try {
                        
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            requestForQuotation.setTransactionDate(DateUtils.newDateTime(requestForQuotation.getTransactionDate(),true));
            
                _Messg="UPDATED ";
                requestForQuotationBLL.update(this.requestForQuotation);
                this.message = _Messg + " DATA SUCCESS. <br/>RFQ No : " + this.requestForQuotation.getCode();
                
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("request-for-quotation-save-revise")
    public String saveRevise(){
        String _Messg = "";
        try {
                        
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            
            requestForQuotation.setTransactionDate(DateUtils.newDateTime(requestForQuotation.getTransactionDate(),true));
            requestForQuotation.setCode(requestForQuotation.getRefRfqCode());
//            if(requestForQuotationBLL.isExist(this.requestForQuotation.getCode())){
//                this.errorMessage = "CODE "+this.requestForQuotation.getCode()+" HAS BEEN EXISTS IN DATABASE!";
//            }else{
                 _Messg = "SAVED "; 
                 requestForQuotationBLL.saveRevise(requestForQuotation);
            this.message = _Messg + " DATA SUCCESS. <br/>RFQ No : " + this.requestForQuotation.getCode();
//            }
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("request-for-quotation-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
            
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
        
            requestForQuotationBLL.approval(requestForQuotationApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>SONo : " + this.requestForQuotationApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("request-for-quotation-authority")
    public String salesOrderAuthority(){
        try{
            
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    @Action("request-for-quotation-delete")
    public String delete(){
        String _messg = "";
        try{
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);     

            _messg = "DELETE ";

            if (!BaseSession.loadProgramSession().hasAuthority(RequestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }   

            requestForQuotationBLL.delete(requestForQuotation.getCode());
            
            this.message = _messg + "DATA SUCCESS.<br/> PRQ No : " + this.requestForQuotation.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public RequestForQuotation getRequestForQuotation() {
        return requestForQuotation;
    }

    public void setRequestForQuotation(RequestForQuotation requestForQuotation) {
        this.requestForQuotation = requestForQuotation;
    }

    public List<RequestForQuotation> getListRequestForQuotation() {
        return listRequestForQuotation;
    }

    public void setListRequestForQuotation(List<RequestForQuotation> listRequestForQuotation) {
        this.listRequestForQuotation = listRequestForQuotation;
    }

    public RequestForQuotationTemp getRequestForQuotationTemp() {
        return requestForQuotationTemp;
    }

    public void setRequestForQuotationTemp(RequestForQuotationTemp requestForQuotationTemp) {
        this.requestForQuotationTemp = requestForQuotationTemp;
    }

    public List<RequestForQuotationTemp> getListRequestForQuotationTemp() {
        return listRequestForQuotationTemp;
    }

    public void setListRequestForQuotationTemp(List<RequestForQuotationTemp> listRequestForQuotationTemp) {
        this.listRequestForQuotationTemp = listRequestForQuotationTemp;
    }

    public String getRequestForQuotationSearchCode() {
        return requestForQuotationSearchCode;
    }

    public void setRequestForQuotationSearchCode(String requestForQuotationSearchCode) {
        this.requestForQuotationSearchCode = requestForQuotationSearchCode;
    }


    public String getRequestForQuotationSearchTenderNo() {
        return requestForQuotationSearchTenderNo;
    }

    public void setRequestForQuotationSearchTenderNo(String requestForQuotationSearchTenderNo) {
        this.requestForQuotationSearchTenderNo = requestForQuotationSearchTenderNo;
    }

    public String getRequestForQuotationSearchCustomerCode() {
        return requestForQuotationSearchCustomerCode;
    }

    public void setRequestForQuotationSearchCustomerCode(String requestForQuotationSearchCustomerCode) {
        this.requestForQuotationSearchCustomerCode = requestForQuotationSearchCustomerCode;
    }

    public String getRequestForQuotationSearchCustomerName() {
        return requestForQuotationSearchCustomerName;
    }

    public void setRequestForQuotationSearchCustomerName(String requestForQuotationSearchCustomerName) {
        this.requestForQuotationSearchCustomerName = requestForQuotationSearchCustomerName;
    }

    public String getRequestForQuotationSearchSubject() {
        return requestForQuotationSearchSubject;
    }

    public void setRequestForQuotationSearchSubject(String requestForQuotationSearchSubject) {
        this.requestForQuotationSearchSubject = requestForQuotationSearchSubject;
    }

    public String getRequestForQuotationSearchProjectCode() {
        return requestForQuotationSearchProjectCode;
    }

    public void setRequestForQuotationSearchProjectCode(String requestForQuotationSearchProjectCode) {
        this.requestForQuotationSearchProjectCode = requestForQuotationSearchProjectCode;
    }

    public String getRequestForQuotationSearchValidStatus() {
        return requestForQuotationSearchValidStatus;
    }

    public void setRequestForQuotationSearchValidStatus(String requestForQuotationSearchValidStatus) {
        this.requestForQuotationSearchValidStatus = requestForQuotationSearchValidStatus;
    }

    public Date getRequestForQuotationSearchFirstDate() {
        return requestForQuotationSearchFirstDate;
    }

    public void setRequestForQuotationSearchFirstDate(Date requestForQuotationSearchFirstDate) {
        this.requestForQuotationSearchFirstDate = requestForQuotationSearchFirstDate;
    }

    public Date getRequestForQuotationSearchLastDate() {
        return requestForQuotationSearchLastDate;
    }

    public void setRequestForQuotationSearchLastDate(Date requestForQuotationSearchLastDate) {
        this.requestForQuotationSearchLastDate = requestForQuotationSearchLastDate;
    }

    public String getListRequestForQuotationDetailJSON() {
        return listRequestForQuotationDetailJSON;
    }

    public void setListRequestForQuotationDetailJSON(String listRequestForQuotationDetailJSON) {
        this.listRequestForQuotationDetailJSON = listRequestForQuotationDetailJSON;
    }

    public ArrayList getListRequestForQuotationCode() {
        return listRequestForQuotationCode;
    }

    public void setListRequestForQuotationCode(ArrayList listRequestForQuotationCode) {
        this.listRequestForQuotationCode = listRequestForQuotationCode;
    }

    public RequestForQuotation getSearchRequestForQuotation() {
        return searchRequestForQuotation;
    }

    public void setSearchRequestForQuotation(RequestForQuotation searchRequestForQuotation) {
        this.searchRequestForQuotation = searchRequestForQuotation;
    }

    public Date getFirstDate() {
        return firstDate;
    }

    public void setFirstDate(Date firstDate) {
        this.firstDate = firstDate;
    }

    public Date getLastDate() {
        return lastDate;
    }

    public void setLastDate(Date lastDate) {
        this.lastDate = lastDate;
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

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getRequestForQuotationSearchApprovalStatus() {
        return requestForQuotationSearchApprovalStatus;
    }

    public void setRequestForQuotationSearchApprovalStatus(String requestForQuotationSearchApprovalStatus) {
        this.requestForQuotationSearchApprovalStatus = requestForQuotationSearchApprovalStatus;
    }
    
    // <editor-fold defaultstate="collapsed" desc="Paging">
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

    public String getRequestForQuotationApprovalSearchCode() {
        return requestForQuotationApprovalSearchCode;
    }

    public void setRequestForQuotationApprovalSearchCode(String requestForQuotationApprovalSearchCode) {
        this.requestForQuotationApprovalSearchCode = requestForQuotationApprovalSearchCode;
    }

    public String getRequestForQuotationApprovalSearchTenderNo() {
        return requestForQuotationApprovalSearchTenderNo;
    }

    public void setRequestForQuotationApprovalSearchTenderNo(String requestForQuotationApprovalSearchTenderNo) {
        this.requestForQuotationApprovalSearchTenderNo = requestForQuotationApprovalSearchTenderNo;
    }

    public String getRequestForQuotationApprovalSearchCustomerCode() {
        return requestForQuotationApprovalSearchCustomerCode;
    }

    public void setRequestForQuotationApprovalSearchCustomerCode(String requestForQuotationApprovalSearchCustomerCode) {
        this.requestForQuotationApprovalSearchCustomerCode = requestForQuotationApprovalSearchCustomerCode;
    }

    public String getRequestForQuotationApprovalSearchCustomerName() {
        return requestForQuotationApprovalSearchCustomerName;
    }

    public void setRequestForQuotationApprovalSearchCustomerName(String requestForQuotationApprovalSearchCustomerName) {
        this.requestForQuotationApprovalSearchCustomerName = requestForQuotationApprovalSearchCustomerName;
    }

    public String getRequestForQuotationApprovalSearchSubject() {
        return requestForQuotationApprovalSearchSubject;
    }

    public void setRequestForQuotationApprovalSearchSubject(String requestForQuotationApprovalSearchSubject) {
        this.requestForQuotationApprovalSearchSubject = requestForQuotationApprovalSearchSubject;
    }

    public String getRequestForQuotationApprovalSearchProjectCode() {
        return requestForQuotationApprovalSearchProjectCode;
    }

    public void setRequestForQuotationApprovalSearchProjectCode(String requestForQuotationApprovalSearchProjectCode) {
        this.requestForQuotationApprovalSearchProjectCode = requestForQuotationApprovalSearchProjectCode;
    }

    public String getRequestForQuotationApprovalSearchValidStatus() {
        return requestForQuotationApprovalSearchValidStatus;
    }

    public void setRequestForQuotationApprovalSearchValidStatus(String requestForQuotationApprovalSearchValidStatus) {
        this.requestForQuotationApprovalSearchValidStatus = requestForQuotationApprovalSearchValidStatus;
    }

    public String getRequestForQuotationApprovalSearchApprovalStatus() {
        return requestForQuotationApprovalSearchApprovalStatus;
    }

    public void setRequestForQuotationApprovalSearchApprovalStatus(String requestForQuotationApprovalSearchApprovalStatus) {
        this.requestForQuotationApprovalSearchApprovalStatus = requestForQuotationApprovalSearchApprovalStatus;
    }

    public Date getRequestForQuotationApprovalSearchFirstDate() {
        return requestForQuotationApprovalSearchFirstDate;
    }

    public void setRequestForQuotationApprovalSearchFirstDate(Date requestForQuotationApprovalSearchFirstDate) {
        this.requestForQuotationApprovalSearchFirstDate = requestForQuotationApprovalSearchFirstDate;
    }

    public Date getRequestForQuotationApprovalSearchLastDate() {
        return requestForQuotationApprovalSearchLastDate;
    }

    public void setRequestForQuotationApprovalSearchLastDate(Date requestForQuotationApprovalSearchLastDate) {
        this.requestForQuotationApprovalSearchLastDate = requestForQuotationApprovalSearchLastDate;
    }

    public String getUsedModule() {
        return usedModule;
    }

    public void setUsedModule(String usedModule) {
        this.usedModule = usedModule;
    }

    public RequestForQuotation getRequestForQuotationApproval() {
        return requestForQuotationApproval;
    }

    public void setRequestForQuotationApproval(RequestForQuotation requestForQuotationApproval) {
        this.requestForQuotationApproval = requestForQuotationApproval;
    }

    public List<RequestForQuotationTemp> getListRequestForQuotationApprovalTemp() {
        return listRequestForQuotationApprovalTemp;
    }

    public void setListRequestForQuotationApprovalTemp(List<RequestForQuotationTemp> listRequestForQuotationApprovalTemp) {
        this.listRequestForQuotationApprovalTemp = listRequestForQuotationApprovalTemp;
    }

    public String getRequestForQuotationSearchEndUserCode() {
        return requestForQuotationSearchEndUserCode;
    }

    public void setRequestForQuotationSearchEndUserCode(String requestForQuotationSearchEndUserCode) {
        this.requestForQuotationSearchEndUserCode = requestForQuotationSearchEndUserCode;
    }

    public String getRequestForQuotationSearchEndUserName() {
        return requestForQuotationSearchEndUserName;
    }

    public void setRequestForQuotationSearchEndUserName(String requestForQuotationSearchEndUserName) {
        this.requestForQuotationSearchEndUserName = requestForQuotationSearchEndUserName;
    }

    public String getRequestForQuotationApprovalSearchEndUserCode() {
        return requestForQuotationApprovalSearchEndUserCode;
    }

    public void setRequestForQuotationApprovalSearchEndUserCode(String requestForQuotationApprovalSearchEndUserCode) {
        this.requestForQuotationApprovalSearchEndUserCode = requestForQuotationApprovalSearchEndUserCode;
    }

    public String getRequestForQuotationApprovalSearchEndUserName() {
        return requestForQuotationApprovalSearchEndUserName;
    }

    public void setRequestForQuotationApprovalSearchEndUserName(String requestForQuotationApprovalSearchEndUserName) {
        this.requestForQuotationApprovalSearchEndUserName = requestForQuotationApprovalSearchEndUserName;
    }

    public String getRequestForQuotationClosingSearchCode() {
        return requestForQuotationClosingSearchCode;
    }

    public void setRequestForQuotationClosingSearchCode(String requestForQuotationClosingSearchCode) {
        this.requestForQuotationClosingSearchCode = requestForQuotationClosingSearchCode;
    }

    public String getRequestForQuotationClosingSearchTenderNo() {
        return requestForQuotationClosingSearchTenderNo;
    }

    public void setRequestForQuotationClosingSearchTenderNo(String requestForQuotationClosingSearchTenderNo) {
        this.requestForQuotationClosingSearchTenderNo = requestForQuotationClosingSearchTenderNo;
    }

    public String getRequestForQuotationClosingSearchCustomerCode() {
        return requestForQuotationClosingSearchCustomerCode;
    }

    public void setRequestForQuotationClosingSearchCustomerCode(String requestForQuotationClosingSearchCustomerCode) {
        this.requestForQuotationClosingSearchCustomerCode = requestForQuotationClosingSearchCustomerCode;
    }

    public String getRequestForQuotationClosingSearchCustomerName() {
        return requestForQuotationClosingSearchCustomerName;
    }

    public void setRequestForQuotationClosingSearchCustomerName(String requestForQuotationClosingSearchCustomerName) {
        this.requestForQuotationClosingSearchCustomerName = requestForQuotationClosingSearchCustomerName;
    }

    public String getRequestForQuotationClosingSearchSubject() {
        return requestForQuotationClosingSearchSubject;
    }

    public void setRequestForQuotationClosingSearchSubject(String requestForQuotationClosingSearchSubject) {
        this.requestForQuotationClosingSearchSubject = requestForQuotationClosingSearchSubject;
    }

    public String getRequestForQuotationClosingSearchProjectCode() {
        return requestForQuotationClosingSearchProjectCode;
    }

    public void setRequestForQuotationClosingSearchProjectCode(String requestForQuotationClosingSearchProjectCode) {
        this.requestForQuotationClosingSearchProjectCode = requestForQuotationClosingSearchProjectCode;
    }

    public String getRequestForQuotationClosingSearchValidStatus() {
        return requestForQuotationClosingSearchValidStatus;
    }

    public void setRequestForQuotationClosingSearchValidStatus(String requestForQuotationClosingSearchValidStatus) {
        this.requestForQuotationClosingSearchValidStatus = requestForQuotationClosingSearchValidStatus;
    }

    public String getRequestForQuotationClosingSearchClosingStatus() {
        return requestForQuotationClosingSearchClosingStatus;
    }

    public void setRequestForQuotationClosingSearchClosingStatus(String requestForQuotationClosingSearchClosingStatus) {
        this.requestForQuotationClosingSearchClosingStatus = requestForQuotationClosingSearchClosingStatus;
    }

    public String getRequestForQuotationClosingSearchEndUserCode() {
        return requestForQuotationClosingSearchEndUserCode;
    }

    public void setRequestForQuotationClosingSearchEndUserCode(String requestForQuotationClosingSearchEndUserCode) {
        this.requestForQuotationClosingSearchEndUserCode = requestForQuotationClosingSearchEndUserCode;
    }

    public String getRequestForQuotationClosingSearchEndUserName() {
        return requestForQuotationClosingSearchEndUserName;
    }

    public void setRequestForQuotationClosingSearchEndUserName(String requestForQuotationClosingSearchEndUserName) {
        this.requestForQuotationClosingSearchEndUserName = requestForQuotationClosingSearchEndUserName;
    }

    public Date getRequestForQuotationClosingSearchFirstDate() {
        return requestForQuotationClosingSearchFirstDate;
    }

    public void setRequestForQuotationClosingSearchFirstDate(Date requestForQuotationClosingSearchFirstDate) {
        this.requestForQuotationClosingSearchFirstDate = requestForQuotationClosingSearchFirstDate;
    }

    public Date getRequestForQuotationClosingSearchLastDate() {
        return requestForQuotationClosingSearchLastDate;
    }

    public void setRequestForQuotationClosingSearchLastDate(Date requestForQuotationClosingSearchLastDate) {
        this.requestForQuotationClosingSearchLastDate = requestForQuotationClosingSearchLastDate;
    }

    public List<RequestForQuotationTemp> getListRequestForQuotationClosingTemp() {
        return listRequestForQuotationClosingTemp;
    }

    public void setListRequestForQuotationClosingTemp(List<RequestForQuotationTemp> listRequestForQuotationClosingTemp) {
        this.listRequestForQuotationClosingTemp = listRequestForQuotationClosingTemp;
    }

    public String getRequestForQuotationSearchRefNo() {
        return requestForQuotationSearchRefNo;
    }

    public void setRequestForQuotationSearchRefNo(String requestForQuotationSearchRefNo) {
        this.requestForQuotationSearchRefNo = requestForQuotationSearchRefNo;
    }

    public String getRequestForQuotationSearchRemark() {
        return requestForQuotationSearchRemark;
    }

    public void setRequestForQuotationSearchRemark(String requestForQuotationSearchRemark) {
        this.requestForQuotationSearchRemark = requestForQuotationSearchRemark;
    }

    public String getRequestForQuotationApprovalSearchRefNo() {
        return requestForQuotationApprovalSearchRefNo;
    }

    public void setRequestForQuotationApprovalSearchRefNo(String requestForQuotationApprovalSearchRefNo) {
        this.requestForQuotationApprovalSearchRefNo = requestForQuotationApprovalSearchRefNo;
    }

    public String getRequestForQuotationApprovalSearchRemark() {
        return requestForQuotationApprovalSearchRemark;
    }

    public void setRequestForQuotationApprovalSearchRemark(String requestForQuotationApprovalSearchRemark) {
        this.requestForQuotationApprovalSearchRemark = requestForQuotationApprovalSearchRemark;
    }

    
}

