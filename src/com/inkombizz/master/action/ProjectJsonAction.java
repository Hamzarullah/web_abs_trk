
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

import com.inkombizz.master.bll.ProjectBLL;
import com.inkombizz.master.model.Project;
import com.inkombizz.master.model.ProjectTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ProjectJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Project project;
    private ProjectTemp projectTemp;
    private List <ProjectTemp> listProjectTemp;
    private String projectSearchCode = "";
    private String projectSearchName = "";
    private String projectSearchActiveStatus="true";
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
    
    @Action("project-data")
    public String findData() {
        try {
            ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            ListPaging <ProjectTemp> listPaging = projectBLL.findData(projectSearchCode,projectSearchName,projectSearchActiveStatus,paging);
            
            listProjectTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("project-get-data")
    public String findData1() {
        try {
            ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            this.projectTemp = projectBLL.findData(this.project.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("project-get")
    public String findData2() {
        try {
            ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            this.projectTemp = projectBLL.findData(this.project.getCode(),this.project.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("project-authority")
    public String projectAuthority(){
        try{
            
            ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(projectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(projectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(projectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("project-save")
    public String save() {
        try {
            ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            
          project.setInActiveDate(commonFunction.setDateTime(projectTemp.getInActiveDateTemp()));
         project.setCreatedDate(commonFunction.setDateTime(projectTemp.getCreatedDateTemp()));
            
            if(projectBLL.isExist(this.project.getCode())){
                this.errorMessage = "CODE "+this.project.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                projectBLL.save(this.project);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.project.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("project-update")
    public String update() {
        try {
            ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            project.setInActiveDate(commonFunction.setDateTime(projectTemp.getInActiveDateTemp()));
            project.setCreatedDate(commonFunction.setDateTime(projectTemp.getCreatedDateTemp()));
            projectBLL.update(this.project);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.project.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("project-delete")
    public String delete() {
        try {
           ProjectBLL projectBLL = new ProjectBLL(hbmSession);
            projectBLL.delete(this.project.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.project.getCode();
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

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public ProjectTemp getProjectTemp() {
        return projectTemp;
    }

    public void setProjectTemp(ProjectTemp projectTemp) {
        this.projectTemp = projectTemp;
    }

    public List<ProjectTemp> getListProjectTemp() {
        return listProjectTemp;
    }

    public void setListProjectTemp(List<ProjectTemp> listProjectTemp) {
        this.listProjectTemp = listProjectTemp;
    }

    public String getProjectSearchCode() {
        return projectSearchCode;
    }

    public void setProjectSearchCode(String projectSearchCode) {
        this.projectSearchCode = projectSearchCode;
    }

    public String getProjectSearchName() {
        return projectSearchName;
    }

    public void setProjectSearchName(String projectSearchName) {
        this.projectSearchName = projectSearchName;
    }

    public String getProjectSearchActiveStatus() {
        return projectSearchActiveStatus;
    }

    public void setProjectSearchActiveStatus(String projectSearchActiveStatus) {
        this.projectSearchActiveStatus = projectSearchActiveStatus;
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
