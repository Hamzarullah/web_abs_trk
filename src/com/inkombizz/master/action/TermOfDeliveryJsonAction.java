
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

import com.inkombizz.master.bll.TermOfDeliveryBLL;
import com.inkombizz.master.model.TermOfDelivery;
import com.inkombizz.master.model.TermOfDeliveryTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class TermOfDeliveryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private TermOfDelivery termOfDelivery;
    private TermOfDeliveryTemp termOfDeliveryTemp;
    private List <TermOfDeliveryTemp> listTermOfDeliveryTemp;
    private String termOfDeliverySearchCode = "";
    private String termOfDeliverySearchName = "";
    private String termOfDeliverySearchActiveStatus="true";
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
    
    @Action("term-of-delivery-data")
    public String findData() {
        try {
            TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            ListPaging <TermOfDeliveryTemp> listPaging = termOfDeliveryBLL.findData(termOfDeliverySearchCode,termOfDeliverySearchName,termOfDeliverySearchActiveStatus,paging);
            
            listTermOfDeliveryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("term-of-delivery-get-data")
    public String findData1() {
        try {
            TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            this.termOfDeliveryTemp = termOfDeliveryBLL.findData(this.termOfDelivery.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("term-of-delivery-get")
    public String findData2() {
        try {
            TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            this.termOfDeliveryTemp = termOfDeliveryBLL.findData(this.termOfDelivery.getCode(),this.termOfDelivery.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("term-of-delivery-authority")
    public String termOfDeliveryAuthority(){
        try{
            
            TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(termOfDeliveryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(termOfDeliveryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(termOfDeliveryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("term-of-delivery-save")
    public String save() {
        try {
            TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            
          termOfDelivery.setInActiveDate(commonFunction.setDateTime(termOfDeliveryTemp.getInActiveDateTemp()));
         termOfDelivery.setCreatedDate(commonFunction.setDateTime(termOfDeliveryTemp.getCreatedDateTemp()));
            
            if(termOfDeliveryBLL.isExist(this.termOfDelivery.getCode())){
                this.errorMessage = "CODE "+this.termOfDelivery.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                termOfDeliveryBLL.save(this.termOfDelivery);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.termOfDelivery.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("term-of-delivery-update")
    public String update() {
        try {
            TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            termOfDelivery.setInActiveDate(commonFunction.setDateTime(termOfDeliveryTemp.getInActiveDateTemp()));
            termOfDelivery.setCreatedDate(commonFunction.setDateTime(termOfDeliveryTemp.getCreatedDateTemp()));
            termOfDeliveryBLL.update(this.termOfDelivery);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.termOfDelivery.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("term-of-delivery-delete")
    public String delete() {
        try {
           TermOfDeliveryBLL termOfDeliveryBLL = new TermOfDeliveryBLL(hbmSession);
            termOfDeliveryBLL.delete(this.termOfDelivery.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.termOfDelivery.getCode();
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

    public TermOfDelivery getTermOfDelivery() {
        return termOfDelivery;
    }

    public void setTermOfDelivery(TermOfDelivery termOfDelivery) {
        this.termOfDelivery = termOfDelivery;
    }

    public TermOfDeliveryTemp getTermOfDeliveryTemp() {
        return termOfDeliveryTemp;
    }

    public void setTermOfDeliveryTemp(TermOfDeliveryTemp termOfDeliveryTemp) {
        this.termOfDeliveryTemp = termOfDeliveryTemp;
    }

    public List<TermOfDeliveryTemp> getListTermOfDeliveryTemp() {
        return listTermOfDeliveryTemp;
    }

    public void setListTermOfDeliveryTemp(List<TermOfDeliveryTemp> listTermOfDeliveryTemp) {
        this.listTermOfDeliveryTemp = listTermOfDeliveryTemp;
    }

    public String getTermOfDeliverySearchCode() {
        return termOfDeliverySearchCode;
    }

    public void setTermOfDeliverySearchCode(String termOfDeliverySearchCode) {
        this.termOfDeliverySearchCode = termOfDeliverySearchCode;
    }

    public String getTermOfDeliverySearchName() {
        return termOfDeliverySearchName;
    }

    public void setTermOfDeliverySearchName(String termOfDeliverySearchName) {
        this.termOfDeliverySearchName = termOfDeliverySearchName;
    }

    public String getTermOfDeliverySearchActiveStatus() {
        return termOfDeliverySearchActiveStatus;
    }

    public void setTermOfDeliverySearchActiveStatus(String termOfDeliverySearchActiveStatus) {
        this.termOfDeliverySearchActiveStatus = termOfDeliverySearchActiveStatus;
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
