
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

import com.inkombizz.master.bll.DcasMarkingBLL;
import com.inkombizz.master.model.DcasMarking;
import com.inkombizz.master.model.DcasMarkingTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasMarkingJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasMarking dcasMarking;
    private DcasMarkingTemp dcasMarkingTemp;
    private List<DcasMarkingTemp> listDcasMarkingTemp;
    private String dcasMarkingSearchCode = "";
    private String dcasMarkingSearchName = "";
    private String dcasMarkingSearchActiveStatus="true";
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
    
    @Action("dcas-marking-data")
    public String findData() {
        try {
            DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            ListPaging <DcasMarkingTemp> listPaging = dcasMarkingBLL.findData(dcasMarkingSearchCode,dcasMarkingSearchName,dcasMarkingSearchActiveStatus,paging);
            
            listDcasMarkingTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-marking-get-data")
    public String findData1() {
        try {
            DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            this.dcasMarkingTemp = dcasMarkingBLL.findData(this.dcasMarking.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-marking-get")
    public String findData2() {
        try {
            DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            this.dcasMarkingTemp = dcasMarkingBLL.findData(this.dcasMarking.getCode(),this.dcasMarking.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-marking-authority")
    public String dcasMarkingAuthority(){
        try{
            
            DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasMarkingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasMarkingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasMarkingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-marking-save")
    public String save() {
        try {
            DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            
          dcasMarking.setInActiveDate(commonFunction.setDateTime(dcasMarkingTemp.getInActiveDateTemp()));
         dcasMarking.setCreatedDate(commonFunction.setDateTime(dcasMarkingTemp.getCreatedDateTemp()));
            
            if(dcasMarkingBLL.isExist(this.dcasMarking.getCode())){
                this.errorMessage = "CODE "+this.dcasMarking.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasMarkingBLL.save(this.dcasMarking);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasMarking.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-marking-update")
    public String update() {
        try {
            DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            dcasMarking.setInActiveDate(commonFunction.setDateTime(dcasMarkingTemp.getInActiveDateTemp()));
            dcasMarking.setCreatedDate(commonFunction.setDateTime(dcasMarkingTemp.getCreatedDateTemp()));
            dcasMarkingBLL.update(this.dcasMarking);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasMarking.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-marking-delete")
    public String delete() {
        try {
           DcasMarkingBLL dcasMarkingBLL = new DcasMarkingBLL(hbmSession);
            dcasMarkingBLL.delete(this.dcasMarking.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasMarking.getCode();
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

    public DcasMarking getDcasMarking() {
        return dcasMarking;
    }

    public void setDcasMarking(DcasMarking dcasMarking) {
        this.dcasMarking = dcasMarking;
    }

    public DcasMarkingTemp getDcasMarkingTemp() {
        return dcasMarkingTemp;
    }

    public void setDcasMarkingTemp(DcasMarkingTemp dcasMarkingTemp) {
        this.dcasMarkingTemp = dcasMarkingTemp;
    }

    public List<DcasMarkingTemp> getListDcasMarkingTemp() {
        return listDcasMarkingTemp;
    }

    public void setListDcasMarkingTemp(List<DcasMarkingTemp> listDcasMarkingTemp) {
        this.listDcasMarkingTemp = listDcasMarkingTemp;
    }

    public String getDcasMarkingSearchCode() {
        return dcasMarkingSearchCode;
    }

    public void setDcasMarkingSearchCode(String dcasMarkingSearchCode) {
        this.dcasMarkingSearchCode = dcasMarkingSearchCode;
    }

    public String getDcasMarkingSearchName() {
        return dcasMarkingSearchName;
    }

    public void setDcasMarkingSearchName(String dcasMarkingSearchName) {
        this.dcasMarkingSearchName = dcasMarkingSearchName;
    }

    public String getDcasMarkingSearchActiveStatus() {
        return dcasMarkingSearchActiveStatus;
    }

    public void setDcasMarkingSearchActiveStatus(String dcasMarkingSearchActiveStatus) {
        this.dcasMarkingSearchActiveStatus = dcasMarkingSearchActiveStatus;
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
