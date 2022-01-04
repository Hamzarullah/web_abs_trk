
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentBLL;
import com.inkombizz.finance.bll.GiroPaymentRejectBLL;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentRejectTemp;
import com.inkombizz.finance.model.GiroPaymentTemp;
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
public class GiroPaymentRejectJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroPayment giroPayment;
    private GiroPayment giroPaymentRejected;
    private GiroPaymentTemp giroPaymentTemp;
    private GiroPaymentTemp giroPaymentRejectedTemp;
    private List<GiroPaymentTemp> listGiroPaymentTemp;
    private List<GiroPaymentRejectTemp> listGiroPaymentRejectTemp;
    private String giroPaymentRejectSearchCode="";
    private String giroPaymentRejectSearchBankCode="";
    private String giroPaymentRejectSearchRemark="";
    private String giroPaymentRejectSearchGiroNo="";
    private String giroPaymentRejectSearchBankName="";
    private String giroPaymentRejectSearchRefNo="";
    private Date giroPaymentRejectSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentRejectSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentRejectSearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroPaymentRejectSearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority="";
    private String code="";
    private String giroPaymentRejectSearchGrpNo="";
    private String giroPaymentRejectSearchStatus ="Pending";
    private GiroPaymentRejectTemp giroPaymentReject;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }   
    
    @Action("giro-payment-reject-data")
    public String findData() {
        try {
            GiroPaymentRejectBLL giroPaymentRejectBLL = new GiroPaymentRejectBLL(hbmSession);
            ListPaging <GiroPaymentRejectTemp> listPaging = giroPaymentRejectBLL.findData(paging,
                    giroPaymentRejectSearchCode,
                    giroPaymentRejectSearchBankCode,
                    giroPaymentRejectSearchRemark,
                    giroPaymentRejectSearchGrpNo,
                    giroPaymentRejectSearchGiroNo,
                    giroPaymentRejectSearchBankName,
                    giroPaymentRejectSearchRefNo,
                    giroPaymentRejectSearchStatus,
                    giroPaymentRejectSearchFirstDate,
                    giroPaymentRejectSearchLastDate,
                    giroPaymentRejectSearchFirstDateDueDate,
                    giroPaymentRejectSearchLastDateDueDate);
            
            listGiroPaymentRejectTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
   @Action("giro-payment-reject-save")
    public String save() {
        try {
            GiroPaymentRejectBLL giroPaymentRejectBLL = new GiroPaymentRejectBLL(hbmSession);

            giroPaymentRejectBLL.save(giroPaymentRejected);
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.giroPaymentRejected.getCode() ;
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

    public GiroPayment getGiroPaymentRejected() {
        return giroPaymentRejected;
    }

    public void setGiroPaymentRejected(GiroPayment giroPaymentRejected) {
        this.giroPaymentRejected = giroPaymentRejected;
    }

    public GiroPaymentTemp getGiroPaymentTemp() {
        return giroPaymentTemp;
    }

    public void setGiroPaymentTemp(GiroPaymentTemp giroPaymentTemp) {
        this.giroPaymentTemp = giroPaymentTemp;
    }

    public GiroPaymentTemp getGiroPaymentRejectedTemp() {
        return giroPaymentRejectedTemp;
    }

    public void setGiroPaymentRejectedTemp(GiroPaymentTemp giroPaymentRejectedTemp) {
        this.giroPaymentRejectedTemp = giroPaymentRejectedTemp;
    }

    public List<GiroPaymentTemp> getListGiroPaymentTemp() {
        return listGiroPaymentTemp;
    }

    public void setListGiroPaymentTemp(List<GiroPaymentTemp> listGiroPaymentTemp) {
        this.listGiroPaymentTemp = listGiroPaymentTemp;
    }

    public String getGiroPaymentRejectSearchCode() {
        return giroPaymentRejectSearchCode;
    }

    public void setGiroPaymentRejectSearchCode(String giroPaymentRejectSearchCode) {
        this.giroPaymentRejectSearchCode = giroPaymentRejectSearchCode;
    }

    public Date getGiroPaymentRejectSearchFirstDate() {
        return giroPaymentRejectSearchFirstDate;
    }

    public void setGiroPaymentRejectSearchFirstDate(Date giroPaymentRejectSearchFirstDate) {
        this.giroPaymentRejectSearchFirstDate = giroPaymentRejectSearchFirstDate;
    }

    public Date getGiroPaymentRejectSearchLastDate() {
        return giroPaymentRejectSearchLastDate;
    }

    public void setGiroPaymentRejectSearchLastDate(Date giroPaymentRejectSearchLastDate) {
        this.giroPaymentRejectSearchLastDate = giroPaymentRejectSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<GiroPaymentRejectTemp> getListGiroPaymentRejectTemp() {
        return listGiroPaymentRejectTemp;
    }

    public void setListGiroPaymentRejectTemp(List<GiroPaymentRejectTemp> listGiroPaymentRejectTemp) {
        this.listGiroPaymentRejectTemp = listGiroPaymentRejectTemp;
    }

    public GiroPaymentRejectTemp getGiroPaymentReject() {
        return giroPaymentReject;
    }

    public void setGiroPaymentReject(GiroPaymentRejectTemp giroPaymentReject) {
        this.giroPaymentReject = giroPaymentReject;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getGiroPaymentRejectSearchGrpNo() {
        return giroPaymentRejectSearchGrpNo;
    }

    public void setGiroPaymentRejectSearchGrpNo(String giroPaymentRejectSearchGrpNo) {
        this.giroPaymentRejectSearchGrpNo = giroPaymentRejectSearchGrpNo;
    }
    
    
    public String getGiroPaymentRejectSearchStatus() {
        return giroPaymentRejectSearchStatus;
    }

    public void setGiroPaymentRejectSearchStatus(String giroPaymentRejectSearchStatus) {
        this.giroPaymentRejectSearchStatus = giroPaymentRejectSearchStatus;
    }

    public String getGiroPaymentRejectSearchBankCode() {
        return giroPaymentRejectSearchBankCode;
    }

    public void setGiroPaymentRejectSearchBankCode(String giroPaymentRejectSearchBankCode) {
        this.giroPaymentRejectSearchBankCode = giroPaymentRejectSearchBankCode;
    }

    public String getGiroPaymentRejectSearchRemark() {
        return giroPaymentRejectSearchRemark;
    }

    public void setGiroPaymentRejectSearchRemark(String giroPaymentRejectSearchRemark) {
        this.giroPaymentRejectSearchRemark = giroPaymentRejectSearchRemark;
    }

    public String getGiroPaymentRejectSearchGiroNo() {
        return giroPaymentRejectSearchGiroNo;
    }

    public void setGiroPaymentRejectSearchGiroNo(String giroPaymentRejectSearchGiroNo) {
        this.giroPaymentRejectSearchGiroNo = giroPaymentRejectSearchGiroNo;
    }

    public String getGiroPaymentRejectSearchBankName() {
        return giroPaymentRejectSearchBankName;
    }

    public void setGiroPaymentRejectSearchBankName(String giroPaymentRejectSearchBankName) {
        this.giroPaymentRejectSearchBankName = giroPaymentRejectSearchBankName;
    }

    public String getGiroPaymentRejectSearchRefNo() {
        return giroPaymentRejectSearchRefNo;
    }

    public void setGiroPaymentRejectSearchRefNo(String giroPaymentRejectSearchRefNo) {
        this.giroPaymentRejectSearchRefNo = giroPaymentRejectSearchRefNo;
    }

    public Date getGiroPaymentRejectSearchFirstDateDueDate() {
        return giroPaymentRejectSearchFirstDateDueDate;
    }

    public void setGiroPaymentRejectSearchFirstDateDueDate(Date giroPaymentRejectSearchFirstDateDueDate) {
        this.giroPaymentRejectSearchFirstDateDueDate = giroPaymentRejectSearchFirstDateDueDate;
    }

    public Date getGiroPaymentRejectSearchLastDateDueDate() {
        return giroPaymentRejectSearchLastDateDueDate;
    }

    public void setGiroPaymentRejectSearchLastDateDueDate(Date giroPaymentRejectSearchLastDateDueDate) {
        this.giroPaymentRejectSearchLastDateDueDate = giroPaymentRejectSearchLastDateDueDate;
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
