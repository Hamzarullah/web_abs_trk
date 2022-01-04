
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.finance.bll.CashReceivedBLL;
import com.inkombizz.finance.model.CashReceived;
import com.inkombizz.finance.model.CashReceivedDetail;
import com.inkombizz.finance.model.CashReceivedDetailTemp;
import com.inkombizz.finance.model.CashReceivedDeposit;
import com.inkombizz.finance.model.CashReceivedDepositTemp;
import com.inkombizz.finance.model.CashReceivedTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.math.BigDecimal;

@Result (type = "json")
public class CashReceivedJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    
    private CashReceived cashReceived;    
    private CashReceivedTemp cashReceivedTemp;
    private CashReceived cashReceivedAccSpv;    
    private CashReceivedTemp cashReceivedAccSpvTemp;
    private CashReceivedDeposit cashReceivedDepositUpdate;    
    private CashReceivedDepositTemp cashReceivedDepositTemp;
    private List<CashReceived> listCashReceived; 
    private List<CashReceived> listCashReceivedAccSpv;
    private List<CashReceivedDetail> listCashReceivedDetail;
    private List<CashReceivedTemp> listCashReceivedTemp;
    private List<CashReceivedTemp> listCashReceivedAccSpvTemp;
    private List<CashReceivedDetailTemp> listCashReceivedDetailTemp;
    private List<CashReceivedDepositTemp> listCashReceivedDepositTemp;
    private String listCashReceivedDetailJSON;
    private String cashReceivedSearchCode="";
    private String cashReceivedSearchReceivedFrom="";
    private String cashReceivedCashAccountSearchCode = ""; 
    private String cashReceivedCashAccountSearchName = "";
    private BigDecimal cashReceivedSearchFirstTotalAmount=new BigDecimal("0.00");
    private BigDecimal cashReceivedSearchLastTotalAmount=new BigDecimal("1000000000.00");
    private String cashReceivedSearchRemark="";
    private Date cashReceivedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date cashReceivedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String cashReceivedDepositUpdateSearchCode="";
    private String cashReceivedDepositUpdateSearchReceivedFrom="";
    private Date cashReceivedDepositUpdateSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date cashReceivedDepositUpdateSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Double forexAmount;
    private String actionAuthority="";
    private String userCodeTemp=BaseSession.loadProgramSession().getUserCode(); 
    private String cashReceivedAccSpvSearchCode="";
    private String cashReceivedAccSpvSearchReceivedFrom="";
    private String cashReceivedAccSpvCashAccountSearchCode = ""; 
    private String cashReceivedAccSpvCashAccountSearchName = "";
    private BigDecimal cashReceivedAccSpvSearchFirstTotalAmount=new BigDecimal("0.00");
    private BigDecimal cashReceivedAccSpvSearchLastTotalAmount=new BigDecimal("1000000000.00");
    private String cashReceivedAccSpvSearchRemark="";
    private Date cashReceivedAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date cashReceivedAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String cashReceivedAccSpvSearchAccStatus="Open";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("cash-received-data")
    public String findData() {
        try {
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            ListPaging <CashReceivedTemp> listPaging = cashReceivedBLL.findData(paging,userCodeTemp,cashReceivedSearchCode, cashReceivedSearchReceivedFrom,cashReceivedCashAccountSearchCode,cashReceivedCashAccountSearchName,cashReceivedSearchFirstTotalAmount,cashReceivedSearchLastTotalAmount,cashReceivedSearchRemark,cashReceivedSearchFirstDate, cashReceivedSearchLastDate);
            
            listCashReceivedTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("cash-received-acc-spv-data")
    public String findDataAccSpv() {
        try {
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            ListPaging <CashReceivedTemp> listPaging = cashReceivedBLL.findDataAccSpv(paging,userCodeTemp,cashReceivedAccSpvSearchCode, cashReceivedAccSpvSearchReceivedFrom,cashReceivedAccSpvCashAccountSearchCode,cashReceivedAccSpvCashAccountSearchName,cashReceivedAccSpvSearchFirstTotalAmount,cashReceivedAccSpvSearchLastTotalAmount,cashReceivedAccSpvSearchRemark,cashReceivedAccSpvSearchFirstDate, cashReceivedAccSpvSearchLastDate,cashReceivedAccSpvSearchAccStatus);
            
            listCashReceivedAccSpvTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("cash-received-deposit-data")
    public String findDataDeposit() {
        try {
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            ListPaging <CashReceivedDepositTemp> listPaging = cashReceivedBLL.findDataDeposit(paging,cashReceivedDepositUpdateSearchCode, cashReceivedDepositUpdateSearchFirstDate,cashReceivedDepositUpdateSearchLastDate);
            
            listCashReceivedDepositTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-received-detail-data")
    public String findDataDetail(){
        try {
            
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            List<CashReceivedDetailTemp> list = cashReceivedBLL.findDataDetail(cashReceived.getCode());

            listCashReceivedDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
  
    @Action("cash-received-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            Gson gson = new Gson();
            this.listCashReceivedDetail = gson.fromJson(this.listCashReceivedDetailJSON, new TypeToken<List<CashReceivedDetail>>(){}.getType());
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(cashReceivedTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            cashReceived.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(cashReceivedTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            cashReceived.setCreatedDate(getCreatedDateTemp);
            
//            if(cashReceived.getCustomer().getCode().equals("")){
//                cashReceived.setCustomer(null);
//            }
            
            if(cashReceivedBLL.isExist(this.cashReceived.getCode())){
                _Messg="UPDATED ";

                cashReceivedBLL.update(cashReceived, listCashReceivedDetail, forexAmount);
                
            }else{
                
                 _Messg = "SAVED ";
                 
                 Timestamp currentTimestamp = new java.sql.Timestamp(cashReceived.getTransactionDate().getTime());
                 cashReceived.setTransactionDate(currentTimestamp);
                 
                 cashReceivedBLL.save(cashReceived, listCashReceivedDetail, forexAmount);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>CASH RECEIVED No : " + this.cashReceived.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("cash-received-acc-spv-save")
    public String saveAccSpv(){
        String _Messg = "";
        try {
                        
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            Gson gson = new Gson();
            this.listCashReceivedDetail = gson.fromJson(this.listCashReceivedDetailJSON, new TypeToken<List<CashReceivedDetail>>(){}.getType());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(cashReceivedAccSpvTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            cashReceivedAccSpv.setTransactionDate(getTransactionDateTemp);
            
            
            Date createdDateTemp = sdf.parse(cashReceivedAccSpvTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            cashReceivedAccSpv.setCreatedDate(getCreatedDateTemp);
            
            _Messg="ACC UPDATED ";
              
            cashReceivedBLL.update(cashReceivedAccSpv, listCashReceivedDetail, forexAmount);

            this.message = _Messg + " DATA SUCCESS.<br/>BANK RECEIVED No : " + this.cashReceivedAccSpv.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-received-delete")
    public String delete(){
        try{
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(cashReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            cashReceivedBLL.delete(this.cashReceived.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>CASH RECEIVED No : " + this.cashReceived.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("cash-received-update")
    public String updateDeposit(){
        try {
                        
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

            Date TransactionDateTemp = sdf.parse(cashReceivedDepositTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            cashReceivedDepositUpdate.setTransactionDate(getTransactionDateTemp);
            
            Date createdDateTemp = sdf.parse(cashReceivedDepositTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            cashReceivedDepositUpdate.setCreatedDate(getCreatedDateTemp);   
            
            cashReceivedBLL.updateDeposit(cashReceivedDepositUpdate);

            this.message ="UPDATE DOWN PAYMENT CUSTOMER DATA SUCCESS.<br/>CASH RECEIVED No : " + this.cashReceivedDepositUpdate.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage ="UPDATE DOWN PAYMENT CUSTOMER DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-received-authority-delete")
    public String cashReceivedAuthorityDelete(){
        try{
            
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            
            switch(actionAuthority){
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cashReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    public CashReceived getCashReceived() {
        return cashReceived;
    }

    public void setCashReceived(CashReceived cashReceived) {
        this.cashReceived = cashReceived;
    }

    public CashReceivedTemp getCashReceivedTemp() {
        return cashReceivedTemp;
    }

    public void setCashReceivedTemp(CashReceivedTemp cashReceivedTemp) {
        this.cashReceivedTemp = cashReceivedTemp;
    }

    public List<CashReceived> getListCashReceived() {
        return listCashReceived;
    }

    public void setListCashReceived(List<CashReceived> listCashReceived) {
        this.listCashReceived = listCashReceived;
    }

    public List<CashReceivedDetail> getListCashReceivedDetail() {
        return listCashReceivedDetail;
    }

    public void setListCashReceivedDetail(List<CashReceivedDetail> listCashReceivedDetail) {
        this.listCashReceivedDetail = listCashReceivedDetail;
    }

    public List<CashReceivedTemp> getListCashReceivedTemp() {
        return listCashReceivedTemp;
    }

    public void setListCashReceivedTemp(List<CashReceivedTemp> listCashReceivedTemp) {
        this.listCashReceivedTemp = listCashReceivedTemp;
    }

    public List<CashReceivedDetailTemp> getListCashReceivedDetailTemp() {
        return listCashReceivedDetailTemp;
    }

    public void setListCashReceivedDetailTemp(List<CashReceivedDetailTemp> listCashReceivedDetailTemp) {
        this.listCashReceivedDetailTemp = listCashReceivedDetailTemp;
    }

    public String getListCashReceivedDetailJSON() {
        return listCashReceivedDetailJSON;
    }

    public void setListCashReceivedDetailJSON(String listCashReceivedDetailJSON) {
        this.listCashReceivedDetailJSON = listCashReceivedDetailJSON;
    }

    public String getCashReceivedSearchCode() {
        return cashReceivedSearchCode;
    }

    public void setCashReceivedSearchCode(String cashReceivedSearchCode) {
        this.cashReceivedSearchCode = cashReceivedSearchCode;
    }

    public String getCashReceivedSearchReceivedFrom() {
        return cashReceivedSearchReceivedFrom;
    }

    public void setCashReceivedSearchReceivedFrom(String cashReceivedSearchReceivedFrom) {
        this.cashReceivedSearchReceivedFrom = cashReceivedSearchReceivedFrom;
    }


    public Date getCashReceivedSearchFirstDate() {
        return cashReceivedSearchFirstDate;
    }

    public void setCashReceivedSearchFirstDate(Date cashReceivedSearchFirstDate) {
        this.cashReceivedSearchFirstDate = cashReceivedSearchFirstDate;
    }

    public Date getCashReceivedSearchLastDate() {
        return cashReceivedSearchLastDate;
    }

    public void setCashReceivedSearchLastDate(Date cashReceivedSearchLastDate) {
        this.cashReceivedSearchLastDate = cashReceivedSearchLastDate;
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

    public String getCashReceivedDepositUpdateSearchCode() {
        return cashReceivedDepositUpdateSearchCode;
    }

    public void setCashReceivedDepositUpdateSearchCode(String cashReceivedDepositUpdateSearchCode) {
        this.cashReceivedDepositUpdateSearchCode = cashReceivedDepositUpdateSearchCode;
    }

    public String getCashReceivedDepositUpdateSearchReceivedFrom() {
        return cashReceivedDepositUpdateSearchReceivedFrom;
    }

    public void setCashReceivedDepositUpdateSearchReceivedFrom(String cashReceivedDepositUpdateSearchReceivedFrom) {
        this.cashReceivedDepositUpdateSearchReceivedFrom = cashReceivedDepositUpdateSearchReceivedFrom;
    }

    public Date getCashReceivedDepositUpdateSearchFirstDate() {
        return cashReceivedDepositUpdateSearchFirstDate;
    }

    public void setCashReceivedDepositUpdateSearchFirstDate(Date cashReceivedDepositUpdateSearchFirstDate) {
        this.cashReceivedDepositUpdateSearchFirstDate = cashReceivedDepositUpdateSearchFirstDate;
    }

    public Date getCashReceivedDepositUpdateSearchLastDate() {
        return cashReceivedDepositUpdateSearchLastDate;
    }

    public void setCashReceivedDepositUpdateSearchLastDate(Date cashReceivedDepositUpdateSearchLastDate) {
        this.cashReceivedDepositUpdateSearchLastDate = cashReceivedDepositUpdateSearchLastDate;
    }

    public String getCashReceivedCashAccountSearchCode() {
        return cashReceivedCashAccountSearchCode;
    }

    public void setCashReceivedCashAccountSearchCode(String cashReceivedCashAccountSearchCode) {
        this.cashReceivedCashAccountSearchCode = cashReceivedCashAccountSearchCode;
    }

    public String getCashReceivedCashAccountSearchName() {
        return cashReceivedCashAccountSearchName;
    }

    public void setCashReceivedCashAccountSearchName(String cashReceivedCashAccountSearchName) {
        this.cashReceivedCashAccountSearchName = cashReceivedCashAccountSearchName;
    }

    public BigDecimal getCashReceivedSearchFirstTotalAmount() {
        return cashReceivedSearchFirstTotalAmount;
    }

    public void setCashReceivedSearchFirstTotalAmount(BigDecimal cashReceivedSearchFirstTotalAmount) {
        this.cashReceivedSearchFirstTotalAmount = cashReceivedSearchFirstTotalAmount;
    }

    public BigDecimal getCashReceivedSearchLastTotalAmount() {
        return cashReceivedSearchLastTotalAmount;
    }

    public void setCashReceivedSearchLastTotalAmount(BigDecimal cashReceivedSearchLastTotalAmount) {
        this.cashReceivedSearchLastTotalAmount = cashReceivedSearchLastTotalAmount;
    }

    public String getCashReceivedSearchRemark() {
        return cashReceivedSearchRemark;
    }

    public void setCashReceivedSearchRemark(String cashReceivedSearchRemark) {
        this.cashReceivedSearchRemark = cashReceivedSearchRemark;
    }

    

    public CashReceivedDepositTemp getCashReceivedDepositTemp() {
        return cashReceivedDepositTemp;
    }

    public void setCashReceivedDepositTemp(CashReceivedDepositTemp cashReceivedDepositTemp) {
        this.cashReceivedDepositTemp = cashReceivedDepositTemp;
    }

    public List<CashReceivedDepositTemp> getListCashReceivedDepositTemp() {
        return listCashReceivedDepositTemp;
    }

    public void setListCashReceivedDepositTemp(List<CashReceivedDepositTemp> listCashReceivedDepositTemp) {
        this.listCashReceivedDepositTemp = listCashReceivedDepositTemp;
    }

    public CashReceivedDeposit getCashReceivedDepositUpdate() {
        return cashReceivedDepositUpdate;
    }

    public void setCashReceivedDepositUpdate(CashReceivedDeposit cashReceivedDepositUpdate) {
        this.cashReceivedDepositUpdate = cashReceivedDepositUpdate;
    }

    public String getUserCodeTemp() {
        return userCodeTemp;
    }

    public void setUserCodeTemp(String userCodeTemp) {
        this.userCodeTemp = userCodeTemp;
    }

    public String getCashReceivedAccSpvSearchAccStatus() {
        return cashReceivedAccSpvSearchAccStatus;
    }

    public void setCashReceivedAccSpvSearchAccStatus(String cashReceivedAccSpvSearchAccStatus) {
        this.cashReceivedAccSpvSearchAccStatus = cashReceivedAccSpvSearchAccStatus;
    }

    public String getCashReceivedAccSpvSearchCode() {
        return cashReceivedAccSpvSearchCode;
    }

    public void setCashReceivedAccSpvSearchCode(String cashReceivedAccSpvSearchCode) {
        this.cashReceivedAccSpvSearchCode = cashReceivedAccSpvSearchCode;
    }

    public String getCashReceivedAccSpvSearchReceivedFrom() {
        return cashReceivedAccSpvSearchReceivedFrom;
    }

    public void setCashReceivedAccSpvSearchReceivedFrom(String cashReceivedAccSpvSearchReceivedFrom) {
        this.cashReceivedAccSpvSearchReceivedFrom = cashReceivedAccSpvSearchReceivedFrom;
    }

    public String getCashReceivedAccSpvCashAccountSearchCode() {
        return cashReceivedAccSpvCashAccountSearchCode;
    }

    public void setCashReceivedAccSpvCashAccountSearchCode(String cashReceivedAccSpvCashAccountSearchCode) {
        this.cashReceivedAccSpvCashAccountSearchCode = cashReceivedAccSpvCashAccountSearchCode;
    }

    public String getCashReceivedAccSpvCashAccountSearchName() {
        return cashReceivedAccSpvCashAccountSearchName;
    }

    public void setCashReceivedAccSpvCashAccountSearchName(String cashReceivedAccSpvCashAccountSearchName) {
        this.cashReceivedAccSpvCashAccountSearchName = cashReceivedAccSpvCashAccountSearchName;
    }

    public BigDecimal getCashReceivedAccSpvSearchFirstTotalAmount() {
        return cashReceivedAccSpvSearchFirstTotalAmount;
    }

    public void setCashReceivedAccSpvSearchFirstTotalAmount(BigDecimal cashReceivedAccSpvSearchFirstTotalAmount) {
        this.cashReceivedAccSpvSearchFirstTotalAmount = cashReceivedAccSpvSearchFirstTotalAmount;
    }

    public BigDecimal getCashReceivedAccSpvSearchLastTotalAmount() {
        return cashReceivedAccSpvSearchLastTotalAmount;
    }

    public void setCashReceivedAccSpvSearchLastTotalAmount(BigDecimal cashReceivedAccSpvSearchLastTotalAmount) {
        this.cashReceivedAccSpvSearchLastTotalAmount = cashReceivedAccSpvSearchLastTotalAmount;
    }

    public String getCashReceivedAccSpvSearchRemark() {
        return cashReceivedAccSpvSearchRemark;
    }

    public void setCashReceivedAccSpvSearchRemark(String cashReceivedAccSpvSearchRemark) {
        this.cashReceivedAccSpvSearchRemark = cashReceivedAccSpvSearchRemark;
    }

    public Date getCashReceivedAccSpvSearchFirstDate() {
        return cashReceivedAccSpvSearchFirstDate;
    }

    public void setCashReceivedAccSpvSearchFirstDate(Date cashReceivedAccSpvSearchFirstDate) {
        this.cashReceivedAccSpvSearchFirstDate = cashReceivedAccSpvSearchFirstDate;
    }

    public Date getCashReceivedAccSpvSearchLastDate() {
        return cashReceivedAccSpvSearchLastDate;
    }

    public void setCashReceivedAccSpvSearchLastDate(Date cashReceivedAccSpvSearchLastDate) {
        this.cashReceivedAccSpvSearchLastDate = cashReceivedAccSpvSearchLastDate;
    }

    public CashReceived getCashReceivedAccSpv() {
        return cashReceivedAccSpv;
    }

    public void setCashReceivedAccSpv(CashReceived cashReceivedAccSpv) {
        this.cashReceivedAccSpv = cashReceivedAccSpv;
    }

    public CashReceivedTemp getCashReceivedAccSpvTemp() {
        return cashReceivedAccSpvTemp;
    }

    public void setCashReceivedAccSpvTemp(CashReceivedTemp cashReceivedAccSpvTemp) {
        this.cashReceivedAccSpvTemp = cashReceivedAccSpvTemp;
    }

    public List<CashReceived> getListCashReceivedAccSpv() {
        return listCashReceivedAccSpv;
    }

    public void setListCashReceivedAccSpv(List<CashReceived> listCashReceivedAccSpv) {
        this.listCashReceivedAccSpv = listCashReceivedAccSpv;
    }

    public List<CashReceivedTemp> getListCashReceivedAccSpvTemp() {
        return listCashReceivedAccSpvTemp;
    }

    public void setListCashReceivedAccSpvTemp(List<CashReceivedTemp> listCashReceivedAccSpvTemp) {
        this.listCashReceivedAccSpvTemp = listCashReceivedAccSpvTemp;
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
