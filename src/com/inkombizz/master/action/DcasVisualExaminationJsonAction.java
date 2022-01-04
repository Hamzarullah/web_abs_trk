
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

import com.inkombizz.master.bll.DcasVisualExaminationBLL;
import com.inkombizz.master.model.DcasVisualExamination;
import com.inkombizz.master.model.DcasVisualExaminationTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasVisualExaminationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasVisualExamination dcasVisualExamination;
    private DcasVisualExaminationTemp dcasVisualExaminationTemp;
    private List<DcasVisualExaminationTemp> listDcasVisualExaminationTemp;
    private String dcasVisualExaminationSearchCode = "";
    private String dcasVisualExaminationSearchName = "";
    private String dcasVisualExaminationSearchActiveStatus="true";
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
    
    @Action("dcas-visual-examination-data")
    public String findData() {
        try {
            DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            ListPaging <DcasVisualExaminationTemp> listPaging = dcasVisualExaminationBLL.findData(dcasVisualExaminationSearchCode,dcasVisualExaminationSearchName,dcasVisualExaminationSearchActiveStatus,paging);
            
            listDcasVisualExaminationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-visual-examination-get-data")
    public String findData1() {
        try {
            DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            this.dcasVisualExaminationTemp = dcasVisualExaminationBLL.findData(this.dcasVisualExamination.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-visual-examination-get")
    public String findData2() {
        try {
            DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            this.dcasVisualExaminationTemp = dcasVisualExaminationBLL.findData(this.dcasVisualExamination.getCode(),this.dcasVisualExamination.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-visual-examination-authority")
    public String dcasVisualExaminationAuthority(){
        try{
            
            DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasVisualExaminationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasVisualExaminationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasVisualExaminationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-visual-examination-save")
    public String save() {
        try {
            DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            
          dcasVisualExamination.setInActiveDate(commonFunction.setDateTime(dcasVisualExaminationTemp.getInActiveDateTemp()));
         dcasVisualExamination.setCreatedDate(commonFunction.setDateTime(dcasVisualExaminationTemp.getCreatedDateTemp()));
            
            if(dcasVisualExaminationBLL.isExist(this.dcasVisualExamination.getCode())){
                this.errorMessage = "CODE "+this.dcasVisualExamination.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasVisualExaminationBLL.save(this.dcasVisualExamination);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasVisualExamination.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-visual-examination-update")
    public String update() {
        try {
            DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            dcasVisualExamination.setInActiveDate(commonFunction.setDateTime(dcasVisualExaminationTemp.getInActiveDateTemp()));
            dcasVisualExamination.setCreatedDate(commonFunction.setDateTime(dcasVisualExaminationTemp.getCreatedDateTemp()));
            dcasVisualExaminationBLL.update(this.dcasVisualExamination);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasVisualExamination.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-visual-examination-delete")
    public String delete() {
        try {
           DcasVisualExaminationBLL dcasVisualExaminationBLL = new DcasVisualExaminationBLL(hbmSession);
            dcasVisualExaminationBLL.delete(this.dcasVisualExamination.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasVisualExamination.getCode();
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

    public DcasVisualExamination getDcasVisualExamination() {
        return dcasVisualExamination;
    }

    public void setDcasVisualExamination(DcasVisualExamination dcasVisualExamination) {
        this.dcasVisualExamination = dcasVisualExamination;
    }

    public DcasVisualExaminationTemp getDcasVisualExaminationTemp() {
        return dcasVisualExaminationTemp;
    }

    public void setDcasVisualExaminationTemp(DcasVisualExaminationTemp dcasVisualExaminationTemp) {
        this.dcasVisualExaminationTemp = dcasVisualExaminationTemp;
    }

    public List<DcasVisualExaminationTemp> getListDcasVisualExaminationTemp() {
        return listDcasVisualExaminationTemp;
    }

    public void setListDcasVisualExaminationTemp(List<DcasVisualExaminationTemp> listDcasVisualExaminationTemp) {
        this.listDcasVisualExaminationTemp = listDcasVisualExaminationTemp;
    }

    public String getDcasVisualExaminationSearchCode() {
        return dcasVisualExaminationSearchCode;
    }

    public void setDcasVisualExaminationSearchCode(String dcasVisualExaminationSearchCode) {
        this.dcasVisualExaminationSearchCode = dcasVisualExaminationSearchCode;
    }

    public String getDcasVisualExaminationSearchName() {
        return dcasVisualExaminationSearchName;
    }

    public void setDcasVisualExaminationSearchName(String dcasVisualExaminationSearchName) {
        this.dcasVisualExaminationSearchName = dcasVisualExaminationSearchName;
    }

    public String getDcasVisualExaminationSearchActiveStatus() {
        return dcasVisualExaminationSearchActiveStatus;
    }

    public void setDcasVisualExaminationSearchActiveStatus(String dcasVisualExaminationSearchActiveStatus) {
        this.dcasVisualExaminationSearchActiveStatus = dcasVisualExaminationSearchActiveStatus;
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
