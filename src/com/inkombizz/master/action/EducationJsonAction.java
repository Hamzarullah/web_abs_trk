
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

import com.inkombizz.master.bll.EducationBLL;
import com.inkombizz.master.model.Education;
import com.inkombizz.master.model.EducationTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class EducationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Education education;
    private EducationTemp educationTemp;
    private List <EducationTemp> listEducationTemp;
    private String educationSearchCode = "";
    private String educationSearchName = "";
    private String educationSearchActiveStatus="true";
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
    
    @Action("education-data")
    public String findData() {
        try {
            EducationBLL educationBLL = new EducationBLL(hbmSession);
            ListPaging <EducationTemp> listPaging = educationBLL.findData(educationSearchCode,educationSearchName,educationSearchActiveStatus,paging);
            
            listEducationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("education-get-data")
    public String findData1() {
        try {
            EducationBLL educationBLL = new EducationBLL(hbmSession);
            this.educationTemp = educationBLL.findData(this.education.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("education-get")
    public String findData2() {
        try {
            EducationBLL educationBLL = new EducationBLL(hbmSession);
            this.educationTemp = educationBLL.findData(this.education.getCode(),this.education.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("education-authority")
    public String educationAuthority(){
        try{
            
            EducationBLL educationBLL = new EducationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(educationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(educationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(educationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("education-save")
    public String save() {
        try {
            EducationBLL educationBLL = new EducationBLL(hbmSession);
            
            education.setInActiveDate(commonFunction.setDateTime(educationTemp.getInActiveDateTemp()));
            education.setCreatedDate(commonFunction.setDateTime(educationTemp.getCreatedDateTemp()));
            
            if(educationBLL.isExist(this.education.getCode())){
                this.errorMessage = "CODE "+this.education.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                educationBLL.save(this.education);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.education.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("education-update")
    public String update() {
        try {
            EducationBLL educationBLL = new EducationBLL(hbmSession);
            education.setInActiveDate(commonFunction.setDateTime(educationTemp.getInActiveDateTemp()));
            education.setCreatedDate(commonFunction.setDateTime(educationTemp.getCreatedDateTemp()));
            educationBLL.update(this.education);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.education.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("education-delete")
    public String delete() {
        try {
           EducationBLL educationBLL = new EducationBLL(hbmSession);
            educationBLL.delete(this.education.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.education.getCode();
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

    public Education getEducation() {
        return education;
    }

    public void setEducation(Education education) {
        this.education = education;
    }

    public EducationTemp getEducationTemp() {
        return educationTemp;
    }

    public void setEducationTemp(EducationTemp educationTemp) {
        this.educationTemp = educationTemp;
    }

    public List<EducationTemp> getListEducationTemp() {
        return listEducationTemp;
    }

    public void setListEducationTemp(List<EducationTemp> listEducationTemp) {
        this.listEducationTemp = listEducationTemp;
    }

    public String getEducationSearchCode() {
        return educationSearchCode;
    }

    public void setEducationSearchCode(String educationSearchCode) {
        this.educationSearchCode = educationSearchCode;
    }

    public String getEducationSearchName() {
        return educationSearchName;
    }

    public void setEducationSearchName(String educationSearchName) {
        this.educationSearchName = educationSearchName;
    }

    public String getEducationSearchActiveStatus() {
        return educationSearchActiveStatus;
    }

    public void setEducationSearchActiveStatus(String educationSearchActiveStatus) {
        this.educationSearchActiveStatus = educationSearchActiveStatus;
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
