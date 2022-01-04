
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

import com.inkombizz.master.bll.DcasHydroTestBLL;
import com.inkombizz.master.model.DcasHydroTest;
import com.inkombizz.master.model.DcasHydroTestTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasHydroTestJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasHydroTest dcasHydroTest;
    private DcasHydroTestTemp dcasHydroTestTemp;
    private List<DcasHydroTestTemp> listDcasHydroTestTemp;
    private String dcasHydroTestSearchCode = "";
    private String dcasHydroTestSearchName = "";
    private String dcasHydroTestSearchActiveStatus="true";
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
    
    @Action("dcas-hydro-test-data")
    public String findData() {
        try {
            DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            ListPaging <DcasHydroTestTemp> listPaging = dcasHydroTestBLL.findData(dcasHydroTestSearchCode,dcasHydroTestSearchName,dcasHydroTestSearchActiveStatus,paging);
            
            listDcasHydroTestTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-hydro-test-get-data")
    public String findData1() {
        try {
            DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            this.dcasHydroTestTemp = dcasHydroTestBLL.findData(this.dcasHydroTest.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-hydro-test-get")
    public String findData2() {
        try {
            DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            this.dcasHydroTestTemp = dcasHydroTestBLL.findData(this.dcasHydroTest.getCode(),this.dcasHydroTest.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-hydro-test-authority")
    public String dcasHydroTestAuthority(){
        try{
            
            DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasHydroTestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasHydroTestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasHydroTestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-hydro-test-save")
    public String save() {
        try {
            DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            
          dcasHydroTest.setInActiveDate(commonFunction.setDateTime(dcasHydroTestTemp.getInActiveDateTemp()));
         dcasHydroTest.setCreatedDate(commonFunction.setDateTime(dcasHydroTestTemp.getCreatedDateTemp()));
            
            if(dcasHydroTestBLL.isExist(this.dcasHydroTest.getCode())){
                this.errorMessage = "CODE "+this.dcasHydroTest.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasHydroTestBLL.save(this.dcasHydroTest);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasHydroTest.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-hydro-test-update")
    public String update() {
        try {
            DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            dcasHydroTest.setInActiveDate(commonFunction.setDateTime(dcasHydroTestTemp.getInActiveDateTemp()));
            dcasHydroTest.setCreatedDate(commonFunction.setDateTime(dcasHydroTestTemp.getCreatedDateTemp()));
            dcasHydroTestBLL.update(this.dcasHydroTest);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasHydroTest.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-hydro-test-delete")
    public String delete() {
        try {
           DcasHydroTestBLL dcasHydroTestBLL = new DcasHydroTestBLL(hbmSession);
            dcasHydroTestBLL.delete(this.dcasHydroTest.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasHydroTest.getCode();
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

    public DcasHydroTest getDcasHydroTest() {
        return dcasHydroTest;
    }

    public void setDcasHydroTest(DcasHydroTest dcasHydroTest) {
        this.dcasHydroTest = dcasHydroTest;
    }

    public DcasHydroTestTemp getDcasHydroTestTemp() {
        return dcasHydroTestTemp;
    }

    public void setDcasHydroTestTemp(DcasHydroTestTemp dcasHydroTestTemp) {
        this.dcasHydroTestTemp = dcasHydroTestTemp;
    }

    public List<DcasHydroTestTemp> getListDcasHydroTestTemp() {
        return listDcasHydroTestTemp;
    }

    public void setListDcasHydroTestTemp(List<DcasHydroTestTemp> listDcasHydroTestTemp) {
        this.listDcasHydroTestTemp = listDcasHydroTestTemp;
    }

    public String getDcasHydroTestSearchCode() {
        return dcasHydroTestSearchCode;
    }

    public void setDcasHydroTestSearchCode(String dcasHydroTestSearchCode) {
        this.dcasHydroTestSearchCode = dcasHydroTestSearchCode;
    }

    public String getDcasHydroTestSearchName() {
        return dcasHydroTestSearchName;
    }

    public void setDcasHydroTestSearchName(String dcasHydroTestSearchName) {
        this.dcasHydroTestSearchName = dcasHydroTestSearchName;
    }

    public String getDcasHydroTestSearchActiveStatus() {
        return dcasHydroTestSearchActiveStatus;
    }

    public void setDcasHydroTestSearchActiveStatus(String dcasHydroTestSearchActiveStatus) {
        this.dcasHydroTestSearchActiveStatus = dcasHydroTestSearchActiveStatus;
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
