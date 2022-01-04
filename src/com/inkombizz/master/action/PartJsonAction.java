
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.PartBLL;
import com.inkombizz.master.bll.PartBLL;
import com.inkombizz.master.model.Part;
import com.inkombizz.master.model.PartTemp;
import com.inkombizz.master.model.Part;
import com.inkombizz.master.model.Part;
import com.inkombizz.master.model.Part;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class PartJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Part part;
    private PartTemp partTemp;
    private List <PartTemp> listPartTemp;
    private Part searchPart = new Part();
    private List <Part> listPart;
    private String partSearchCode = "";
    private String partSearchName = "";
    private String partSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchPartActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("part-data")
    public String findData() {
        try {
            PartBLL partBLL = new PartBLL(hbmSession);
            ListPaging <PartTemp> listPaging = partBLL.findData(partSearchCode,partSearchName,partSearchActiveStatus,paging);
            
            listPartTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("part-get-data")
    public String findData1() {
        try {
            PartBLL partBLL = new PartBLL(hbmSession);
            this.partTemp = partBLL.findData(this.part.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("part-get")
    public String findData2() {
        try {
            PartBLL partBLL = new PartBLL(hbmSession);
            this.partTemp = partBLL.findData(this.part.getCode(),this.part.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("part-authority")
    public String partAuthority(){
        try{
            
            PartBLL partBLL = new PartBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(partBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(partBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(partBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("part-search")
    public String search() {
        try {
            PartBLL partBLL = new PartBLL(hbmSession);
            
            ListPaging <Part> listPaging = partBLL.search(paging, searchPart.getCode(), searchPart.getName(), searchPartActiveStatus);
            
            listPart = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("part-save")
    public String save() {
        try {
            PartBLL partBLL = new PartBLL(hbmSession);
            
            part.setInActiveDate(commonFunction.setDateTime(partTemp.getInActiveDateTemp()));
            part.setCreatedDate(commonFunction.setDateTime(partTemp.getCreatedDateTemp()));
            
            if(partBLL.isExist(this.part.getCode())){
                this.errorMessage = "CODE "+this.part.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                partBLL.save(this.part);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.part.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("part-update")
    public String update() {
        try {
            PartBLL partBLL = new PartBLL(hbmSession);
            part.setInActiveDate(commonFunction.setDateTime(partTemp.getInActiveDateTemp()));
            part.setCreatedDate(commonFunction.setDateTime(partTemp.getCreatedDateTemp()));
            partBLL.update(this.part);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.part.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("part-delete")
    public String delete() {
        try {
           PartBLL partBLL = new PartBLL(hbmSession);
            partBLL.delete(this.part.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.part.getCode();
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

    public Part getPart() {
        return part;
    }

    public void setPart(Part part) {
        this.part = part;
    }

    public PartTemp getPartTemp() {
        return partTemp;
    }

    public void setPartTemp(PartTemp partTemp) {
        this.partTemp = partTemp;
    }

    public List<PartTemp> getListPartTemp() {
        return listPartTemp;
    }

    public void setListPartTemp(List<PartTemp> listPartTemp) {
        this.listPartTemp = listPartTemp;
    }

    public String getPartSearchCode() {
        return partSearchCode;
    }

    public void setPartSearchCode(String partSearchCode) {
        this.partSearchCode = partSearchCode;
    }

    public String getPartSearchName() {
        return partSearchName;
    }

    public void setPartSearchName(String partSearchName) {
        this.partSearchName = partSearchName;
    }

    public String getPartSearchActiveStatus() {
        return partSearchActiveStatus;
    }

    public void setPartSearchActiveStatus(String partSearchActiveStatus) {
        this.partSearchActiveStatus = partSearchActiveStatus;
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

    public Part getSearchPart() {
        return searchPart;
    }

    public void setSearchPart(Part searchPart) {
        this.searchPart = searchPart;
    }

    public EnumTriState.Enum_TriState getSearchPartActiveStatus() {
        return searchPartActiveStatus;
    }

    public void setSearchPartActiveStatus(EnumTriState.Enum_TriState searchPartActiveStatus) {
        this.searchPartActiveStatus = searchPartActiveStatus;
    }

    public List<Part> getListPart() {
        return listPart;
    }

    public void setListPart(List<Part> listPart) {
        this.listPart = listPart;
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
