
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

import com.inkombizz.master.bll.JobPositionBLL;
import com.inkombizz.master.model.JobPosition;
import com.inkombizz.master.model.JobPositionTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class JobPositionJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private JobPosition jobPosition;
    private JobPositionTemp jobPositionTemp;
    private List <JobPositionTemp> listJobPositionTemp;
    private String jobPositionSearchCode = "";
    private String jobPositionSearchName = "";
    private String jobPositionSearchActiveStatus="true";
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
    
    @Action("job-position-data")
    public String findData() {
        try {
            JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            ListPaging <JobPositionTemp> listPaging = jobPositionBLL.findData(jobPositionSearchCode,jobPositionSearchName,jobPositionSearchActiveStatus,paging);
            
            listJobPositionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("job-position-get-data")
    public String findData1() {
        try {
            JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            this.jobPositionTemp = jobPositionBLL.findData(this.jobPosition.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("job-position-get")
    public String findData2() {
        try {
            JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            this.jobPositionTemp = jobPositionBLL.findData(this.jobPosition.getCode(),this.jobPosition.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("job-position-authority")
    public String jobPositionAuthority(){
        try{
            
            JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(jobPositionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(jobPositionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(jobPositionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("job-position-save")
    public String save() {
        try {
            JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            
            jobPosition.setInActiveDate(commonFunction.setDateTime(jobPositionTemp.getInActiveDateTemp()));
            jobPosition.setCreatedDate(commonFunction.setDateTime(jobPositionTemp.getCreatedDateTemp()));
            
            if(jobPositionBLL.isExist(this.jobPosition.getCode())){
                this.errorMessage = "CODE "+this.jobPosition.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                jobPositionBLL.save(this.jobPosition);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.jobPosition.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("job-position-update")
    public String update() {
        try {
            JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            jobPosition.setInActiveDate(commonFunction.setDateTime(jobPositionTemp.getInActiveDateTemp()));
            jobPosition.setCreatedDate(commonFunction.setDateTime(jobPositionTemp.getCreatedDateTemp()));
            jobPositionBLL.update(this.jobPosition);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.jobPosition.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("job-position-delete")
    public String delete() {
        try {
           JobPositionBLL jobPositionBLL = new JobPositionBLL(hbmSession);
            jobPositionBLL.delete(this.jobPosition.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.jobPosition.getCode();
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

    public JobPosition getJobPosition() {
        return jobPosition;
    }

    public void setJobPosition(JobPosition jobPosition) {
        this.jobPosition = jobPosition;
    }

    public JobPositionTemp getJobPositionTemp() {
        return jobPositionTemp;
    }

    public void setJobPositionTemp(JobPositionTemp jobPositionTemp) {
        this.jobPositionTemp = jobPositionTemp;
    }

    public List<JobPositionTemp> getListJobPositionTemp() {
        return listJobPositionTemp;
    }

    public void setListJobPositionTemp(List<JobPositionTemp> listJobPositionTemp) {
        this.listJobPositionTemp = listJobPositionTemp;
    }

    public String getJobPositionSearchCode() {
        return jobPositionSearchCode;
    }

    public void setJobPositionSearchCode(String jobPositionSearchCode) {
        this.jobPositionSearchCode = jobPositionSearchCode;
    }

    public String getJobPositionSearchName() {
        return jobPositionSearchName;
    }

    public void setJobPositionSearchName(String jobPositionSearchName) {
        this.jobPositionSearchName = jobPositionSearchName;
    }

    public String getJobPositionSearchActiveStatus() {
        return jobPositionSearchActiveStatus;
    }

    public void setJobPositionSearchActiveStatus(String jobPositionSearchActiveStatus) {
        this.jobPositionSearchActiveStatus = jobPositionSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
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
