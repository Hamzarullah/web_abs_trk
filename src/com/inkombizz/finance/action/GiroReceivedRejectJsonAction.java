
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedBLL;
import com.inkombizz.finance.bll.GiroReceivedRejectBLL;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroReceivedRejectTemp;
import com.inkombizz.finance.model.GiroPaymentTemp;
import com.inkombizz.finance.model.GiroReceived;
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
public class GiroReceivedRejectJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroPayment giroPayment;
    private GiroPayment giroReceivedRejected;
    private GiroPaymentTemp giroPaymentTemp;
    private GiroPaymentTemp giroReceivedRejectedTemp;
    private List<GiroPaymentTemp> listGiroPaymentTemp;
    private List<GiroReceivedRejectTemp> listGiroReceivedRejectTemp;
    private String giroReceivedRejectSearchCode="";
    private String giroReceivedRejectSearchBankCode="";
    private String giroReceivedRejectSearchRemark="";
    private String giroReceivedRejectSearchGiroNo="";
    private String giroReceivedRejectSearchBankName="";
    private String giroReceivedRejectSearchRefNo="";
    private Date giroReceivedRejectSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedRejectSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedRejectSearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date giroReceivedRejectSearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority="";
    private String code="";
    private String giroReceivedRejectSearchGrpNo="";
    private String giroReceivedRejectSearchStatus ="Pending";
    private GiroReceived giroReceivedReject;
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }   
    
    @Action("giro-received-reject-data")
    public String findData() {
        try {
            GiroReceivedRejectBLL giroReceivedRejectBLL = new GiroReceivedRejectBLL(hbmSession);
            ListPaging <GiroReceivedRejectTemp> listPaging = giroReceivedRejectBLL.findData(paging,giroReceivedRejectSearchCode,
                    giroReceivedRejectSearchBankCode,giroReceivedRejectSearchRemark,giroReceivedRejectSearchGrpNo,
                    giroReceivedRejectSearchGiroNo,giroReceivedRejectSearchBankName,giroReceivedRejectSearchRefNo,
                    giroReceivedRejectSearchStatus,giroReceivedRejectSearchFirstDate, giroReceivedRejectSearchLastDate,
                    giroReceivedRejectSearchFirstDateDueDate,giroReceivedRejectSearchLastDateDueDate
                    );
            
            listGiroReceivedRejectTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
   @Action("giro-received-reject-save")
    public String save() {
        try {
            GiroReceivedRejectBLL giroReceivedRejectBLL = new GiroReceivedRejectBLL(hbmSession);

            giroReceivedRejectBLL.save(giroReceivedReject);
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.giroReceivedReject.getCode() ;
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
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

    public GiroPayment getGiroReceivedRejected() {
        return giroReceivedRejected;
    }

    public void setGiroReceivedRejected(GiroPayment giroReceivedRejected) {
        this.giroReceivedRejected = giroReceivedRejected;
    }

    public GiroPaymentTemp getGiroPaymentTemp() {
        return giroPaymentTemp;
    }

    public void setGiroPaymentTemp(GiroPaymentTemp giroPaymentTemp) {
        this.giroPaymentTemp = giroPaymentTemp;
    }

    public GiroPaymentTemp getGiroReceivedRejectedTemp() {
        return giroReceivedRejectedTemp;
    }

    public void setGiroReceivedRejectedTemp(GiroPaymentTemp giroReceivedRejectedTemp) {
        this.giroReceivedRejectedTemp = giroReceivedRejectedTemp;
    }

    public List<GiroPaymentTemp> getListGiroPaymentTemp() {
        return listGiroPaymentTemp;
    }

    public void setListGiroPaymentTemp(List<GiroPaymentTemp> listGiroPaymentTemp) {
        this.listGiroPaymentTemp = listGiroPaymentTemp;
    }

    public String getGiroReceivedRejectSearchCode() {
        return giroReceivedRejectSearchCode;
    }

    public void setGiroReceivedRejectSearchCode(String giroReceivedRejectSearchCode) {
        this.giroReceivedRejectSearchCode = giroReceivedRejectSearchCode;
    }

    public Date getGiroReceivedRejectSearchFirstDate() {
        return giroReceivedRejectSearchFirstDate;
    }

    public void setGiroReceivedRejectSearchFirstDate(Date giroReceivedRejectSearchFirstDate) {
        this.giroReceivedRejectSearchFirstDate = giroReceivedRejectSearchFirstDate;
    }

    public Date getGiroReceivedRejectSearchLastDate() {
        return giroReceivedRejectSearchLastDate;
    }

    public void setGiroReceivedRejectSearchLastDate(Date giroReceivedRejectSearchLastDate) {
        this.giroReceivedRejectSearchLastDate = giroReceivedRejectSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<GiroReceivedRejectTemp> getListGiroReceivedRejectTemp() {
        return listGiroReceivedRejectTemp;
    }

    public void setListGiroReceivedRejectTemp(List<GiroReceivedRejectTemp> listGiroReceivedRejectTemp) {
        this.listGiroReceivedRejectTemp = listGiroReceivedRejectTemp;
    }

    public GiroReceived getGiroReceivedReject() {
        return giroReceivedReject;
    }

    public void setGiroReceivedReject(GiroReceived giroReceivedReject) {
        this.giroReceivedReject = giroReceivedReject;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getGiroReceivedRejectSearchGrpNo() {
        return giroReceivedRejectSearchGrpNo;
    }

    public void setGiroReceivedRejectSearchGrpNo(String giroReceivedRejectSearchGrpNo) {
        this.giroReceivedRejectSearchGrpNo = giroReceivedRejectSearchGrpNo;
    }
    
    
    public String getGiroReceivedRejectSearchStatus() {
        return giroReceivedRejectSearchStatus;
    }

    public void setGiroReceivedRejectSearchStatus(String giroReceivedRejectSearchStatus) {
        this.giroReceivedRejectSearchStatus = giroReceivedRejectSearchStatus;
    }

    public String getGiroReceivedRejectSearchBankCode() {
        return giroReceivedRejectSearchBankCode;
    }

    public void setGiroReceivedRejectSearchBankCode(String giroReceivedRejectSearchBankCode) {
        this.giroReceivedRejectSearchBankCode = giroReceivedRejectSearchBankCode;
    }

    public String getGiroReceivedRejectSearchRemark() {
        return giroReceivedRejectSearchRemark;
    }

    public void setGiroReceivedRejectSearchRemark(String giroReceivedRejectSearchRemark) {
        this.giroReceivedRejectSearchRemark = giroReceivedRejectSearchRemark;
    }

    public String getGiroReceivedRejectSearchGiroNo() {
        return giroReceivedRejectSearchGiroNo;
    }

    public void setGiroReceivedRejectSearchGiroNo(String giroReceivedRejectSearchGiroNo) {
        this.giroReceivedRejectSearchGiroNo = giroReceivedRejectSearchGiroNo;
    }

    public String getGiroReceivedRejectSearchBankName() {
        return giroReceivedRejectSearchBankName;
    }

    public void setGiroReceivedRejectSearchBankName(String giroReceivedRejectSearchBankName) {
        this.giroReceivedRejectSearchBankName = giroReceivedRejectSearchBankName;
    }

    public String getGiroReceivedRejectSearchRefNo() {
        return giroReceivedRejectSearchRefNo;
    }

    public void setGiroReceivedRejectSearchRefNo(String giroReceivedRejectSearchRefNo) {
        this.giroReceivedRejectSearchRefNo = giroReceivedRejectSearchRefNo;
    }

    public Date getGiroReceivedRejectSearchFirstDateDueDate() {
        return giroReceivedRejectSearchFirstDateDueDate;
    }

    public void setGiroReceivedRejectSearchFirstDateDueDate(Date giroReceivedRejectSearchFirstDateDueDate) {
        this.giroReceivedRejectSearchFirstDateDueDate = giroReceivedRejectSearchFirstDateDueDate;
    }

    public Date getGiroReceivedRejectSearchLastDateDueDate() {
        return giroReceivedRejectSearchLastDateDueDate;
    }

    public void setGiroReceivedRejectSearchLastDateDueDate(Date giroReceivedRejectSearchLastDateDueDate) {
        this.giroReceivedRejectSearchLastDateDueDate = giroReceivedRejectSearchLastDateDueDate;
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
