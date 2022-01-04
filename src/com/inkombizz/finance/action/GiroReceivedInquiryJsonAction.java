/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedInquiryBLL;
import com.inkombizz.finance.bll.GiroReceivedInquiryBLL;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedInquiryTemp;
import com.inkombizz.finance.model.GiroReceivedTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author Rayis
 */
@Result (type = "json")
public class GiroReceivedInquiryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroReceived giroReceived;
    private GiroReceived giroReceivedInquiry;
    private GiroReceivedTemp giroReceivedTemp;
    private GiroReceivedTemp giroReceivedInquiryTemp;
    private List<GiroReceivedTemp> listGiroReceivedTemp;
    private List<GiroReceivedInquiryTemp> listGiroReceivedInquiryTemp;
    private String giroReceivedInquirySearchCode="";
    private String giroReceivedInquirySearchBankCode="";
    private String giroReceivedInquirySearchRemark="";
    private String giroReceivedInquirySearchGiroNo="";
    private String giroReceivedInquirySearchBankName="";
    private String giroReceivedInquirySearchRefNo="";
    private Date giroReceivedInquirySearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedInquirySearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedInquirySearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedInquirySearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority="";
    private String code="";
    private String giroReceivedInquirySearchGrpNo="";
    private String giroReceivedInquirySearchStatus ="Pending";
 
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }   
    
    @Action("giro-received-inquiry-data")
    public String findData() {
        try {
            GiroReceivedInquiryBLL giroReceivedInquiryBLL = new GiroReceivedInquiryBLL(hbmSession);
            ListPaging <GiroReceivedInquiryTemp> listPaging = giroReceivedInquiryBLL.findData(paging,giroReceivedInquirySearchCode,
                    giroReceivedInquirySearchBankCode,giroReceivedInquirySearchRemark,giroReceivedInquirySearchGrpNo,
                    giroReceivedInquirySearchGiroNo,giroReceivedInquirySearchBankName,giroReceivedInquirySearchRefNo,
                    giroReceivedInquirySearchStatus,giroReceivedInquirySearchFirstDate, giroReceivedInquirySearchLastDate,
                    giroReceivedInquirySearchFirstDateDueDate,giroReceivedInquirySearchLastDateDueDate);
            
            listGiroReceivedInquiryTemp = listPaging.getList();    
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
   @Action("giro-received-inquiry-save")
    public String save() {
        try {
            GiroReceivedInquiryBLL giroReceivedInquiryBLL = new GiroReceivedInquiryBLL(hbmSession);

            giroReceivedInquiryBLL.save(giroReceivedInquiry);
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.giroReceivedInquiry.getCode() ;
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

    public GiroReceived getGiroReceived() {
        return giroReceived;
    }

    public void setGiroReceived(GiroReceived giroReceived) {
        this.giroReceived = giroReceived;
    }

    public GiroReceived getGiroReceivedInquiry() {
        return giroReceivedInquiry;
    }

    public void setGiroReceivedInquiry(GiroReceived giroReceivedInquiry) {
        this.giroReceivedInquiry = giroReceivedInquiry;
    }

    public GiroReceivedTemp getGiroReceivedTemp() {
        return giroReceivedTemp;
    }

    public void setGiroReceivedTemp(GiroReceivedTemp giroReceivedTemp) {
        this.giroReceivedTemp = giroReceivedTemp;
    }

    public GiroReceivedTemp getGiroReceivedInquiryTemp() {
        return giroReceivedInquiryTemp;
    }

    public void setGiroReceivedInquiryTemp(GiroReceivedTemp giroReceivedInquiryTemp) {
        this.giroReceivedInquiryTemp = giroReceivedInquiryTemp;
    }

    public List<GiroReceivedTemp> getListGiroReceivedTemp() {
        return listGiroReceivedTemp;
    }

    public void setListGiroReceivedTemp(List<GiroReceivedTemp> listGiroReceivedTemp) {
        this.listGiroReceivedTemp = listGiroReceivedTemp;
    }

    public List<GiroReceivedInquiryTemp> getListGiroReceivedInquiryTemp() {
        return listGiroReceivedInquiryTemp;
    }

    public void setListGiroReceivedInquiryTemp(List<GiroReceivedInquiryTemp> listGiroReceivedInquiryTemp) {
        this.listGiroReceivedInquiryTemp = listGiroReceivedInquiryTemp;
    }

    public String getGiroReceivedInquirySearchCode() {
        return giroReceivedInquirySearchCode;
    }

    public void setGiroReceivedInquirySearchCode(String giroReceivedInquirySearchCode) {
        this.giroReceivedInquirySearchCode = giroReceivedInquirySearchCode;
    }

    public String getGiroReceivedInquirySearchBankCode() {
        return giroReceivedInquirySearchBankCode;
    }

    public void setGiroReceivedInquirySearchBankCode(String giroReceivedInquirySearchBankCode) {
        this.giroReceivedInquirySearchBankCode = giroReceivedInquirySearchBankCode;
    }

    public String getGiroReceivedInquirySearchRemark() {
        return giroReceivedInquirySearchRemark;
    }

    public void setGiroReceivedInquirySearchRemark(String giroReceivedInquirySearchRemark) {
        this.giroReceivedInquirySearchRemark = giroReceivedInquirySearchRemark;
    }

    public String getGiroReceivedInquirySearchGiroNo() {
        return giroReceivedInquirySearchGiroNo;
    }

    public void setGiroReceivedInquirySearchGiroNo(String giroReceivedInquirySearchGiroNo) {
        this.giroReceivedInquirySearchGiroNo = giroReceivedInquirySearchGiroNo;
    }

    public String getGiroReceivedInquirySearchBankName() {
        return giroReceivedInquirySearchBankName;
    }

    public void setGiroReceivedInquirySearchBankName(String giroReceivedInquirySearchBankName) {
        this.giroReceivedInquirySearchBankName = giroReceivedInquirySearchBankName;
    }

    public String getGiroReceivedInquirySearchRefNo() {
        return giroReceivedInquirySearchRefNo;
    }

    public void setGiroReceivedInquirySearchRefNo(String giroReceivedInquirySearchRefNo) {
        this.giroReceivedInquirySearchRefNo = giroReceivedInquirySearchRefNo;
    }

    public Date getGiroReceivedInquirySearchFirstDate() {
        return giroReceivedInquirySearchFirstDate;
    }

    public void setGiroReceivedInquirySearchFirstDate(Date giroReceivedInquirySearchFirstDate) {
        this.giroReceivedInquirySearchFirstDate = giroReceivedInquirySearchFirstDate;
    }

    public Date getGiroReceivedInquirySearchLastDate() {
        return giroReceivedInquirySearchLastDate;
    }

    public void setGiroReceivedInquirySearchLastDate(Date giroReceivedInquirySearchLastDate) {
        this.giroReceivedInquirySearchLastDate = giroReceivedInquirySearchLastDate;
    }

    public Date getGiroReceivedInquirySearchFirstDateDueDate() {
        return giroReceivedInquirySearchFirstDateDueDate;
    }

    public void setGiroReceivedInquirySearchFirstDateDueDate(Date giroReceivedInquirySearchFirstDateDueDate) {
        this.giroReceivedInquirySearchFirstDateDueDate = giroReceivedInquirySearchFirstDateDueDate;
    }

    public Date getGiroReceivedInquirySearchLastDateDueDate() {
        return giroReceivedInquirySearchLastDateDueDate;
    }

    public void setGiroReceivedInquirySearchLastDateDueDate(Date giroReceivedInquirySearchLastDateDueDate) {
        this.giroReceivedInquirySearchLastDateDueDate = giroReceivedInquirySearchLastDateDueDate;
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

    public String getGiroReceivedInquirySearchGrpNo() {
        return giroReceivedInquirySearchGrpNo;
    }

    public void setGiroReceivedInquirySearchGrpNo(String giroReceivedInquirySearchGrpNo) {
        this.giroReceivedInquirySearchGrpNo = giroReceivedInquirySearchGrpNo;
    }

    public String getGiroReceivedInquirySearchStatus() {
        return giroReceivedInquirySearchStatus;
    }

    public void setGiroReceivedInquirySearchStatus(String giroReceivedInquirySearchStatus) {
        this.giroReceivedInquirySearchStatus = giroReceivedInquirySearchStatus;
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
