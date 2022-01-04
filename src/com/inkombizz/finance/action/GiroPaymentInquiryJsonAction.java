/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentInquiryBLL;
//import com.inkombizz.finance.bll.GiroPaymentRejectBLL;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentInquiryTemp;
import com.inkombizz.finance.model.GiroPaymentTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class GiroPaymentInquiryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroPayment giroPayment;
    private GiroPayment giroPaymentInquiry;
    private GiroPaymentTemp giroPaymentTemp;
    private GiroPaymentTemp giroPaymentInquiryTemp;
    private List<GiroPaymentTemp> listGiroPaymentTemp;
    private List<GiroPaymentInquiryTemp> listGiroPaymentInquiryTemp;
    private String giroPaymentInquirySearchCode="";
    private String giroPaymentInquirySearchBankCode="";
    private String giroPaymentInquirySearchRemark="";
    private String giroPaymentInquirySearchGiroNo="";
    private String giroPaymentInquirySearchBankName="";
    private String giroPaymentInquirySearchRefNo="";
    private Date giroPaymentInquirySearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentInquirySearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentInquirySearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentInquirySearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority="";
    private String code="";
    private String giroPaymentInquirySearchGrpNo="";
    private String giroPaymentInquirySearchStatus ="Pending";
 
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }   
    
    @Action("giro-payment-inquiry-data")
    public String findData() {
        try {
            GiroPaymentInquiryBLL giroPaymentInquiryBLL = new GiroPaymentInquiryBLL(hbmSession);
            ListPaging <GiroPaymentInquiryTemp> listPaging = giroPaymentInquiryBLL.findData(paging,giroPaymentInquirySearchCode,
                    giroPaymentInquirySearchBankCode,giroPaymentInquirySearchRemark,giroPaymentInquirySearchGrpNo,
                    giroPaymentInquirySearchGiroNo,giroPaymentInquirySearchBankName,giroPaymentInquirySearchRefNo,
                    giroPaymentInquirySearchStatus,giroPaymentInquirySearchFirstDate, giroPaymentInquirySearchLastDate,
                    giroPaymentInquirySearchFirstDateDueDate,giroPaymentInquirySearchLastDateDueDate);
            
            listGiroPaymentInquiryTemp = listPaging.getList();    
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
   @Action("giro-payment-inquiry-save")
    public String save() {
        try {
            GiroPaymentInquiryBLL giroPaymentInquiryBLL = new GiroPaymentInquiryBLL(hbmSession);

            giroPaymentInquiryBLL.save(giroPaymentInquiry);
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.giroPaymentInquiry.getCode() ;
            return SUCCESS;
        }
        catch(Exception e) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + e.getMessage();
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

    public GiroPayment getGiroPaymentInquiry() {
        return giroPaymentInquiry;
    }

    public void setGiroPaymentInquiry(GiroPayment giroPaymentInquiry) {
        this.giroPaymentInquiry = giroPaymentInquiry;
    }

    public GiroPaymentTemp getGiroPaymentTemp() {
        return giroPaymentTemp;
    }

    public void setGiroPaymentTemp(GiroPaymentTemp giroPaymentTemp) {
        this.giroPaymentTemp = giroPaymentTemp;
    }

    public GiroPaymentTemp getGiroPaymentInquiryTemp() {
        return giroPaymentInquiryTemp;
    }

    public void setGiroPaymentInquiryTemp(GiroPaymentTemp giroPaymentInquiryTemp) {
        this.giroPaymentInquiryTemp = giroPaymentInquiryTemp;
    }

    public List<GiroPaymentTemp> getListGiroPaymentTemp() {
        return listGiroPaymentTemp;
    }

    public void setListGiroPaymentTemp(List<GiroPaymentTemp> listGiroPaymentTemp) {
        this.listGiroPaymentTemp = listGiroPaymentTemp;
    }

    public List<GiroPaymentInquiryTemp> getListGiroPaymentInquiryTemp() {
        return listGiroPaymentInquiryTemp;
    }

    public void setListGiroPaymentInquiryTemp(List<GiroPaymentInquiryTemp> listGiroPaymentInquiryTemp) {
        this.listGiroPaymentInquiryTemp = listGiroPaymentInquiryTemp;
    }

    public String getGiroPaymentInquirySearchCode() {
        return giroPaymentInquirySearchCode;
    }

    public void setGiroPaymentInquirySearchCode(String giroPaymentInquirySearchCode) {
        this.giroPaymentInquirySearchCode = giroPaymentInquirySearchCode;
    }

    public String getGiroPaymentInquirySearchBankCode() {
        return giroPaymentInquirySearchBankCode;
    }

    public void setGiroPaymentInquirySearchBankCode(String giroPaymentInquirySearchBankCode) {
        this.giroPaymentInquirySearchBankCode = giroPaymentInquirySearchBankCode;
    }

    public String getGiroPaymentInquirySearchRemark() {
        return giroPaymentInquirySearchRemark;
    }

    public void setGiroPaymentInquirySearchRemark(String giroPaymentInquirySearchRemark) {
        this.giroPaymentInquirySearchRemark = giroPaymentInquirySearchRemark;
    }

    public String getGiroPaymentInquirySearchGiroNo() {
        return giroPaymentInquirySearchGiroNo;
    }

    public void setGiroPaymentInquirySearchGiroNo(String giroPaymentInquirySearchGiroNo) {
        this.giroPaymentInquirySearchGiroNo = giroPaymentInquirySearchGiroNo;
    }

    public String getGiroPaymentInquirySearchBankName() {
        return giroPaymentInquirySearchBankName;
    }

    public void setGiroPaymentInquirySearchBankName(String giroPaymentInquirySearchBankName) {
        this.giroPaymentInquirySearchBankName = giroPaymentInquirySearchBankName;
    }

    public String getGiroPaymentInquirySearchRefNo() {
        return giroPaymentInquirySearchRefNo;
    }

    public void setGiroPaymentInquirySearchRefNo(String giroPaymentInquirySearchRefNo) {
        this.giroPaymentInquirySearchRefNo = giroPaymentInquirySearchRefNo;
    }

    public Date getGiroPaymentInquirySearchFirstDate() {
        return giroPaymentInquirySearchFirstDate;
    }

    public void setGiroPaymentInquirySearchFirstDate(Date giroPaymentInquirySearchFirstDate) {
        this.giroPaymentInquirySearchFirstDate = giroPaymentInquirySearchFirstDate;
    }

    public Date getGiroPaymentInquirySearchLastDate() {
        return giroPaymentInquirySearchLastDate;
    }

    public void setGiroPaymentInquirySearchLastDate(Date giroPaymentInquirySearchLastDate) {
        this.giroPaymentInquirySearchLastDate = giroPaymentInquirySearchLastDate;
    }

    public Date getGiroPaymentInquirySearchFirstDateDueDate() {
        return giroPaymentInquirySearchFirstDateDueDate;
    }

    public void setGiroPaymentInquirySearchFirstDateDueDate(Date giroPaymentInquirySearchFirstDateDueDate) {
        this.giroPaymentInquirySearchFirstDateDueDate = giroPaymentInquirySearchFirstDateDueDate;
    }

    public Date getGiroPaymentInquirySearchLastDateDueDate() {
        return giroPaymentInquirySearchLastDateDueDate;
    }

    public void setGiroPaymentInquirySearchLastDateDueDate(Date giroPaymentInquirySearchLastDateDueDate) {
        this.giroPaymentInquirySearchLastDateDueDate = giroPaymentInquirySearchLastDateDueDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getGiroPaymentInquirySearchGrpNo() {
        return giroPaymentInquirySearchGrpNo;
    }

    public void setGiroPaymentInquirySearchGrpNo(String giroPaymentInquirySearchGrpNo) {
        this.giroPaymentInquirySearchGrpNo = giroPaymentInquirySearchGrpNo;
    }

    public String getGiroPaymentInquirySearchStatus() {
        return giroPaymentInquirySearchStatus;
    }

    public void setGiroPaymentInquirySearchStatus(String giroPaymentInquirySearchStatus) {
        this.giroPaymentInquirySearchStatus = giroPaymentInquirySearchStatus;
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
