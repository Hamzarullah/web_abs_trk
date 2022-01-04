
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.ExchangeRateBLL;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.ExchangeRateTemp;
import com.inkombizz.master.model.ExchangeRate;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;


@Result (type="json")
public class ExchangeRateJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ExchangeRate exchangerateTax;
    private ExchangeRateTemp exchangeRateTaxTemp;
    private List <ExchangeRate> listExchangeRate;
    private List <ExchangeRateTemp> listExchangeRateToConfirm;
    private String listExchangeRateToConfirmJSon;
    private Currency currency;
    private Date transactionDateFrom;
    private Date transactionDateTo;
    private String currCode="";
    private Date exchangeDate;
    
    
    
    @Override
    public String execute() {
        try {
            return populateListExchangeRate();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    
    @Action("exchange-rate-confirm-data")
    public String populateListExchangeRate(){
        try{
            ExchangeRateBLL exchangeRateBLL = new ExchangeRateBLL(hbmSession);
            listExchangeRateToConfirm = exchangeRateBLL.listExchangeRateToConfirm(this.currency.getCode(),getTransactionDateFrom(),getTransactionDateTo());   
            
            return SUCCESS;
        }
        catch(Exception ex){
             ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("exchange-rate-by-date")
    public String populateListExchangeRateByDate(){
        try{
            ExchangeRateBLL exchangeRateBLL = new ExchangeRateBLL(hbmSession);
            listExchangeRate = exchangeRateBLL.getExchange(this.exchangerateTax);   
            
            return SUCCESS;
        }
        catch(Exception ex){
             ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("exchange-rate-save-update")
    public String saveUpdateData(){
        try{
            ExchangeRateBLL exchangeRateBLL = new ExchangeRateBLL(hbmSession);
            Gson gson=new Gson();
            gson =  new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
            
            this.listExchangeRate=gson.fromJson(this.listExchangeRateToConfirmJSon, new TypeToken<List<ExchangeRate>>(){}.getType());
            exchangeRateBLL.save_update(this.listExchangeRate,exchangeRateBLL.MODULECODE);
            
            this.message = "SAVE DATA SUCCESS. \n";
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    
    @Action("exchange-rate-by-date-query")
    public String populateListExchangeRateBiByDateQuery(){
        try{
            ExchangeRateBLL exchangeRateTaxBLL = new ExchangeRateBLL(hbmSession);
            this.exchangeRateTaxTemp = exchangeRateTaxBLL.getExchangeByDate(currCode,exchangeDate);   
            
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

    public List<ExchangeRate> getListExchangeRate() {
        return listExchangeRate;
    }

    public void setListExchangeRate(List<ExchangeRate> listExchangeRate) {
        this.listExchangeRate = listExchangeRate;
    }

    public List<ExchangeRateTemp> getListExchangeRateToConfirm() {
        return listExchangeRateToConfirm;
    }

    public void setListExchangeRateToConfirm(List<ExchangeRateTemp> listExchangeRateToConfirm) {
        this.listExchangeRateToConfirm = listExchangeRateToConfirm;
    }

    public String getListExchangeRateToConfirmJSon() {
        return listExchangeRateToConfirmJSon;
    }

    public void setListExchangeRateToConfirmJSon(String listExchangeRateToConfirmJSon) {
        this.listExchangeRateToConfirmJSon = listExchangeRateToConfirmJSon;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Date getTransactionDateFrom() {
        return transactionDateFrom;
    }

    public void setTransactionDateFrom(Date transactionDateFrom) {
        this.transactionDateFrom = transactionDateFrom;
    }

    public Date getTransactionDateTo() {
        return transactionDateTo;
    }

    public void setTransactionDateTo(Date transactionDateTo) {
        this.transactionDateTo = transactionDateTo;
    }

    public ExchangeRate getExchangeRate() {
        return exchangerateTax;
    }

    public void setExchangeRate(ExchangeRate exchangerateTax) {
        this.exchangerateTax = exchangerateTax;
    }

    public ExchangeRateTemp getExchangeRateTemp() {
        return exchangeRateTaxTemp;
    }

    public void setExchangeRateTemp(ExchangeRateTemp exchangeRateTaxTemp) {
        this.exchangeRateTaxTemp = exchangeRateTaxTemp;
    }

    public String getCurrCode() {
        return currCode;
    }

    public void setCurrCode(String currCode) {
        this.currCode = currCode;
    }

    public Date getExchangeDate() {
        return exchangeDate;
    }

    public void setExchangeDate(Date exchangeDate) {
        this.exchangeDate = exchangeDate;
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

    
    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">\
    
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