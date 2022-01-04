
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

import com.inkombizz.master.bll.DcasFireSafeByDesignBLL;
import com.inkombizz.master.model.DcasFireSafeByDesign;
import com.inkombizz.master.model.DcasFireSafeByDesignTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasFireSafeByDesignJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasFireSafeByDesign dcasFireSafeByDesign;
    private DcasFireSafeByDesignTemp dcasFireSafeByDesignTemp;
    private List<DcasFireSafeByDesignTemp> listDcasFireSafeByDesignTemp;
    private String dcasFireSafeByDesignSearchCode = "";
    private String dcasFireSafeByDesignSearchName = "";
    private String dcasFireSafeByDesignSearchActiveStatus="true";
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
    
    @Action("dcas-fire-safe-by-design-data")
    public String findData() {
        try {
            DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            ListPaging <DcasFireSafeByDesignTemp> listPaging = dcasFireSafeByDesignBLL.findData(dcasFireSafeByDesignSearchCode,dcasFireSafeByDesignSearchName,dcasFireSafeByDesignSearchActiveStatus,paging);
            
            listDcasFireSafeByDesignTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-fire-safe-by-design-get-data")
    public String findData1() {
        try {
            DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            this.dcasFireSafeByDesignTemp = dcasFireSafeByDesignBLL.findData(this.dcasFireSafeByDesign.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-fire-safe-by-design-get")
    public String findData2() {
        try {
            DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            this.dcasFireSafeByDesignTemp = dcasFireSafeByDesignBLL.findData(this.dcasFireSafeByDesign.getCode(),this.dcasFireSafeByDesign.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-fire-safe-by-design-authority")
    public String dcasFireSafeByDesignAuthority(){
        try{
            
            DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasFireSafeByDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasFireSafeByDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasFireSafeByDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-fire-safe-by-design-save")
    public String save() {
        try {
            DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            
          dcasFireSafeByDesign.setInActiveDate(commonFunction.setDateTime(dcasFireSafeByDesignTemp.getInActiveDateTemp()));
         dcasFireSafeByDesign.setCreatedDate(commonFunction.setDateTime(dcasFireSafeByDesignTemp.getCreatedDateTemp()));
            
            if(dcasFireSafeByDesignBLL.isExist(this.dcasFireSafeByDesign.getCode())){
                this.errorMessage = "CODE "+this.dcasFireSafeByDesign.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasFireSafeByDesignBLL.save(this.dcasFireSafeByDesign);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasFireSafeByDesign.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-fire-safe-by-design-update")
    public String update() {
        try {
            DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            dcasFireSafeByDesign.setInActiveDate(commonFunction.setDateTime(dcasFireSafeByDesignTemp.getInActiveDateTemp()));
            dcasFireSafeByDesign.setCreatedDate(commonFunction.setDateTime(dcasFireSafeByDesignTemp.getCreatedDateTemp()));
            dcasFireSafeByDesignBLL.update(this.dcasFireSafeByDesign);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasFireSafeByDesign.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-fire-safe-by-design-delete")
    public String delete() {
        try {
           DcasFireSafeByDesignBLL dcasFireSafeByDesignBLL = new DcasFireSafeByDesignBLL(hbmSession);
            dcasFireSafeByDesignBLL.delete(this.dcasFireSafeByDesign.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasFireSafeByDesign.getCode();
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

    public DcasFireSafeByDesign getDcasFireSafeByDesign() {
        return dcasFireSafeByDesign;
    }

    public void setDcasFireSafeByDesign(DcasFireSafeByDesign dcasFireSafeByDesign) {
        this.dcasFireSafeByDesign = dcasFireSafeByDesign;
    }

    public DcasFireSafeByDesignTemp getDcasFireSafeByDesignTemp() {
        return dcasFireSafeByDesignTemp;
    }

    public void setDcasFireSafeByDesignTemp(DcasFireSafeByDesignTemp dcasFireSafeByDesignTemp) {
        this.dcasFireSafeByDesignTemp = dcasFireSafeByDesignTemp;
    }

    public List<DcasFireSafeByDesignTemp> getListDcasFireSafeByDesignTemp() {
        return listDcasFireSafeByDesignTemp;
    }

    public void setListDcasFireSafeByDesignTemp(List<DcasFireSafeByDesignTemp> listDcasFireSafeByDesignTemp) {
        this.listDcasFireSafeByDesignTemp = listDcasFireSafeByDesignTemp;
    }

    public String getDcasFireSafeByDesignSearchCode() {
        return dcasFireSafeByDesignSearchCode;
    }

    public void setDcasFireSafeByDesignSearchCode(String dcasFireSafeByDesignSearchCode) {
        this.dcasFireSafeByDesignSearchCode = dcasFireSafeByDesignSearchCode;
    }

    public String getDcasFireSafeByDesignSearchName() {
        return dcasFireSafeByDesignSearchName;
    }

    public void setDcasFireSafeByDesignSearchName(String dcasFireSafeByDesignSearchName) {
        this.dcasFireSafeByDesignSearchName = dcasFireSafeByDesignSearchName;
    }

    public String getDcasFireSafeByDesignSearchActiveStatus() {
        return dcasFireSafeByDesignSearchActiveStatus;
    }

    public void setDcasFireSafeByDesignSearchActiveStatus(String dcasFireSafeByDesignSearchActiveStatus) {
        this.dcasFireSafeByDesignSearchActiveStatus = dcasFireSafeByDesignSearchActiveStatus;
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
