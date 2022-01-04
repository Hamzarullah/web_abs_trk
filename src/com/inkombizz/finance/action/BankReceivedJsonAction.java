
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

import com.inkombizz.finance.bll.BankReceivedBLL;
import com.inkombizz.finance.model.BankReceived;
import com.inkombizz.finance.model.BankReceivedDetail;
import com.inkombizz.finance.model.BankReceivedDetailTemp;
import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.BankReceivedDepositTemp;
import com.inkombizz.finance.model.BankReceivedTemp;
import java.math.BigDecimal;

@Result (type = "json")
public class BankReceivedJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private BankReceived bankReceived;
    private BankReceived bankReceivedAccSpv;
    private BankReceivedDeposit bankReceivedDepositUpdate;
    private BankReceivedTemp bankReceivedTemp;
    private BankReceivedTemp bankReceivedAccSpvTemp;
    private BankReceivedDepositTemp bankReceivedDepositTemp;
    private List<BankReceived> listBankReceived;
    private List<BankReceivedDetail> listBankReceivedDetail;
    private List<BankReceivedTemp> listBankReceivedTemp;
    private List<BankReceivedDepositTemp> listBankReceivedDepositTemp;
    private List<BankReceivedDetailTemp> listBankReceivedDetailTemp;
        
    private String listBankReceivedDetailJSON;
    private String bankReceivedSearchCode="";
    private String bankReceivedSearchReceivedFrom="";
    private String bankReceivedBankAccountSearchCode = "";
    private String bankReceivedBankAccountSearchName = "";
    private BigDecimal bankReceivedSearchFirstTotalAmount=new BigDecimal("0.00");
    private BigDecimal bankReceivedSearchLastTotalAmount=new BigDecimal("1000000000000.00");
    private String bankReceivedSearchRemark="";
    private Date bankReceivedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date bankReceivedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String bankReceivedDepositUpdateSearchCode="";
    private String bankReceivedDepositUpdateSearchReceivedFrom="";
    private Date bankReceivedDepositUpdateSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date bankReceivedDepositUpdateSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Double forexAmount;
    private String actionAuthority="";
    private String userCodeTemp=BaseSession.loadProgramSession().getUserCode();
    
    private String bankReceivedAccSpvSearchCode="";
    private String bankReceivedAccSpvSearchReceivedFrom="";
    private String bankReceivedAccSpvBankAccountSearchCode = "";
    private String bankReceivedAccSpvBankAccountSearchName = "";
    private BigDecimal bankReceivedAccSpvSearchFirstTotalAmount=new BigDecimal("0.00");
    private BigDecimal bankReceivedAccSpvSearchLastTotalAmount=new BigDecimal("1000000000000.00");
    private String bankReceivedAccSpvSearchRemark="";
    private Date bankReceivedAccSpvSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date bankReceivedAccSpvSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String bankReceivedAccSpvSearchAccStatus = "Open";

    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("bank-received-data")
    public String findData() {
        try {
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            ListPaging <BankReceivedTemp> listPaging = bankReceivedBLL.findData(paging,userCodeTemp,bankReceivedSearchCode, bankReceivedSearchReceivedFrom,bankReceivedBankAccountSearchCode,bankReceivedBankAccountSearchName,bankReceivedSearchFirstTotalAmount,bankReceivedSearchLastTotalAmount,bankReceivedSearchRemark, bankReceivedSearchFirstDate, bankReceivedSearchLastDate);
            
            listBankReceivedTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("bank-received-deposit-data")
    public String findDataDeposit() {
        try {
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            ListPaging <BankReceivedDepositTemp> listPaging = bankReceivedBLL.findDataDeposit(paging,bankReceivedDepositUpdateSearchCode, bankReceivedDepositUpdateSearchFirstDate,bankReceivedDepositUpdateSearchLastDate);
            
            listBankReceivedDepositTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-received-detail-data")
    public String findDataDetail(){
        try {
            
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            List<BankReceivedDetailTemp> list = bankReceivedBLL.findDataDetail(bankReceived.getCode());

            listBankReceivedDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-received-save")
    public String save(){
        String _Messg = "";
        try {
                        
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            Gson gson = new Gson();
            this.listBankReceivedDetail = gson.fromJson(this.listBankReceivedDetailJSON, new TypeToken<List<BankReceivedDetail>>(){}.getType());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(bankReceivedTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            bankReceived.setTransactionDate(getTransactionDateTemp);
            
            Date transferReceivedDateTemp = sdf.parse(bankReceivedTemp.getTransferReceivedDateTemp());
            Date getTransferReceivedDateTemp = new java.sql.Timestamp(transferReceivedDateTemp.getTime());
            bankReceived.setTransferReceivedDate(getTransferReceivedDateTemp);
            
            Date createdDateTemp = sdf.parse(bankReceivedTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(createdDateTemp.getTime());
            bankReceived.setCreatedDate(getCreatedDateTemp);

//            if(bankReceived.getCustomer().getCode().equals("")){
//                bankReceived.setCustomer(null);
//            }
        
            if(bankReceivedBLL.isExist(this.bankReceived.getCode())){
                _Messg="UPDATED ";

                bankReceivedBLL.update(bankReceived, listBankReceivedDetail, forexAmount);
                
            }else{
                
                 _Messg = "SAVED ";

                 bankReceivedBLL.save(bankReceived, listBankReceivedDetail, forexAmount);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>BANK RECEIVED No : " + this.bankReceived.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-received-delete")
    public String delete(){
        try{
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(bankReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            bankReceivedBLL.delete(this.bankReceived.getCode());
            this.message ="DELETE DATA SUCCESS.<br/>BANK RECEIVED No : " + this.bankReceived.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-received-update")
    public String updateDeposit(){
        try {
                        
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date TransactionDateTemp = sdf.parse(bankReceivedDepositTemp.getTransactionDateTemp());
            Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
            bankReceivedDepositUpdate.setTransactionDate(getTransactionDateTemp);
            Date cretadDateTemp = sdf.parse(bankReceivedDepositTemp.getCreatedDateTemp());
            Date getCreatedDateTemp = new java.sql.Timestamp(cretadDateTemp.getTime());
            bankReceivedDepositUpdate.setCreatedDate(getCreatedDateTemp);
            
            bankReceivedBLL.updateDeposit(bankReceivedDepositUpdate);

            this.message ="UPDATE DOWN PAYMENT CUSTOMER DATA SUCCESS.<br/>BANK RECEIVED No : " + this.bankReceivedDepositUpdate.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage ="UPDATE DOWN PAYMENT CUSTOMER DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-received-authority-delete")
    public String bankReceivedAuthorityDelete(){
        try{
            
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            
            switch(actionAuthority){
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    public BankReceived getBankReceived() {
        return bankReceived;
    }

    public void setBankReceived(BankReceived bankReceived) {
        this.bankReceived = bankReceived;
    }

    public BankReceivedTemp getBankReceivedTemp() {
        return bankReceivedTemp;
    }

    public void setBankReceivedTemp(BankReceivedTemp bankReceivedTemp) {
        this.bankReceivedTemp = bankReceivedTemp;
    }

    public List<BankReceived> getListBankReceived() {
        return listBankReceived;
    }

    public void setListBankReceived(List<BankReceived> listBankReceived) {
        this.listBankReceived = listBankReceived;
    }

    public List<BankReceivedDetail> getListBankReceivedDetail() {
        return listBankReceivedDetail;
    }

    public void setListBankReceivedDetail(List<BankReceivedDetail> listBankReceivedDetail) {
        this.listBankReceivedDetail = listBankReceivedDetail;
    }

    public List<BankReceivedTemp> getListBankReceivedTemp() {
        return listBankReceivedTemp;
    }

    public void setListBankReceivedTemp(List<BankReceivedTemp> listBankReceivedTemp) {
        this.listBankReceivedTemp = listBankReceivedTemp;
    }

    public List<BankReceivedDetailTemp> getListBankReceivedDetailTemp() {
        return listBankReceivedDetailTemp;
    }

    public void setListBankReceivedDetailTemp(List<BankReceivedDetailTemp> listBankReceivedDetailTemp) {
        this.listBankReceivedDetailTemp = listBankReceivedDetailTemp;
    }

    public String getListBankReceivedDetailJSON() {
        return listBankReceivedDetailJSON;
    }

    public void setListBankReceivedDetailJSON(String listBankReceivedDetailJSON) {
        this.listBankReceivedDetailJSON = listBankReceivedDetailJSON;
    }

    public String getBankReceivedSearchCode() {
        return bankReceivedSearchCode;
    }

    public void setBankReceivedSearchCode(String bankReceivedSearchCode) {
        this.bankReceivedSearchCode = bankReceivedSearchCode;
    }

    public String getBankReceivedSearchReceivedFrom() {
        return bankReceivedSearchReceivedFrom;
    }

    public void setBankReceivedSearchReceivedFrom(String bankReceivedSearchReceivedFrom) {
        this.bankReceivedSearchReceivedFrom = bankReceivedSearchReceivedFrom;
    }

    public Date getBankReceivedSearchFirstDate() {
        return bankReceivedSearchFirstDate;
    }

    public void setBankReceivedSearchFirstDate(Date bankReceivedSearchFirstDate) {
        this.bankReceivedSearchFirstDate = bankReceivedSearchFirstDate;
    }

    public Date getBankReceivedSearchLastDate() {
        return bankReceivedSearchLastDate;
    }

    public void setBankReceivedSearchLastDate(Date bankReceivedSearchLastDate) {
        this.bankReceivedSearchLastDate = bankReceivedSearchLastDate;
    }

    public String getBankReceivedDepositUpdateSearchCode() {
        return bankReceivedDepositUpdateSearchCode;
    }

    public void setBankReceivedDepositUpdateSearchCode(String bankReceivedDepositUpdateSearchCode) {
        this.bankReceivedDepositUpdateSearchCode = bankReceivedDepositUpdateSearchCode;
    }

    public String getBankReceivedDepositUpdateSearchReceivedFrom() {
        return bankReceivedDepositUpdateSearchReceivedFrom;
    }

    public void setBankReceivedDepositUpdateSearchReceivedFrom(String bankReceivedDepositUpdateSearchReceivedFrom) {
        this.bankReceivedDepositUpdateSearchReceivedFrom = bankReceivedDepositUpdateSearchReceivedFrom;
    }

    public Date getBankReceivedDepositUpdateSearchFirstDate() {
        return bankReceivedDepositUpdateSearchFirstDate;
    }

    public void setBankReceivedDepositUpdateSearchFirstDate(Date bankReceivedDepositUpdateSearchFirstDate) {
        this.bankReceivedDepositUpdateSearchFirstDate = bankReceivedDepositUpdateSearchFirstDate;
    }

    public Date getBankReceivedDepositUpdateSearchLastDate() {
        return bankReceivedDepositUpdateSearchLastDate;
    }

    public void setBankReceivedDepositUpdateSearchLastDate(Date bankReceivedDepositUpdateSearchLastDate) {
        this.bankReceivedDepositUpdateSearchLastDate = bankReceivedDepositUpdateSearchLastDate;
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

    public String getBankReceivedBankAccountSearchCode() {
        return bankReceivedBankAccountSearchCode;
    }

    public void setBankReceivedBankAccountSearchCode(String bankReceivedBankAccountSearchCode) {
        this.bankReceivedBankAccountSearchCode = bankReceivedBankAccountSearchCode;
    }

    public String getBankReceivedBankAccountSearchName() {
        return bankReceivedBankAccountSearchName;
    }

    public void setBankReceivedBankAccountSearchName(String bankReceivedBankAccountSearchName) {
        this.bankReceivedBankAccountSearchName = bankReceivedBankAccountSearchName;
    }

    public BigDecimal getBankReceivedSearchFirstTotalAmount() {
        return bankReceivedSearchFirstTotalAmount;
    }

    public void setBankReceivedSearchFirstTotalAmount(BigDecimal bankReceivedSearchFirstTotalAmount) {
        this.bankReceivedSearchFirstTotalAmount = bankReceivedSearchFirstTotalAmount;
    }

    public BigDecimal getBankReceivedSearchLastTotalAmount() {
        return bankReceivedSearchLastTotalAmount;
    }

    public void setBankReceivedSearchLastTotalAmount(BigDecimal bankReceivedSearchLastTotalAmount) {
        this.bankReceivedSearchLastTotalAmount = bankReceivedSearchLastTotalAmount;
    }

    public String getBankReceivedSearchRemark() {
        return bankReceivedSearchRemark;
    }

    public void setBankReceivedSearchRemark(String bankReceivedSearchRemark) {
        this.bankReceivedSearchRemark = bankReceivedSearchRemark;
    }

    public List<BankReceivedDepositTemp> getListBankReceivedDepositTemp() {
        return listBankReceivedDepositTemp;
    }

    public void setListBankReceivedDepositTemp(List<BankReceivedDepositTemp> listBankReceivedDepositTemp) {
        this.listBankReceivedDepositTemp = listBankReceivedDepositTemp;
    }

    public BankReceivedDeposit getBankReceivedDepositUpdate() {
        return bankReceivedDepositUpdate;
    }

    public void setBankReceivedDepositUpdate(BankReceivedDeposit bankReceivedDepositUpdate) {
        this.bankReceivedDepositUpdate = bankReceivedDepositUpdate;
    }

    

    public BankReceivedDepositTemp getBankReceivedDepositTemp() {
        return bankReceivedDepositTemp;
    }

    public void setBankReceivedDepositTemp(BankReceivedDepositTemp bankReceivedDepositTemp) {
        this.bankReceivedDepositTemp = bankReceivedDepositTemp;
    }

    

    public String getUserCodeTemp() {
        return userCodeTemp;
    }

    public void setUserCodeTemp(String userCodeTemp) {
        this.userCodeTemp = userCodeTemp;
    }

    public BankReceived getBankReceivedAccSpv() {
        return bankReceivedAccSpv;
    }

    public void setBankReceivedAccSpv(BankReceived bankReceivedAccSpv) {
        this.bankReceivedAccSpv = bankReceivedAccSpv;
    }

    public BankReceivedTemp getBankReceivedAccSpvTemp() {
        return bankReceivedAccSpvTemp;
    }

    public void setBankReceivedAccSpvTemp(BankReceivedTemp bankReceivedAccSpvTemp) {
        this.bankReceivedAccSpvTemp = bankReceivedAccSpvTemp;
    }

    public String getBankReceivedAccSpvSearchCode() {
        return bankReceivedAccSpvSearchCode;
    }

    public void setBankReceivedAccSpvSearchCode(String bankReceivedAccSpvSearchCode) {
        this.bankReceivedAccSpvSearchCode = bankReceivedAccSpvSearchCode;
    }

    public String getBankReceivedAccSpvSearchReceivedFrom() {
        return bankReceivedAccSpvSearchReceivedFrom;
    }

    public void setBankReceivedAccSpvSearchReceivedFrom(String bankReceivedAccSpvSearchReceivedFrom) {
        this.bankReceivedAccSpvSearchReceivedFrom = bankReceivedAccSpvSearchReceivedFrom;
    }

    public String getBankReceivedAccSpvBankAccountSearchCode() {
        return bankReceivedAccSpvBankAccountSearchCode;
    }

    public void setBankReceivedAccSpvBankAccountSearchCode(String bankReceivedAccSpvBankAccountSearchCode) {
        this.bankReceivedAccSpvBankAccountSearchCode = bankReceivedAccSpvBankAccountSearchCode;
    }

    public String getBankReceivedAccSpvBankAccountSearchName() {
        return bankReceivedAccSpvBankAccountSearchName;
    }

    public void setBankReceivedAccSpvBankAccountSearchName(String bankReceivedAccSpvBankAccountSearchName) {
        this.bankReceivedAccSpvBankAccountSearchName = bankReceivedAccSpvBankAccountSearchName;
    }

    public BigDecimal getBankReceivedAccSpvSearchFirstTotalAmount() {
        return bankReceivedAccSpvSearchFirstTotalAmount;
    }

    public void setBankReceivedAccSpvSearchFirstTotalAmount(BigDecimal bankReceivedAccSpvSearchFirstTotalAmount) {
        this.bankReceivedAccSpvSearchFirstTotalAmount = bankReceivedAccSpvSearchFirstTotalAmount;
    }

    public BigDecimal getBankReceivedAccSpvSearchLastTotalAmount() {
        return bankReceivedAccSpvSearchLastTotalAmount;
    }

    public void setBankReceivedAccSpvSearchLastTotalAmount(BigDecimal bankReceivedAccSpvSearchLastTotalAmount) {
        this.bankReceivedAccSpvSearchLastTotalAmount = bankReceivedAccSpvSearchLastTotalAmount;
    }

    public String getBankReceivedAccSpvSearchRemark() {
        return bankReceivedAccSpvSearchRemark;
    }

    public void setBankReceivedAccSpvSearchRemark(String bankReceivedAccSpvSearchRemark) {
        this.bankReceivedAccSpvSearchRemark = bankReceivedAccSpvSearchRemark;
    }

 

    public String getBankReceivedAccSpvSearchAccStatus() {
        return bankReceivedAccSpvSearchAccStatus;
    }

    public void setBankReceivedAccSpvSearchAccStatus(String bankReceivedAccSpvSearchAccStatus) {
        this.bankReceivedAccSpvSearchAccStatus = bankReceivedAccSpvSearchAccStatus;
    }

    public Date getBankReceivedAccSpvSearchFirstDate() {
        return bankReceivedAccSpvSearchFirstDate;
    }

    public void setBankReceivedAccSpvSearchFirstDate(Date bankReceivedAccSpvSearchFirstDate) {
        this.bankReceivedAccSpvSearchFirstDate = bankReceivedAccSpvSearchFirstDate;
    }

    public Date getBankReceivedAccSpvSearchLastDate() {
        return bankReceivedAccSpvSearchLastDate;
    }

    public void setBankReceivedAccSpvSearchLastDate(Date bankReceivedAccSpvSearchLastDate) {
        this.bankReceivedAccSpvSearchLastDate = bankReceivedAccSpvSearchLastDate;
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
