
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.AdditionalFeeBLL;
import com.inkombizz.master.model.AdditionalFee;
import com.inkombizz.master.model.AdditionalFeeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class AdditionalFeeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private AdditionalFee additionalFee;
    private AdditionalFeeTemp additionalFeeTemp;
    private List <AdditionalFeeTemp> listAdditionalFeeTemp;
    private String additionalFeeSearchCode = "";
    private String additionalFeeSearchName = "";
    private String additionalFeeSearchActiveStatus="true";
    private String actionAuthority="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-data")
    public String findData() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            ListPaging <AdditionalFeeTemp> listPaging = additionalFeeBLL.findData(additionalFeeSearchCode,additionalFeeSearchName,additionalFeeSearchActiveStatus,paging);
            
            listAdditionalFeeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-data-purchase")
    public String findDataFeePurchase() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            ListPaging <AdditionalFeeTemp> listPaging = additionalFeeBLL.findDataFeePurchase(additionalFeeSearchCode,additionalFeeSearchName,additionalFeeSearchActiveStatus,paging);
            
            listAdditionalFeeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-data-sales")
    public String findDataFeeSales() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            ListPaging <AdditionalFeeTemp> listPaging = additionalFeeBLL.findDataFeeSales(additionalFeeSearchCode,additionalFeeSearchName,additionalFeeSearchActiveStatus,paging);
            
            listAdditionalFeeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-get-data")
    public String findData1() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            this.additionalFeeTemp = additionalFeeBLL.findData(this.additionalFee.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-get")
    public String findData2() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            this.additionalFeeTemp = additionalFeeBLL.findData(this.additionalFee.getCode(),this.additionalFee.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("additional-fee-get-sales")
    public String findDataSales() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            this.additionalFeeTemp = additionalFeeBLL.findData(this.additionalFee.getCode(),this.additionalFee.isActiveStatus(),this.additionalFee.isSalesStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-authority")
    public String additionalFeeAuthority(){
        try{
            
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(additionalFeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(additionalFeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(additionalFeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("additional-fee-save")
    public String save() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            
//            additionalFee.setInActiveDate(commonFunction.setDateTime(additionalFeeTemp.getInActiveDateTemp()));
//            additionalFee.setCreatedDate(commonFunction.setDateTime(additionalFeeTemp.getCreatedDateTemp()));
            
            if(additionalFeeBLL.isExist(this.additionalFee.getCode())){
                this.errorMessage = "CODE "+this.additionalFee.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                additionalFeeBLL.save(this.additionalFee);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.additionalFee.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-update")
    public String update() {
        try {
            AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            additionalFee.setInActiveDate(commonFunction.setDateTime(additionalFeeTemp.getInActiveDateTemp()));
            additionalFee.setCreatedDate(commonFunction.setDateTime(additionalFeeTemp.getCreatedDateTemp()));
            additionalFeeBLL.update(this.additionalFee);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.additionalFee.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("additional-fee-delete")
    public String delete() {
        try {
           AdditionalFeeBLL additionalFeeBLL = new AdditionalFeeBLL(hbmSession);
            additionalFeeBLL.delete(this.additionalFee.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.additionalFee.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public AdditionalFee getAdditionalFee() {
        return additionalFee;
    }

    public void setAdditionalFee(AdditionalFee additionalFee) {
        this.additionalFee = additionalFee;
    }

    public AdditionalFeeTemp getAdditionalFeeTemp() {
        return additionalFeeTemp;
    }

    public void setAdditionalFeeTemp(AdditionalFeeTemp additionalFeeTemp) {
        this.additionalFeeTemp = additionalFeeTemp;
    }

    public List<AdditionalFeeTemp> getListAdditionalFeeTemp() {
        return listAdditionalFeeTemp;
    }

    public void setListAdditionalFeeTemp(List<AdditionalFeeTemp> listAdditionalFeeTemp) {
        this.listAdditionalFeeTemp = listAdditionalFeeTemp;
    }

    public String getAdditionalFeeSearchCode() {
        return additionalFeeSearchCode;
    }

    public void setAdditionalFeeSearchCode(String additionalFeeSearchCode) {
        this.additionalFeeSearchCode = additionalFeeSearchCode;
    }

    public String getAdditionalFeeSearchName() {
        return additionalFeeSearchName;
    }

    public void setAdditionalFeeSearchName(String additionalFeeSearchName) {
        this.additionalFeeSearchName = additionalFeeSearchName;
    }

    public String getAdditionalFeeSearchActiveStatus() {
        return additionalFeeSearchActiveStatus;
    }

    public void setAdditionalFeeSearchActiveStatus(String additionalFeeSearchActiveStatus) {
        this.additionalFeeSearchActiveStatus = additionalFeeSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
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
    
    Paging paging=new Paging();
    
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
