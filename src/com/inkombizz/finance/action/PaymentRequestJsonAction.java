
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumYearFormated;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.finance.bll.PaymentRequestBLL;
//import com.inkombizz.finance.model.DocumentBudgetTemp;
import com.inkombizz.finance.model.PaymentRequest;
import com.inkombizz.finance.model.PaymentRequestDetail;
import com.inkombizz.finance.model.PaymentRequestDetailTemp;
import com.inkombizz.finance.model.PaymentRequestTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Locale;

@Result (type = "json")
public class PaymentRequestJsonAction extends ActionSupport{
    
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private PaymentRequest paymentRequest;
    private PaymentRequest paymentRequestRelease;
    private PaymentRequest paymentRequestApproval;
        
    private PaymentRequestTemp paymentRequestTemp;
    private PaymentRequestTemp paymentRequestReleaseTemp;
    private PaymentRequestTemp paymentRequestApprovalTemp;
//    private DocumentBudgetTemp documentBudgetTemp;
        
    private List<PaymentRequest> listPaymentRequest;
    private List<PaymentRequestTemp> listPaymentRequestTemp;
    private List<PaymentRequestDetail> listPaymentRequestDetail;
    private List<PaymentRequestDetailTemp> listPaymentRequestDetailTemp;   
    private String listPaymentRequestDetailJSON;
    
    private String paymentRequestSearchCode="";
    private String paymentRequestSearchTransactionType="";
    private String paymentRequestSearchCurrencyCode="";
    private String paymentRequestSearchRequestType="";
    private String paymentRequestSearchPaymentTo="";
    private String paymentRequestSearchRefNo="";
    private String paymentRequestSearchRemark="";
    private Date paymentRequestSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date paymentRequestSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String paymentRequestReleaseSearchCode="";
    private String paymentRequestReleaseSearchStatus="PENDING";
    private Date paymentRequestReleaseSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date paymentRequestReleaseSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String paymentRequestApprovalSearchCode="";
    private String paymentRequestApprovalSearchRefNo = "";
    private String paymentRequestApprovalSearchRemark = "";
    private String paymentRequestApprovalSearchCreatedBy = "";
    private String paymentRequestApprovalSearchApprovedStatus = "PENDING";
    private Date paymentRequestApprovalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date paymentRequestApprovalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String chartOfAccountSetup="";
    private boolean documentForApprovedStatus = true;
    private BigDecimal totalPaymentRequestAmount = new BigDecimal("0.00");
  
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("payment-request-data")
    public String findData() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            ListPaging <PaymentRequestTemp> listPaging = paymentRequestBLL.findData(paging, paymentRequestSearchCode,paymentRequestSearchRefNo,paymentRequestSearchRemark,paymentRequestSearchFirstDate,paymentRequestSearchLastDate);
            
            listPaymentRequestTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-request-search-data-payment")
    public String findDataPayment() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            ListPaging <PaymentRequestTemp> listPaging = paymentRequestBLL.findDatapayment(paging, paymentRequestSearchCode, paymentRequestSearchTransactionType, paymentRequestSearchRequestType, paymentRequestSearchCurrencyCode);
            
            listPaymentRequestTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
      @Action("payment-request-chart-of-account")
    public String findBudgetType(){
        try{
            
            this.chartOfAccountSetup= BaseSession.loadProgramSession().getSetup().getCoaPurchaseDepositCode();

            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "ERROR DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-request-data-payment-detail")
    public String findDataPaymentDetail() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            List <PaymentRequestDetailTemp> list = paymentRequestBLL.findDatapaymentDetail(paymentRequestSearchCode);
            
            listPaymentRequestDetailTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-request-approval-data")
    public String findDataApproval() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            ListPaging <PaymentRequestTemp> listPaging = paymentRequestBLL.findDataApproval(paging, paymentRequestApprovalSearchCode,paymentRequestSearchPaymentTo,paymentRequestApprovalSearchRefNo,paymentRequestApprovalSearchRemark,paymentRequestApprovalSearchCreatedBy,paymentRequestApprovalSearchApprovedStatus,paymentRequestApprovalSearchFirstDate,paymentRequestApprovalSearchLastDate);
            
            listPaymentRequestTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("payment-request-released-confirmation")
    public String isReleasedStatus(){
        try{
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            
            paymentRequestBLL.isReleasedStatus(this.paymentRequest.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "PROCESS DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("payment-request-search-data")
    public String findDataSearch() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            ListPaging <PaymentRequestTemp> listPaging = paymentRequestBLL.findDataSearch(paging, paymentRequestSearchCode,paymentRequestSearchPaymentTo,paymentRequestSearchFirstDate,paymentRequestSearchLastDate);
            
            listPaymentRequestTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    
    @Action("payment-request-get")
    public String findDataGet() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            paymentRequestTemp = paymentRequestBLL.findData(paymentRequest.getCode());
            
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("payment-request-detail-data")
    public String findDataDetail(){
        try {
            
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            List<PaymentRequestDetailTemp> list = paymentRequestBLL.findDataDetail(paymentRequest.getCode());

            listPaymentRequestDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("payment-request-save")
    public String save(){
        String _Messg = "";
        try {
                        
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            Gson gson = new Gson();
            gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            this.listPaymentRequestDetail = gson.fromJson(this.listPaymentRequestDetailJSON, new TypeToken<List<PaymentRequestDetail>>(){}.getType());
                
            if(documentForApprovedStatus){
                paymentRequest.setApprovalBy(BaseSession.loadProgramSession().getUserName());
                paymentRequest.setApprovalDate(paymentRequest.getTransactionDate());
                paymentRequest.setApprovalStatus("PENDING");
            }
            
            SimpleDateFormat sdf = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
            int periodYear = Integer.parseInt(sdf.format(paymentRequest.getTransactionDate()));
            String periodYearS = String.valueOf(periodYear);
            
//            documentBudgetTemp = paymentRequestBLL.findAvailableBudget(paymentRequest.getBranch().getCode(),
//                    paymentRequest.getDivision().getDepartment().getCode(), periodYearS, "FINANCE_REQUEST", 
//                    paymentRequest.getCode());
//            
//            if (totalPaymentRequestAmount.doubleValue() > documentBudgetTemp.getBalanceBadgetAmount().doubleValue()) {
//                this.error = true;
//                this.errorMessage = " BUDGET NOT AVAILABLE.";
//                return SUCCESS;
//            }
            
            
            if(paymentRequestBLL.isExist(this.paymentRequest.getCode())){
                _Messg = "UPDATED ";
                paymentRequest.setTransactionDate(commonFunction.setDateTime(paymentRequestTemp.getTransactionDateTemp()));
                paymentRequest.setScheduleDate(commonFunction.setDateTime(paymentRequestTemp.getScheduleDateTemp()));
                paymentRequest.setCreatedDate(commonFunction.setDateTime(paymentRequestTemp.getCreatedDateTemp()));
                paymentRequestBLL.update(paymentRequest, listPaymentRequestDetail);
                
            }else{
                _Messg = "SAVED ";
                paymentRequest.setTransactionDate(DateUtils.newDateTime(paymentRequest.getTransactionDate(),true));
                paymentRequest.setScheduleDate(DateUtils.newDateTime(paymentRequest.getScheduleDate(),true));
                paymentRequest.setCreatedDate(DateUtils.newDateTime(paymentRequest.getCreatedDate(),false));
                
                paymentRequestBLL.save(paymentRequest, listPaymentRequestDetail);
            }

            this.message = _Messg + " DATA SUCCESS.<br/>PAYMENT REQUEST No : " + this.paymentRequest.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-request-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
                        
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            
            paymentRequestApproval.setTransactionDate(commonFunction.setDateTime(paymentRequestApprovalTemp.getTransactionDateTemp()));
            paymentRequestApproval.setUpdatedDate(commonFunction.setDateTime(paymentRequestApprovalTemp.getUpdatedDateTemp()));
            paymentRequestApproval.setCreatedDate(commonFunction.setDateTime(paymentRequestApprovalTemp.getCreatedDateTemp()));
            
            switch(this.paymentRequestApproval.getApprovalStatus()){
                case "PENDING":
                    _Messg="PENDING UPDATED ";
                    break;
                case "APPROVED":
                    _Messg="APPROVAL UPDATED ";
                    break;
                case "REJECTED":
                    _Messg="REJECTED UPDATED ";
                    break;
            }
                          
            paymentRequestBLL.approval(paymentRequestApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>FINANCE REQUEST No : " + this.paymentRequestApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("payment-request-paid-save")
//    public String savePaid(){
//        String _Messg = "";
//        try {
//                        
//            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
//            if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE_PAYMENT_PAID, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
//            }
//            
//            if(this.paymentRequestPaid.getPaidStatus().equals("PAID")){
//                _Messg="PAID UPDATED ";
//            }else{
//                _Messg="UNPAID UPDATED ";
//            }
//                          
//            paymentRequestBLL.paid(paymentRequestPaid);
//
//            this.message = _Messg + " DATA SUCCESS.<br/>PAYMENT REQUEST No : " + this.paymentRequestPaid.getCode();
//
//            return SUCCESS;
//        } catch (Exception e) {
//            this.error = true;
//            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
//            return SUCCESS;
//        }
//    }
    
    
    
    @Action("payment-request-delete")
    public String delete(){
        try{
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            
            paymentRequestBLL.delete(this.paymentRequest.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>FINANCE REQUEST No : " + this.paymentRequest.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("payment-request-confirmation")
    public String confirmApprovedStatus(){
        try{
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            
            if(paymentRequestBLL.isApproved(this.paymentRequest.getCode())){
                this.error = true;
                this.errorMessage = "Unable to Manipulate Data!<br/>this transaction ["+this.paymentRequest.getCode()+"] has been Approve!";
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
//    @Action("payment-request-budget-type")
//    public String findBudgetType(){
//        try{
//            
//            this.budgetTypeSetup= BaseSession.loadProgramSession().getSetup().getBudgetTypePurchaseDownPaymentCode();
//
//            return SUCCESS;
//        }
//        catch(Exception ex){
//            this.error = true;
//            this.errorMessage = "ERROR DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
   
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public PaymentRequest getPaymentRequest() {
        return paymentRequest;
    }

    public void setPaymentRequest(PaymentRequest paymentRequest) {
        this.paymentRequest = paymentRequest;
    }

    public PaymentRequest getPaymentRequestApproval() {
        return paymentRequestApproval;
    }

    public void setPaymentRequestApproval(PaymentRequest paymentRequestApproval) {
        this.paymentRequestApproval = paymentRequestApproval;
    }

    public PaymentRequestTemp getPaymentRequestTemp() {
        return paymentRequestTemp;
    }

    public void setPaymentRequestTemp(PaymentRequestTemp paymentRequestTemp) {
        this.paymentRequestTemp = paymentRequestTemp;
    }

    public PaymentRequestTemp getPaymentRequestApprovalTemp() {
        return paymentRequestApprovalTemp;
    }

    public void setPaymentRequestApprovalTemp(PaymentRequestTemp paymentRequestApprovalTemp) {
        this.paymentRequestApprovalTemp = paymentRequestApprovalTemp;
    }

    public List<PaymentRequest> getListPaymentRequest() {
        return listPaymentRequest;
    }

    public void setListPaymentRequest(List<PaymentRequest> listPaymentRequest) {
        this.listPaymentRequest = listPaymentRequest;
    }

    public List<PaymentRequestTemp> getListPaymentRequestTemp() {
        return listPaymentRequestTemp;
    }

    public void setListPaymentRequestTemp(List<PaymentRequestTemp> listPaymentRequestTemp) {
        this.listPaymentRequestTemp = listPaymentRequestTemp;
    }

    public List<PaymentRequestDetail> getListPaymentRequestDetail() {
        return listPaymentRequestDetail;
    }

    public void setListPaymentRequestDetail(List<PaymentRequestDetail> listPaymentRequestDetail) {
        this.listPaymentRequestDetail = listPaymentRequestDetail;
    }

    public List<PaymentRequestDetailTemp> getListPaymentRequestDetailTemp() {
        return listPaymentRequestDetailTemp;
    }

    public void setListPaymentRequestDetailTemp(List<PaymentRequestDetailTemp> listPaymentRequestDetailTemp) {
        this.listPaymentRequestDetailTemp = listPaymentRequestDetailTemp;
    }

    public String getListPaymentRequestDetailJSON() {
        return listPaymentRequestDetailJSON;
    }

    public void setListPaymentRequestDetailJSON(String listPaymentRequestDetailJSON) {
        this.listPaymentRequestDetailJSON = listPaymentRequestDetailJSON;
    }

    public String getPaymentRequestSearchCode() {
        return paymentRequestSearchCode;
    }

    public void setPaymentRequestSearchCode(String paymentRequestSearchCode) {
        this.paymentRequestSearchCode = paymentRequestSearchCode;
    }

    public String getPaymentRequestSearchRefNo() {
        return paymentRequestSearchRefNo;
    }

    public void setPaymentRequestSearchRefNo(String paymentRequestSearchRefNo) {
        this.paymentRequestSearchRefNo = paymentRequestSearchRefNo;
    }

    public String getPaymentRequestSearchRemark() {
        return paymentRequestSearchRemark;
    }

    public void setPaymentRequestSearchRemark(String paymentRequestSearchRemark) {
        this.paymentRequestSearchRemark = paymentRequestSearchRemark;
    }

    public Date getPaymentRequestSearchFirstDate() {
        return paymentRequestSearchFirstDate;
    }

    public void setPaymentRequestSearchFirstDate(Date paymentRequestSearchFirstDate) {
        this.paymentRequestSearchFirstDate = paymentRequestSearchFirstDate;
    }

    public Date getPaymentRequestSearchLastDate() {
        return paymentRequestSearchLastDate;
    }

    public void setPaymentRequestSearchLastDate(Date paymentRequestSearchLastDate) {
        this.paymentRequestSearchLastDate = paymentRequestSearchLastDate;
    }

    public String getPaymentRequestApprovalSearchCode() {
        return paymentRequestApprovalSearchCode;
    }

    public void setPaymentRequestApprovalSearchCode(String paymentRequestApprovalSearchCode) {
        this.paymentRequestApprovalSearchCode = paymentRequestApprovalSearchCode;
    }

    public String getPaymentRequestApprovalSearchRefNo() {
        return paymentRequestApprovalSearchRefNo;
    }

    public void setPaymentRequestApprovalSearchRefNo(String paymentRequestApprovalSearchRefNo) {
        this.paymentRequestApprovalSearchRefNo = paymentRequestApprovalSearchRefNo;
    }

    public String getPaymentRequestApprovalSearchRemark() {
        return paymentRequestApprovalSearchRemark;
    }

    public void setPaymentRequestApprovalSearchRemark(String paymentRequestApprovalSearchRemark) {
        this.paymentRequestApprovalSearchRemark = paymentRequestApprovalSearchRemark;
    }

    public String getPaymentRequestApprovalSearchApprovedStatus() {
        return paymentRequestApprovalSearchApprovedStatus;
    }

    public void setPaymentRequestApprovalSearchApprovedStatus(String paymentRequestApprovalSearchApprovedStatus) {
        this.paymentRequestApprovalSearchApprovedStatus = paymentRequestApprovalSearchApprovedStatus;
    }

    public Date getPaymentRequestApprovalSearchFirstDate() {
        return paymentRequestApprovalSearchFirstDate;
    }

    public void setPaymentRequestApprovalSearchFirstDate(Date paymentRequestApprovalSearchFirstDate) {
        this.paymentRequestApprovalSearchFirstDate = paymentRequestApprovalSearchFirstDate;
    }

    public Date getPaymentRequestApprovalSearchLastDate() {
        return paymentRequestApprovalSearchLastDate;
    }

    public void setPaymentRequestApprovalSearchLastDate(Date paymentRequestApprovalSearchLastDate) {
        this.paymentRequestApprovalSearchLastDate = paymentRequestApprovalSearchLastDate;
    }

    public String getPaymentRequestSearchPaymentTo() {
        return paymentRequestSearchPaymentTo;
    }

    public void setPaymentRequestSearchPaymentTo(String paymentRequestSearchPaymentTo) {
        this.paymentRequestSearchPaymentTo = paymentRequestSearchPaymentTo;
    }

    public String getChartOfAccountSetup() {
        return chartOfAccountSetup;
    }

    public void setChartOfAccountSetup(String chartOfAccountSetup) {
        this.chartOfAccountSetup = chartOfAccountSetup;
    }
 
    public boolean isDocumentForApprovedStatus() {
        return documentForApprovedStatus;
    }

    public void setDocumentForApprovedStatus(boolean documentForApprovedStatus) {
        this.documentForApprovedStatus = documentForApprovedStatus;
    }

    public BigDecimal getTotalPaymentRequestAmount() {
        return totalPaymentRequestAmount;
    }

    public void setTotalPaymentRequestAmount(BigDecimal totalPaymentRequestAmount) {
        this.totalPaymentRequestAmount = totalPaymentRequestAmount;
    }

    public PaymentRequest getPaymentRequestRelease() {
        return paymentRequestRelease;
    }

    public void setPaymentRequestRelease(PaymentRequest paymentRequestRelease) {
        this.paymentRequestRelease = paymentRequestRelease;
    }

    public String getPaymentRequestReleaseSearchCode() {
        return paymentRequestReleaseSearchCode;
    }

    public void setPaymentRequestReleaseSearchCode(String paymentRequestReleaseSearchCode) {
        this.paymentRequestReleaseSearchCode = paymentRequestReleaseSearchCode;
    }

    public String getPaymentRequestReleaseSearchStatus() {
        return paymentRequestReleaseSearchStatus;
    }

    public void setPaymentRequestReleaseSearchStatus(String paymentRequestReleaseSearchStatus) {
        this.paymentRequestReleaseSearchStatus = paymentRequestReleaseSearchStatus;
    }

    public Date getPaymentRequestReleaseSearchFirstDate() {
        return paymentRequestReleaseSearchFirstDate;
    }

    public void setPaymentRequestReleaseSearchFirstDate(Date paymentRequestReleaseSearchFirstDate) {
        this.paymentRequestReleaseSearchFirstDate = paymentRequestReleaseSearchFirstDate;
    }

    public Date getPaymentRequestReleaseSearchLastDate() {
        return paymentRequestReleaseSearchLastDate;
    }

    public void setPaymentRequestReleaseSearchLastDate(Date paymentRequestReleaseSearchLastDate) {
        this.paymentRequestReleaseSearchLastDate = paymentRequestReleaseSearchLastDate;
    }

    public PaymentRequestTemp getPaymentRequestReleaseTemp() {
        return paymentRequestReleaseTemp;
    }

    public void setPaymentRequestReleaseTemp(PaymentRequestTemp paymentRequestReleaseTemp) {
        this.paymentRequestReleaseTemp = paymentRequestReleaseTemp;
    }

    public String getPaymentRequestSearchTransactionType() {
        return paymentRequestSearchTransactionType;
    }

    public void setPaymentRequestSearchTransactionType(String paymentRequestSearchTransactionType) {
        this.paymentRequestSearchTransactionType = paymentRequestSearchTransactionType;
    }

    public String getPaymentRequestSearchCurrencyCode() {
        return paymentRequestSearchCurrencyCode;
    }

    public void setPaymentRequestSearchCurrencyCode(String paymentRequestSearchCurrencyCode) {
        this.paymentRequestSearchCurrencyCode = paymentRequestSearchCurrencyCode;
    }

    public String getPaymentRequestSearchRequestType() {
        return paymentRequestSearchRequestType;
    }

    public void setPaymentRequestSearchRequestType(String paymentRequestSearchRequestType) {
        this.paymentRequestSearchRequestType = paymentRequestSearchRequestType;
    }

    public String getPaymentRequestApprovalSearchCreatedBy() {
        return paymentRequestApprovalSearchCreatedBy;
    }

    public void setPaymentRequestApprovalSearchCreatedBy(String paymentRequestApprovalSearchCreatedBy) {
        this.paymentRequestApprovalSearchCreatedBy = paymentRequestApprovalSearchCreatedBy;
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
