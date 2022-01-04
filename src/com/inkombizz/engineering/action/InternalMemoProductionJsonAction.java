
package com.inkombizz.engineering.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.bll.InternalMemoProductionBLL;
import com.inkombizz.engineering.model.InternalMemoProduction;
import com.inkombizz.engineering.model.InternalMemoProductionDetail;
import com.inkombizz.engineering.model.InternalMemoProductionDetailTemp;
import com.inkombizz.engineering.model.InternalMemoProductionTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class InternalMemoProductionJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private String actionAuthority="";
    private InternalMemoProduction internalMemoProduction;
    private InternalMemoProduction internalMemoProductionApproval;
    private InternalMemoProduction internalMemoProductionClosing;
    private InternalMemoProductionTemp internalMemoProductionTemp;
    private InternalMemoProductionTemp internalMemoProductionAccSpvTemp;
    private List<InternalMemoProduction> listInternalMemoProduction;
    private List<InternalMemoProductionDetail> listInternalMemoProductionDetail;
    private List<InternalMemoProductionTemp> listInternalMemoProductionTemp;
    private List<InternalMemoProductionTemp> listInternalMemoProductionApprovalTemp;
    private List<InternalMemoProductionTemp> listInternalMemoProductionClosingTemp;
    private List<InternalMemoProductionDetailTemp> listInternalMemoProductionDetailTemp;
    private List<InternalMemoProductionDetailTemp> listInternalMemoProductionApprovalDetailTemp;
    private List<InternalMemoProductionDetailTemp> listInternalMemoProductionClosingDetailTemp;
    
    private String listInternalMemoProductionDetailJSON;
    private String internalMemoProductionSearchCode="";
    private String internalMemoProductionSearchRefNo="";
    private String internalMemoProductionSearchRemark="";
    private String internalMemoProductionCustomerSearchCode="";
    private String internalMemoProductionCustomerSearchName="";
    private Date internalMemoProductionSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date internalMemoProductionSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String customerCode="";
    
    private String internalMemoProductionApprovalSearchCode="";
    private String internalMemoProductionApprovalSearchRefNo="";
    private String internalMemoProductionApprovalSearchRemark="";
    private String internalMemoProductionApprovalCustomerSearchCode="";
    private String internalMemoProductionApprovalCustomerSearchName="";
    private String internalMemoProductionApprovalStatus="PENDING";
    private Date internalMemoProductionApprovalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date internalMemoProductionApprovalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String internalMemoProductionClosingSearchCode="";
    private String internalMemoProductionClosingSearchRefNo="";
    private String internalMemoProductionClosingSearchRemark="";
    private String internalMemoProductionClosingCustomerSearchCode="";
    private String internalMemoProductionClosingCustomerSearchName="";
    private String internalMemoProductionClosingStatus="OPEN";
    private Date internalMemoProductionClosingSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date internalMemoProductionClosingSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("internal-memo-production-data")
    public String findData() {
        try {
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            ListPaging <InternalMemoProductionTemp> listPaging = internalMemoProductionBLL.findData(paging,internalMemoProductionSearchCode,internalMemoProductionCustomerSearchCode,internalMemoProductionCustomerSearchName, internalMemoProductionSearchRefNo, internalMemoProductionSearchRemark, internalMemoProductionSearchFirstDate,internalMemoProductionSearchLastDate);
            
            listInternalMemoProductionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-production-approval-data")
    public String findDataApproval() {
        try {
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            ListPaging <InternalMemoProductionTemp> listPaging = internalMemoProductionBLL.findDataApproval(paging,internalMemoProductionApprovalSearchCode,internalMemoProductionApprovalCustomerSearchCode, internalMemoProductionApprovalCustomerSearchName, internalMemoProductionApprovalSearchRefNo, 
                                                                                                            internalMemoProductionApprovalSearchRemark, internalMemoProductionApprovalStatus, internalMemoProductionApprovalSearchFirstDate,internalMemoProductionApprovalSearchLastDate);
            
            listInternalMemoProductionApprovalTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-production-closing-data")
    public String findDataClosing() {
        try {
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            ListPaging <InternalMemoProductionTemp> listPaging = internalMemoProductionBLL.findDataClosing(paging,internalMemoProductionClosingSearchCode,internalMemoProductionClosingCustomerSearchCode, internalMemoProductionClosingCustomerSearchName, internalMemoProductionClosingSearchRefNo, 
                                                                                                            internalMemoProductionClosingSearchRemark, internalMemoProductionClosingStatus, internalMemoProductionClosingSearchFirstDate,internalMemoProductionClosingSearchLastDate);
            
            listInternalMemoProductionClosingTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("internal-memo-production-detail-data")
    public String findDataDetail(){
        try {
            
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            List<InternalMemoProductionDetailTemp> list = internalMemoProductionBLL.findDataDetail(internalMemoProduction.getCode(),this.customerCode);

            listInternalMemoProductionDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("internal-memo-production-approval-detail-data")
    public String findDataDetailApproval(){
        try {
            
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            List<InternalMemoProductionDetailTemp> list = internalMemoProductionBLL.findDataDetail(internalMemoProduction.getCode(),this.customerCode);

            listInternalMemoProductionApprovalDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("internal-memo-production-closing-detail-data")
    public String findDataDetailClosing(){
        try {
            
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            List<InternalMemoProductionDetailTemp> list = internalMemoProductionBLL.findDataDetail(internalMemoProduction.getCode(),this.customerCode);

            listInternalMemoProductionClosingDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("internal-memo-production-save")
    public String save(){
        String _Messg = "";
        try {
                        
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            Gson gson = new Gson();
            this.listInternalMemoProductionDetail = gson.fromJson(this.listInternalMemoProductionDetailJSON, new TypeToken<List<InternalMemoProductionDetail>>(){}.getType());

            internalMemoProduction.setTransactionDate(DateUtils.newDate());
            
            if(internalMemoProductionBLL.isExist(this.internalMemoProduction.getCode())){
                _Messg="UPDATED ";

                internalMemoProductionBLL.update(internalMemoProduction, listInternalMemoProductionDetail);
                
            }else{
                
                 _Messg = "SAVED ";
                 internalMemoProductionBLL.save(internalMemoProduction, listInternalMemoProductionDetail);
                 
            }

            this.message = _Messg + " DATA SUCCESS.<br/>IMP No : " + this.internalMemoProduction.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }


    @Action("internal-memo-production-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            internalMemoProductionBLL.delete(this.internalMemoProduction.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>IMM No : " + this.internalMemoProduction.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-production-approval-save")
    public String saveStatus(){
        String _Messg = "";
        try {
            
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
        
            internalMemoProductionBLL.approval(internalMemoProductionApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>IMP No : " + this.internalMemoProductionApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-production-closing-save")
    public String closingStatus(){
        String _Messg = "";
        try {
            
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
        
            internalMemoProductionClosing.setClosingStatus("CLOSED");
            internalMemoProductionBLL.closing(internalMemoProductionClosing);

            this.message = _Messg + " DATA SUCCESS.<br/>IMP No : " + this.internalMemoProductionClosing.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("internal-memo-production-authority")
    public String salesOrderAuthority(){
        try{
            
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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


    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }
    
    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public InternalMemoProduction getInternalMemoProduction() {
        return internalMemoProduction;
    }

    public void setInternalMemoProduction(InternalMemoProduction internalMemoProduction) {
        this.internalMemoProduction = internalMemoProduction;
    }

    public InternalMemoProductionTemp getInternalMemoProductionTemp() {
        return internalMemoProductionTemp;
    }

    public void setInternalMemoProductionTemp(InternalMemoProductionTemp internalMemoProductionTemp) {
        this.internalMemoProductionTemp = internalMemoProductionTemp;
    }

    public InternalMemoProductionTemp getInternalMemoProductionAccSpvTemp() {
        return internalMemoProductionAccSpvTemp;
    }

    public void setInternalMemoProductionAccSpvTemp(InternalMemoProductionTemp internalMemoProductionAccSpvTemp) {
        this.internalMemoProductionAccSpvTemp = internalMemoProductionAccSpvTemp;
    }

    public List<InternalMemoProduction> getListInternalMemoProduction() {
        return listInternalMemoProduction;
    }

    public void setListInternalMemoProduction(List<InternalMemoProduction> listInternalMemoProduction) {
        this.listInternalMemoProduction = listInternalMemoProduction;
    }

    public List<InternalMemoProductionDetail> getListInternalMemoProductionDetail() {
        return listInternalMemoProductionDetail;
    }

    public void setListInternalMemoProductionDetail(List<InternalMemoProductionDetail> listInternalMemoProductionDetail) {
        this.listInternalMemoProductionDetail = listInternalMemoProductionDetail;
    }

    public List<InternalMemoProductionTemp> getListInternalMemoProductionTemp() {
        return listInternalMemoProductionTemp;
    }

    public void setListInternalMemoProductionTemp(List<InternalMemoProductionTemp> listInternalMemoProductionTemp) {
        this.listInternalMemoProductionTemp = listInternalMemoProductionTemp;
    }

    public List<InternalMemoProductionDetailTemp> getListInternalMemoProductionDetailTemp() {
        return listInternalMemoProductionDetailTemp;
    }

    public void setListInternalMemoProductionDetailTemp(List<InternalMemoProductionDetailTemp> listInternalMemoProductionDetailTemp) {
        this.listInternalMemoProductionDetailTemp = listInternalMemoProductionDetailTemp;
    }

    public String getListInternalMemoProductionDetailJSON() {
        return listInternalMemoProductionDetailJSON;
    }

    public void setListInternalMemoProductionDetailJSON(String listInternalMemoProductionDetailJSON) {
        this.listInternalMemoProductionDetailJSON = listInternalMemoProductionDetailJSON;
    }

    public String getInternalMemoProductionSearchCode() {
        return internalMemoProductionSearchCode;
    }

    public void setInternalMemoProductionSearchCode(String internalMemoProductionSearchCode) {
        this.internalMemoProductionSearchCode = internalMemoProductionSearchCode;
    }

    public String getInternalMemoProductionSearchRefNo() {
        return internalMemoProductionSearchRefNo;
    }

    public void setInternalMemoProductionSearchRefNo(String internalMemoProductionSearchRefNo) {
        this.internalMemoProductionSearchRefNo = internalMemoProductionSearchRefNo;
    }

    public String getInternalMemoProductionSearchRemark() {
        return internalMemoProductionSearchRemark;
    }

    public void setInternalMemoProductionSearchRemark(String internalMemoProductionSearchRemark) {
        this.internalMemoProductionSearchRemark = internalMemoProductionSearchRemark;
    }

    public String getInternalMemoProductionCustomerSearchCode() {
        return internalMemoProductionCustomerSearchCode;
    }

    public void setInternalMemoProductionCustomerSearchCode(String internalMemoProductionCustomerSearchCode) {
        this.internalMemoProductionCustomerSearchCode = internalMemoProductionCustomerSearchCode;
    }

    public String getInternalMemoProductionCustomerSearchName() {
        return internalMemoProductionCustomerSearchName;
    }

    public void setInternalMemoProductionCustomerSearchName(String internalMemoProductionCustomerSearchName) {
        this.internalMemoProductionCustomerSearchName = internalMemoProductionCustomerSearchName;
    }

    public Date getInternalMemoProductionSearchFirstDate() {
        return internalMemoProductionSearchFirstDate;
    }

    public void setInternalMemoProductionSearchFirstDate(Date internalMemoProductionSearchFirstDate) {
        this.internalMemoProductionSearchFirstDate = internalMemoProductionSearchFirstDate;
    }

    public Date getInternalMemoProductionSearchLastDate() {
        return internalMemoProductionSearchLastDate;
    }

    public void setInternalMemoProductionSearchLastDate(Date internalMemoProductionSearchLastDate) {
        this.internalMemoProductionSearchLastDate = internalMemoProductionSearchLastDate;
    }

    public List<InternalMemoProductionTemp> getListInternalMemoProductionApprovalTemp() {
        return listInternalMemoProductionApprovalTemp;
    }

    public void setListInternalMemoProductionApprovalTemp(List<InternalMemoProductionTemp> listInternalMemoProductionApprovalTemp) {
        this.listInternalMemoProductionApprovalTemp = listInternalMemoProductionApprovalTemp;
    }

    public String getInternalMemoProductionApprovalSearchCode() {
        return internalMemoProductionApprovalSearchCode;
    }

    public void setInternalMemoProductionApprovalSearchCode(String internalMemoProductionApprovalSearchCode) {
        this.internalMemoProductionApprovalSearchCode = internalMemoProductionApprovalSearchCode;
    }

    public String getInternalMemoProductionApprovalSearchRefNo() {
        return internalMemoProductionApprovalSearchRefNo;
    }

    public void setInternalMemoProductionApprovalSearchRefNo(String internalMemoProductionApprovalSearchRefNo) {
        this.internalMemoProductionApprovalSearchRefNo = internalMemoProductionApprovalSearchRefNo;
    }

    public String getInternalMemoProductionApprovalSearchRemark() {
        return internalMemoProductionApprovalSearchRemark;
    }

    public void setInternalMemoProductionApprovalSearchRemark(String internalMemoProductionApprovalSearchRemark) {
        this.internalMemoProductionApprovalSearchRemark = internalMemoProductionApprovalSearchRemark;
    }

    public String getInternalMemoProductionApprovalCustomerSearchCode() {
        return internalMemoProductionApprovalCustomerSearchCode;
    }

    public void setInternalMemoProductionApprovalCustomerSearchCode(String internalMemoProductionApprovalCustomerSearchCode) {
        this.internalMemoProductionApprovalCustomerSearchCode = internalMemoProductionApprovalCustomerSearchCode;
    }

    public String getInternalMemoProductionApprovalCustomerSearchName() {
        return internalMemoProductionApprovalCustomerSearchName;
    }

    public void setInternalMemoProductionApprovalCustomerSearchName(String internalMemoProductionApprovalCustomerSearchName) {
        this.internalMemoProductionApprovalCustomerSearchName = internalMemoProductionApprovalCustomerSearchName;
    }

    public String getInternalMemoProductionApprovalStatus() {
        return internalMemoProductionApprovalStatus;
    }

    public void setInternalMemoProductionApprovalStatus(String internalMemoProductionApprovalStatus) {
        this.internalMemoProductionApprovalStatus = internalMemoProductionApprovalStatus;
    }

    public Date getInternalMemoProductionApprovalSearchFirstDate() {
        return internalMemoProductionApprovalSearchFirstDate;
    }

    public void setInternalMemoProductionApprovalSearchFirstDate(Date internalMemoProductionApprovalSearchFirstDate) {
        this.internalMemoProductionApprovalSearchFirstDate = internalMemoProductionApprovalSearchFirstDate;
    }

    public Date getInternalMemoProductionApprovalSearchLastDate() {
        return internalMemoProductionApprovalSearchLastDate;
    }

    public void setInternalMemoProductionApprovalSearchLastDate(Date internalMemoProductionApprovalSearchLastDate) {
        this.internalMemoProductionApprovalSearchLastDate = internalMemoProductionApprovalSearchLastDate;
    }

    public List<InternalMemoProductionDetailTemp> getListInternalMemoProductionApprovalDetailTemp() {
        return listInternalMemoProductionApprovalDetailTemp;
    }

    public void setListInternalMemoProductionApprovalDetailTemp(List<InternalMemoProductionDetailTemp> listInternalMemoProductionApprovalDetailTemp) {
        this.listInternalMemoProductionApprovalDetailTemp = listInternalMemoProductionApprovalDetailTemp;
    }

    public InternalMemoProduction getInternalMemoProductionApproval() {
        return internalMemoProductionApproval;
    }

    public void setInternalMemoProductionApproval(InternalMemoProduction internalMemoProductionApproval) {
        this.internalMemoProductionApproval = internalMemoProductionApproval;
    }

    public List<InternalMemoProductionTemp> getListInternalMemoProductionClosingTemp() {
        return listInternalMemoProductionClosingTemp;
    }

    public void setListInternalMemoProductionClosingTemp(List<InternalMemoProductionTemp> listInternalMemoProductionClosingTemp) {
        this.listInternalMemoProductionClosingTemp = listInternalMemoProductionClosingTemp;
    }

    public String getInternalMemoProductionClosingSearchCode() {
        return internalMemoProductionClosingSearchCode;
    }

    public void setInternalMemoProductionClosingSearchCode(String internalMemoProductionClosingSearchCode) {
        this.internalMemoProductionClosingSearchCode = internalMemoProductionClosingSearchCode;
    }

    public String getInternalMemoProductionClosingSearchRefNo() {
        return internalMemoProductionClosingSearchRefNo;
    }

    public void setInternalMemoProductionClosingSearchRefNo(String internalMemoProductionClosingSearchRefNo) {
        this.internalMemoProductionClosingSearchRefNo = internalMemoProductionClosingSearchRefNo;
    }

    public String getInternalMemoProductionClosingSearchRemark() {
        return internalMemoProductionClosingSearchRemark;
    }

    public void setInternalMemoProductionClosingSearchRemark(String internalMemoProductionClosingSearchRemark) {
        this.internalMemoProductionClosingSearchRemark = internalMemoProductionClosingSearchRemark;
    }

    public String getInternalMemoProductionClosingCustomerSearchCode() {
        return internalMemoProductionClosingCustomerSearchCode;
    }

    public void setInternalMemoProductionClosingCustomerSearchCode(String internalMemoProductionClosingCustomerSearchCode) {
        this.internalMemoProductionClosingCustomerSearchCode = internalMemoProductionClosingCustomerSearchCode;
    }

    public String getInternalMemoProductionClosingCustomerSearchName() {
        return internalMemoProductionClosingCustomerSearchName;
    }

    public void setInternalMemoProductionClosingCustomerSearchName(String internalMemoProductionClosingCustomerSearchName) {
        this.internalMemoProductionClosingCustomerSearchName = internalMemoProductionClosingCustomerSearchName;
    }

    public String getInternalMemoProductionClosingStatus() {
        return internalMemoProductionClosingStatus;
    }

    public void setInternalMemoProductionClosingStatus(String internalMemoProductionClosingStatus) {
        this.internalMemoProductionClosingStatus = internalMemoProductionClosingStatus;
    }

    public Date getInternalMemoProductionClosingSearchFirstDate() {
        return internalMemoProductionClosingSearchFirstDate;
    }

    public void setInternalMemoProductionClosingSearchFirstDate(Date internalMemoProductionClosingSearchFirstDate) {
        this.internalMemoProductionClosingSearchFirstDate = internalMemoProductionClosingSearchFirstDate;
    }

    public Date getInternalMemoProductionClosingSearchLastDate() {
        return internalMemoProductionClosingSearchLastDate;
    }

    public void setInternalMemoProductionClosingSearchLastDate(Date internalMemoProductionClosingSearchLastDate) {
        this.internalMemoProductionClosingSearchLastDate = internalMemoProductionClosingSearchLastDate;
    }

    public List<InternalMemoProductionDetailTemp> getListInternalMemoProductionClosingDetailTemp() {
        return listInternalMemoProductionClosingDetailTemp;
    }

    public void setListInternalMemoProductionClosingDetailTemp(List<InternalMemoProductionDetailTemp> listInternalMemoProductionClosingDetailTemp) {
        this.listInternalMemoProductionClosingDetailTemp = listInternalMemoProductionClosingDetailTemp;
    }

    public InternalMemoProduction getInternalMemoProductionClosing() {
        return internalMemoProductionClosing;
    }

    public void setInternalMemoProductionClosing(InternalMemoProduction internalMemoProductionClosing) {
        this.internalMemoProductionClosing = internalMemoProductionClosing;
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
