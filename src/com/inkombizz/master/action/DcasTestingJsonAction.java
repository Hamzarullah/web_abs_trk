
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

import com.inkombizz.master.bll.DcasTestingBLL;
import com.inkombizz.master.model.DcasTesting;
import com.inkombizz.master.model.DcasTestingTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasTestingJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasTesting dcasTesting;
    private DcasTestingTemp dcasTestingTemp;
    private List<DcasTestingTemp> listDcasTestingTemp;
    private String dcasTestingSearchCode = "";
    private String dcasTestingSearchName = "";
    private String dcasTestingSearchActiveStatus="true";
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
    
    @Action("dcas-testing-data")
    public String findData() {
        try {
            DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            ListPaging <DcasTestingTemp> listPaging = dcasTestingBLL.findData(dcasTestingSearchCode,dcasTestingSearchName,dcasTestingSearchActiveStatus,paging);
            
            listDcasTestingTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-testing-get-data")
    public String findData1() {
        try {
            DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            this.dcasTestingTemp = dcasTestingBLL.findData(this.dcasTesting.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-testing-get")
    public String findData2() {
        try {
            DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            this.dcasTestingTemp = dcasTestingBLL.findData(this.dcasTesting.getCode(),this.dcasTesting.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-testing-authority")
    public String dcasTestingAuthority(){
        try{
            
            DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasTestingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasTestingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasTestingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-testing-save")
    public String save() {
        try {
            DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            
          dcasTesting.setInActiveDate(commonFunction.setDateTime(dcasTestingTemp.getInActiveDateTemp()));
         dcasTesting.setCreatedDate(commonFunction.setDateTime(dcasTestingTemp.getCreatedDateTemp()));
            
            if(dcasTestingBLL.isExist(this.dcasTesting.getCode())){
                this.errorMessage = "CODE "+this.dcasTesting.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasTestingBLL.save(this.dcasTesting);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasTesting.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-testing-update")
    public String update() {
        try {
            DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            dcasTesting.setInActiveDate(commonFunction.setDateTime(dcasTestingTemp.getInActiveDateTemp()));
            dcasTesting.setCreatedDate(commonFunction.setDateTime(dcasTestingTemp.getCreatedDateTemp()));
            dcasTestingBLL.update(this.dcasTesting);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasTesting.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-testing-delete")
    public String delete() {
        try {
           DcasTestingBLL dcasTestingBLL = new DcasTestingBLL(hbmSession);
            dcasTestingBLL.delete(this.dcasTesting.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasTesting.getCode();
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

    public DcasTesting getDcasTesting() {
        return dcasTesting;
    }

    public void setDcasTesting(DcasTesting dcasTesting) {
        this.dcasTesting = dcasTesting;
    }

    public DcasTestingTemp getDcasTestingTemp() {
        return dcasTestingTemp;
    }

    public void setDcasTestingTemp(DcasTestingTemp dcasTestingTemp) {
        this.dcasTestingTemp = dcasTestingTemp;
    }

    public List<DcasTestingTemp> getListDcasTestingTemp() {
        return listDcasTestingTemp;
    }

    public void setListDcasTestingTemp(List<DcasTestingTemp> listDcasTestingTemp) {
        this.listDcasTestingTemp = listDcasTestingTemp;
    }

    public String getDcasTestingSearchCode() {
        return dcasTestingSearchCode;
    }

    public void setDcasTestingSearchCode(String dcasTestingSearchCode) {
        this.dcasTestingSearchCode = dcasTestingSearchCode;
    }

    public String getDcasTestingSearchName() {
        return dcasTestingSearchName;
    }

    public void setDcasTestingSearchName(String dcasTestingSearchName) {
        this.dcasTestingSearchName = dcasTestingSearchName;
    }

    public String getDcasTestingSearchActiveStatus() {
        return dcasTestingSearchActiveStatus;
    }

    public void setDcasTestingSearchActiveStatus(String dcasTestingSearchActiveStatus) {
        this.dcasTestingSearchActiveStatus = dcasTestingSearchActiveStatus;
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
