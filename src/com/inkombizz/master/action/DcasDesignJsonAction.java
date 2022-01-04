
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

import com.inkombizz.master.bll.DcasDesignBLL;
import com.inkombizz.master.model.DcasDesign;
import com.inkombizz.master.model.DcasDesignTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasDesignJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasDesign dcasDesign;
    private DcasDesignTemp dcasDesignTemp;
    private List<DcasDesignTemp> listDcasDesignTemp;
    private String dcasDesignSearchCode = "";
    private String dcasDesignSearchName = "";
    private String dcasDesignSearchActiveStatus="true";
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
    
    @Action("dcas-design-data")
    public String findData() {
        try {
            DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            ListPaging <DcasDesignTemp> listPaging = dcasDesignBLL.findData(dcasDesignSearchCode,dcasDesignSearchName,dcasDesignSearchActiveStatus,paging);
            
            listDcasDesignTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-design-get-data")
    public String findData1() {
        try {
            DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            this.dcasDesignTemp = dcasDesignBLL.findData(this.dcasDesign.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-design-get")
    public String findData2() {
        try {
            DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            this.dcasDesignTemp = dcasDesignBLL.findData(this.dcasDesign.getCode(),this.dcasDesign.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-design-authority")
    public String dcasDesignAuthority(){
        try{
            
            DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-design-save")
    public String save() {
        try {
            DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            
          dcasDesign.setInActiveDate(commonFunction.setDateTime(dcasDesignTemp.getInActiveDateTemp()));
         dcasDesign.setCreatedDate(commonFunction.setDateTime(dcasDesignTemp.getCreatedDateTemp()));
            
            if(dcasDesignBLL.isExist(this.dcasDesign.getCode())){
                this.errorMessage = "CODE "+this.dcasDesign.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasDesignBLL.save(this.dcasDesign);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasDesign.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-design-update")
    public String update() {
        try {
            DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            dcasDesign.setInActiveDate(commonFunction.setDateTime(dcasDesignTemp.getInActiveDateTemp()));
            dcasDesign.setCreatedDate(commonFunction.setDateTime(dcasDesignTemp.getCreatedDateTemp()));
            dcasDesignBLL.update(this.dcasDesign);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasDesign.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-design-delete")
    public String delete() {
        try {
           DcasDesignBLL dcasDesignBLL = new DcasDesignBLL(hbmSession);
            dcasDesignBLL.delete(this.dcasDesign.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasDesign.getCode();
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

    public DcasDesign getDcasDesign() {
        return dcasDesign;
    }

    public void setDcasDesign(DcasDesign dcasDesign) {
        this.dcasDesign = dcasDesign;
    }

    public DcasDesignTemp getDcasDesignTemp() {
        return dcasDesignTemp;
    }

    public void setDcasDesignTemp(DcasDesignTemp dcasDesignTemp) {
        this.dcasDesignTemp = dcasDesignTemp;
    }

    public List<DcasDesignTemp> getListDcasDesignTemp() {
        return listDcasDesignTemp;
    }

    public void setListDcasDesignTemp(List<DcasDesignTemp> listDcasDesignTemp) {
        this.listDcasDesignTemp = listDcasDesignTemp;
    }

    public String getDcasDesignSearchCode() {
        return dcasDesignSearchCode;
    }

    public void setDcasDesignSearchCode(String dcasDesignSearchCode) {
        this.dcasDesignSearchCode = dcasDesignSearchCode;
    }

    public String getDcasDesignSearchName() {
        return dcasDesignSearchName;
    }

    public void setDcasDesignSearchName(String dcasDesignSearchName) {
        this.dcasDesignSearchName = dcasDesignSearchName;
    }

    public String getDcasDesignSearchActiveStatus() {
        return dcasDesignSearchActiveStatus;
    }

    public void setDcasDesignSearchActiveStatus(String dcasDesignSearchActiveStatus) {
        this.dcasDesignSearchActiveStatus = dcasDesignSearchActiveStatus;
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
