/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorInvoiceBLL;
import com.inkombizz.finance.model.VendorInvoice;
import com.inkombizz.finance.model.VendorInvoiceForexGainLoss;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNote;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNoteTemp;
import com.inkombizz.finance.model.VendorInvoiceItemDetail;
import com.inkombizz.finance.model.VendorInvoiceItemDetailTemp;
import com.inkombizz.finance.model.VendorInvoiceTemp;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPayment;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPaymentTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author Sukha
 */
@Result(type="json")
public class VendorInvoiceJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorInvoice vendorInvoice;
    private VendorInvoiceTemp vendorInvoiceTemp;
    private VendorInvoiceItemDetailTemp vendorInvoiceItemDetailTemp;
    private VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss;
    private List<VendorInvoiceTemp> listVendorInvoiceTemp;
    private List<VendorInvoiceGoodsReceivedNote> listVendorInvoiceGoodsReceivedNote;
    private List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPayment;
    private List<VendorInvoiceItemDetail> listVendorInvoiceItemDetail;
    private List<VendorInvoiceGoodsReceivedNoteTemp> listVendorInvoiceGoodsReceivedNoteTemp;
    private List<VendorInvoiceVendorDownPaymentTemp> listVendorInvoiceVendorDownPaymentTemp;
    private List<VendorInvoiceItemDetailTemp> listVendorInvoiceItemDetailTemp;
    private String listVendorInvoiceGoodsReceivedNoteJSON;
    private String listVendorInvoiceVendorDownPaymentJSON;
    private String listVendorInvoiceItemDetailJSON;
    private String listVendorInvoicePostingItemDetailJSON;
    
    /* SEARCH VARIABLE */
    private Date vendorInvoiceSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorInvoiceSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorInvoiceSearchFirstDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorInvoiceSearchLastDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private String vendorInvoiceSearchPurchaseOrderCode = "";
    private String vendorInvoiceSearchCode = "";
    private String vendorInvoiceSearchVendorCode = "";
    private String headerCode = "";
    private String vendorInvoiceVendorCode = "";
    private String vendorInvoiceItemCode = "";
    
    private String actionAuthority = "";
    private String usedModule = "";
    
    private String vatInSearchDocumentCode="";
    private String vatInSearchVendorCode="";
    private String vatInSearchVendorName="";
    private Date vatInSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date vatInSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorInvoiceSearchDueDate = new Date();
    private String vendorInvoiceOutstandingSearchCode = "";
    private String vendorInvoiceOutstandingSearchVendorCode = "";
    private String vendorInvoiceOutstandingSearchVendorName = "";
    private String vendorInvoiceSearchPaymentTerm = "";
    private String vendorInvoiceSearchVendorName = "";
    private String vendorInvoiceSearchBranchCode = "";
    private String vendorInvoiceSearchBranchName = "";
    private String vendorInvoiceSearchRefno = "";
  
    private String vendorInvoiceOutstandingSearchStatus = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-data")
    public String findData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            ListPaging<VendorInvoiceTemp> listPaging = vendorInvoiceBLL.findData(paging,vendorInvoiceSearchFirstDate,vendorInvoiceSearchLastDate,
            vendorInvoiceSearchFirstDueDate, vendorInvoiceSearchLastDueDate,        
            vendorInvoiceSearchCode,vendorInvoiceSearchPurchaseOrderCode, vendorInvoiceSearchPaymentTerm,
            vendorInvoiceSearchBranchCode,vendorInvoiceSearchBranchName,
            vendorInvoiceSearchVendorCode,vendorInvoiceSearchVendorName,vendorInvoiceSearchRefno);
            listVendorInvoiceTemp = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-search-data")
    public String findSearchData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            ListPaging<VendorInvoiceTemp> listPaging = vendorInvoiceBLL.findSearchData(paging, 
                    vendorInvoiceSearchFirstDate,vendorInvoiceSearchLastDate,
                    vendorInvoiceSearchCode);
            
            listVendorInvoiceTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-grn-data")
    public String findGRNData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            listVendorInvoiceGoodsReceivedNoteTemp = vendorInvoiceBLL.findGRNData(headerCode);
       
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-dp-data")
    public String findDPData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            listVendorInvoiceVendorDownPaymentTemp = vendorInvoiceBLL.findDPData(headerCode);
       
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-item-detail-data")
    public String findItemDetailData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            listVendorInvoiceItemDetailTemp = vendorInvoiceBLL.findItemData(headerCode);
       
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-item-detail-search-data")
    public String findItemDetailSearchData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            listVendorInvoiceItemDetailTemp = vendorInvoiceBLL.findItemDetailSearchData(this.vendorInvoiceItemDetailTemp);
       
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-find-one-data")
    public String findOneData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            vendorInvoice = vendorInvoiceBLL.get(this.vendorInvoice.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-authority")
    public String vendorInvoiceAuthority(){
        try{
            
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorInvoiceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE SAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorInvoiceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE UPDATE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorInvoiceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE DELETE AUTHORITY";
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
    
    @Action("vendor-invoice-save")
    public String save() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
           
            Gson gson = new Gson();
            this.listVendorInvoiceGoodsReceivedNote = gson.fromJson(this.listVendorInvoiceGoodsReceivedNoteJSON, new TypeToken<List<VendorInvoiceGoodsReceivedNote>>(){}.getType());           
            this.listVendorInvoiceVendorDownPayment = gson.fromJson(this.listVendorInvoiceVendorDownPaymentJSON, new TypeToken<List<VendorInvoiceVendorDownPayment>>(){}.getType());           
            this.listVendorInvoiceItemDetail = gson.fromJson(this.listVendorInvoiceItemDetailJSON, new TypeToken<List<VendorInvoiceItemDetail>>(){}.getType());
//            this.listVendorInvoicePostingItemDetail = gson.fromJson(this.listVendorInvoicePostingItemDetailJSON, new TypeToken<List<VendorInvoicePostingItemDetail>>(){}.getType());
   
            if(vendorInvoiceBLL.isExist(this.vendorInvoice.getCode())){
                this.errorMessage = "Code "+this.vendorInvoice.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                vendorInvoiceBLL.save(this.vendorInvoice, listVendorInvoiceGoodsReceivedNote, listVendorInvoiceVendorDownPayment,
                        listVendorInvoiceItemDetail, 
//                        listVendorInvoicePostingItemDetail, 
                        vendorInvoiceForexGainLoss);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.vendorInvoice.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-update")
    public String update() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            Gson gson = new Gson();
            this.listVendorInvoiceGoodsReceivedNote = gson.fromJson(this.listVendorInvoiceGoodsReceivedNoteJSON, new TypeToken<List<VendorInvoiceGoodsReceivedNote>>(){}.getType());           
            this.listVendorInvoiceVendorDownPayment = gson.fromJson(this.listVendorInvoiceVendorDownPaymentJSON, new TypeToken<List<VendorInvoiceVendorDownPayment>>(){}.getType());           
            this.listVendorInvoiceItemDetail = gson.fromJson(this.listVendorInvoiceItemDetailJSON, new TypeToken<List<VendorInvoiceItemDetail>>(){}.getType());           
   
            vendorInvoiceBLL.update(this.vendorInvoice, listVendorInvoiceGoodsReceivedNote,listVendorInvoiceVendorDownPayment,
                        listVendorInvoiceItemDetail,vendorInvoiceForexGainLoss);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.vendorInvoice.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-delete")
    public String delete() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
//            if(vendorInvoiceBLL.countValidateGRNByPOCash(this.vendorInvoice.getCode())>0){
//                this.message = "CAN NOT DELETE VIN GRN BY CASH. \n Code : " + this.vendorInvoice.getCode();
//                return SUCCESS;
//            }
            
            vendorInvoiceBLL.delete(this.vendorInvoice.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.vendorInvoice.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-item-detail-data-pr")
    public String findItemDetailDataPR() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            listVendorInvoiceItemDetailTemp = vendorInvoiceBLL.findItemDataPR(vendorInvoiceVendorCode, vendorInvoiceItemCode);
       
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-invoice-outstanding-data")
    public String findOutstanndingData() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            ListPaging<VendorInvoiceTemp> listPaging = vendorInvoiceBLL.findOutstandingData(paging,vendorInvoiceOutstandingSearchCode,vendorInvoiceOutstandingSearchVendorCode,
                    vendorInvoiceOutstandingSearchVendorName,vendorInvoiceOutstandingSearchStatus);
            
            listVendorInvoiceTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
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

    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public VendorInvoice getVendorInvoice() {
        return vendorInvoice;
    }

    public void setVendorInvoice(VendorInvoice vendorInvoice) {
        this.vendorInvoice = vendorInvoice;
    }

    public VendorInvoiceTemp getVendorInvoiceTemp() {
        return vendorInvoiceTemp;
    }

    public void setVendorInvoiceTemp(VendorInvoiceTemp vendorInvoiceTemp) {
        this.vendorInvoiceTemp = vendorInvoiceTemp;
    }

    public VendorInvoiceForexGainLoss getVendorInvoiceForexGainLoss() {
        return vendorInvoiceForexGainLoss;
    }

    public void setVendorInvoiceForexGainLoss(VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss) {
        this.vendorInvoiceForexGainLoss = vendorInvoiceForexGainLoss;
    }

    public List<VendorInvoiceTemp> getListVendorInvoiceTemp() {
        return listVendorInvoiceTemp;
    }

    public void setListVendorInvoiceTemp(List<VendorInvoiceTemp> listVendorInvoiceTemp) {
        this.listVendorInvoiceTemp = listVendorInvoiceTemp;
    }

    public List<VendorInvoiceGoodsReceivedNote> getListVendorInvoiceGoodsReceivedNote() {
        return listVendorInvoiceGoodsReceivedNote;
    }

    public void setListVendorInvoiceGoodsReceivedNote(List<VendorInvoiceGoodsReceivedNote> listVendorInvoiceGoodsReceivedNote) {
        this.listVendorInvoiceGoodsReceivedNote = listVendorInvoiceGoodsReceivedNote;
    }

    public List<VendorInvoiceVendorDownPayment> getListVendorInvoiceVendorDownPayment() {
        return listVendorInvoiceVendorDownPayment;
    }

    public void setListVendorInvoiceVendorDownPayment(List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPayment) {
        this.listVendorInvoiceVendorDownPayment = listVendorInvoiceVendorDownPayment;
    }

    public List<VendorInvoiceItemDetail> getListVendorInvoiceItemDetail() {
        return listVendorInvoiceItemDetail;
    }

    public void setListVendorInvoiceItemDetail(List<VendorInvoiceItemDetail> listVendorInvoiceItemDetail) {
        this.listVendorInvoiceItemDetail = listVendorInvoiceItemDetail;
    }

    public String getListVendorInvoiceGoodsReceivedNoteJSON() {
        return listVendorInvoiceGoodsReceivedNoteJSON;
    }

    public void setListVendorInvoiceGoodsReceivedNoteJSON(String listVendorInvoiceGoodsReceivedNoteJSON) {
        this.listVendorInvoiceGoodsReceivedNoteJSON = listVendorInvoiceGoodsReceivedNoteJSON;
    }

    public String getListVendorInvoiceVendorDownPaymentJSON() {
        return listVendorInvoiceVendorDownPaymentJSON;
    }

    public void setListVendorInvoiceVendorDownPaymentJSON(String listVendorInvoiceVendorDownPaymentJSON) {
        this.listVendorInvoiceVendorDownPaymentJSON = listVendorInvoiceVendorDownPaymentJSON;
    }

    public String getListVendorInvoiceItemDetailJSON() {
        return listVendorInvoiceItemDetailJSON;
    }

    public void setListVendorInvoiceItemDetailJSON(String listVendorInvoiceItemDetailJSON) {
        this.listVendorInvoiceItemDetailJSON = listVendorInvoiceItemDetailJSON;
    }

    public Date getVendorInvoiceSearchFirstDate() {
        return vendorInvoiceSearchFirstDate;
    }

    public void setVendorInvoiceSearchFirstDate(Date vendorInvoiceSearchFirstDate) {
        this.vendorInvoiceSearchFirstDate = vendorInvoiceSearchFirstDate;
    }

    public Date getVendorInvoiceSearchLastDate() {
        return vendorInvoiceSearchLastDate;
    }

    public void setVendorInvoiceSearchLastDate(Date vendorInvoiceSearchLastDate) {
        this.vendorInvoiceSearchLastDate = vendorInvoiceSearchLastDate;
    }

    public String getVendorInvoiceSearchCode() {
        return vendorInvoiceSearchCode;
    }

    public void setVendorInvoiceSearchCode(String vendorInvoiceSearchCode) {
        this.vendorInvoiceSearchCode = vendorInvoiceSearchCode;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<VendorInvoiceGoodsReceivedNoteTemp> getListVendorInvoiceGoodsReceivedNoteTemp() {
        return listVendorInvoiceGoodsReceivedNoteTemp;
    }

    public void setListVendorInvoiceGoodsReceivedNoteTemp(List<VendorInvoiceGoodsReceivedNoteTemp> listVendorInvoiceGoodsReceivedNoteTemp) {
        this.listVendorInvoiceGoodsReceivedNoteTemp = listVendorInvoiceGoodsReceivedNoteTemp;
    }

    public List<VendorInvoiceVendorDownPaymentTemp> getListVendorInvoiceVendorDownPaymentTemp() {
        return listVendorInvoiceVendorDownPaymentTemp;
    }

    public void setListVendorInvoiceVendorDownPaymentTemp(List<VendorInvoiceVendorDownPaymentTemp> listVendorInvoiceVendorDownPaymentTemp) {
        this.listVendorInvoiceVendorDownPaymentTemp = listVendorInvoiceVendorDownPaymentTemp;
    }

    public List<VendorInvoiceItemDetailTemp> getListVendorInvoiceItemDetailTemp() {
        return listVendorInvoiceItemDetailTemp;
    }

    public void setListVendorInvoiceItemDetailTemp(List<VendorInvoiceItemDetailTemp> listVendorInvoiceItemDetailTemp) {
        this.listVendorInvoiceItemDetailTemp = listVendorInvoiceItemDetailTemp;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getVendorInvoiceVendorCode() {
        return vendorInvoiceVendorCode;
    }

    public void setVendorInvoiceVendorCode(String vendorInvoiceVendorCode) {
        this.vendorInvoiceVendorCode = vendorInvoiceVendorCode;
    }

    public String getVendorInvoiceItemCode() {
        return vendorInvoiceItemCode;
    }

    public void setVendorInvoiceItemCode(String vendorInvoiceItemCode) {
        this.vendorInvoiceItemCode = vendorInvoiceItemCode;
    }

    public String getUsedModule() {
        return usedModule;
    }

    public void setUsedModule(String usedModule) {
        this.usedModule = usedModule;
    }
    
    public String getListVendorInvoicePostingItemDetailJSON() {
        return listVendorInvoicePostingItemDetailJSON;
    }

    public void setListVendorInvoicePostingItemDetailJSON(String listVendorInvoicePostingItemDetailJSON) {
        this.listVendorInvoicePostingItemDetailJSON = listVendorInvoicePostingItemDetailJSON;
    }

    public String getVatInSearchDocumentCode() {
        return vatInSearchDocumentCode;
    }

    public void setVatInSearchDocumentCode(String vatInSearchDocumentCode) {
        this.vatInSearchDocumentCode = vatInSearchDocumentCode;
    }

    public String getVatInSearchVendorCode() {
        return vatInSearchVendorCode;
    }

    public void setVatInSearchVendorCode(String vatInSearchVendorCode) {
        this.vatInSearchVendorCode = vatInSearchVendorCode;
    }

    public String getVatInSearchVendorName() {
        return vatInSearchVendorName;
    }

    public void setVatInSearchVendorName(String vatInSearchVendorName) {
        this.vatInSearchVendorName = vatInSearchVendorName;
    }

    public Date getVatInSearchFirstDate() {
        return vatInSearchFirstDate;
    }

    public void setVatInSearchFirstDate(Date vatInSearchFirstDate) {
        this.vatInSearchFirstDate = vatInSearchFirstDate;
    }

    public Date getVatInSearchLastDate() {
        return vatInSearchLastDate;
    }

    public void setVatInSearchLastDate(Date vatInSearchLastDate) {
        this.vatInSearchLastDate = vatInSearchLastDate;
    }

    public String getVendorInvoiceOutstandingSearchCode() {
        return vendorInvoiceOutstandingSearchCode;
    }

    public void setVendorInvoiceOutstandingSearchCode(String vendorInvoiceOutstandingSearchCode) {
        this.vendorInvoiceOutstandingSearchCode = vendorInvoiceOutstandingSearchCode;
    }

    public String getVendorInvoiceOutstandingSearchVendorCode() {
        return vendorInvoiceOutstandingSearchVendorCode;
    }

    public void setVendorInvoiceOutstandingSearchVendorCode(String vendorInvoiceOutstandingSearchVendorCode) {
        this.vendorInvoiceOutstandingSearchVendorCode = vendorInvoiceOutstandingSearchVendorCode;
    }

    public String getVendorInvoiceOutstandingSearchVendorName() {
        return vendorInvoiceOutstandingSearchVendorName;
    }

    public void setVendorInvoiceOutstandingSearchVendorName(String vendorInvoiceOutstandingSearchVendorName) {
        this.vendorInvoiceOutstandingSearchVendorName = vendorInvoiceOutstandingSearchVendorName;
    }

    public String getVendorInvoiceOutstandingSearchStatus() {
        return vendorInvoiceOutstandingSearchStatus;
    }

    public void setVendorInvoiceOutstandingSearchStatus(String vendorInvoiceOutstandingSearchStatus) {
        this.vendorInvoiceOutstandingSearchStatus = vendorInvoiceOutstandingSearchStatus;
    }

    public String getVendorInvoiceSearchVendorCode() {
        return vendorInvoiceSearchVendorCode;
    }

    public void setVendorInvoiceSearchVendorCode(String vendorInvoiceSearchVendorCode) {
        this.vendorInvoiceSearchVendorCode = vendorInvoiceSearchVendorCode;
    }

    public Date getVendorInvoiceSearchDueDate() {
        return vendorInvoiceSearchDueDate;
    }

    public void setVendorInvoiceSearchDueDate(Date vendorInvoiceSearchDueDate) {
        this.vendorInvoiceSearchDueDate = vendorInvoiceSearchDueDate;
    }

    public String getVendorInvoiceSearchPaymentTerm() {
        return vendorInvoiceSearchPaymentTerm;
    }

    public void setVendorInvoiceSearchPaymentTerm(String vendorInvoiceSearchPaymentTerm) {
        this.vendorInvoiceSearchPaymentTerm = vendorInvoiceSearchPaymentTerm;
    }

    public String getVendorInvoiceSearchVendorName() {
        return vendorInvoiceSearchVendorName;
    }

    public void setVendorInvoiceSearchVendorName(String vendorInvoiceSearchVendorName) {
        this.vendorInvoiceSearchVendorName = vendorInvoiceSearchVendorName;
    }

    public String getVendorInvoiceSearchBranchCode() {
        return vendorInvoiceSearchBranchCode;
    }

    public void setVendorInvoiceSearchBranchCode(String vendorInvoiceSearchBranchCode) {
        this.vendorInvoiceSearchBranchCode = vendorInvoiceSearchBranchCode;
    }

    public String getVendorInvoiceSearchBranchName() {
        return vendorInvoiceSearchBranchName;
    }

    public void setVendorInvoiceSearchBranchName(String vendorInvoiceSearchBranchName) {
        this.vendorInvoiceSearchBranchName = vendorInvoiceSearchBranchName;
    }

    public String getVendorInvoiceSearchPurchaseOrderCode() {
        return vendorInvoiceSearchPurchaseOrderCode;
    }

    public void setVendorInvoiceSearchPurchaseOrderCode(String vendorInvoiceSearchPurchaseOrderCode) {
        this.vendorInvoiceSearchPurchaseOrderCode = vendorInvoiceSearchPurchaseOrderCode;
    }

    public String getVendorInvoiceSearchRefno() {
        return vendorInvoiceSearchRefno;
    }

    public void setVendorInvoiceSearchRefno(String vendorInvoiceSearchRefno) {
        this.vendorInvoiceSearchRefno = vendorInvoiceSearchRefno;
    }

    public VendorInvoiceItemDetailTemp getVendorInvoiceItemDetailTemp() {
        return vendorInvoiceItemDetailTemp;
    }

    public void setVendorInvoiceItemDetailTemp(VendorInvoiceItemDetailTemp vendorInvoiceItemDetailTemp) {
        this.vendorInvoiceItemDetailTemp = vendorInvoiceItemDetailTemp;
    }

    public Date getVendorInvoiceSearchFirstDueDate() {
        return vendorInvoiceSearchFirstDueDate;
    }

    public void setVendorInvoiceSearchFirstDueDate(Date vendorInvoiceSearchFirstDueDate) {
        this.vendorInvoiceSearchFirstDueDate = vendorInvoiceSearchFirstDueDate;
    }

    public Date getVendorInvoiceSearchLastDueDate() {
        return vendorInvoiceSearchLastDueDate;
    }

    public void setVendorInvoiceSearchLastDueDate(Date vendorInvoiceSearchLastDueDate) {
        this.vendorInvoiceSearchLastDueDate = vendorInvoiceSearchLastDueDate;
    }
    
    
}
