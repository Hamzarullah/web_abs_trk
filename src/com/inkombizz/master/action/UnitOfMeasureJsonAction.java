
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.UnitOfMeasureBLL;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.UnitOfMeasureBLL;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasureTemp;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasureTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class UnitOfMeasureJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private UnitOfMeasure unitOfMeasure;
    private UnitOfMeasureTemp unitOfMeasureTemp;
    private List <UnitOfMeasureTemp> listUnitOfMeasureTemp;
    private List <UnitOfMeasure> listUnitOfMeasure;
    private UnitOfMeasure searchUnitOfMeasure = new UnitOfMeasure();
    private String unitOfMeasureSearchCode = "";
    private String unitOfMeasureSearchName = "";
    private String unitOfMeasureSearchActiveStatus="true";
    private String actionAuthority="";
    private EnumTriState.Enum_TriState searchUnitOfMeasureActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("unit-of-measure-data")
    public String findData() {
        try {
            UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            ListPaging <UnitOfMeasureTemp> listPaging = unitOfMeasureBLL.findData(unitOfMeasureSearchCode,unitOfMeasureSearchName,unitOfMeasureSearchActiveStatus,paging);
            
            listUnitOfMeasureTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-product-head-search")
    public String search() {
        try {
            UnitOfMeasureBLL itemProductHeadBLL = new UnitOfMeasureBLL(hbmSession);
            
            ListPaging <UnitOfMeasure> listPaging = itemProductHeadBLL.search(paging, searchUnitOfMeasure.getCode(), searchUnitOfMeasure.getName(), searchUnitOfMeasureActiveStatus);
            
            listUnitOfMeasure = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("unit-of-measure-get-data")
    public String findData1() {
        try {
            UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            this.unitOfMeasureTemp = unitOfMeasureBLL.findData(this.unitOfMeasure.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("unit-of-measure-get")
    public String findData2() {
        try {
            UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            this.unitOfMeasureTemp = unitOfMeasureBLL.findData(this.unitOfMeasure.getCode(),this.unitOfMeasure.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("unit-of-measure-authority")
    public String unitOfMeasureAuthority(){
        try{
            
            UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(unitOfMeasureBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(unitOfMeasureBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(unitOfMeasureBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("unit-of-measure-save")
    public String save() {
        try {
            UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            
          unitOfMeasure.setInActiveDate(commonFunction.setDateTime(unitOfMeasureTemp.getInActiveDateTemp()));
         unitOfMeasure.setCreatedDate(commonFunction.setDateTime(unitOfMeasureTemp.getCreatedDateTemp()));
            
            if(unitOfMeasureBLL.isExist(this.unitOfMeasure.getCode())){
                this.errorMessage = "CODE "+this.unitOfMeasure.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                unitOfMeasureBLL.save(this.unitOfMeasure);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.unitOfMeasure.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("unit-of-measure-update")
    public String update() {
        try {
            UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            unitOfMeasure.setInActiveDate(commonFunction.setDateTime(unitOfMeasureTemp.getInActiveDateTemp()));
            unitOfMeasure.setCreatedDate(commonFunction.setDateTime(unitOfMeasureTemp.getCreatedDateTemp()));
            unitOfMeasureBLL.update(this.unitOfMeasure);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.unitOfMeasure.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("unit-of-measure-delete")
    public String delete() {
        try {
           UnitOfMeasureBLL unitOfMeasureBLL = new UnitOfMeasureBLL(hbmSession);
            unitOfMeasureBLL.delete(this.unitOfMeasure.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.unitOfMeasure.getCode();
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

    public UnitOfMeasure getUnitOfMeasure() {
        return unitOfMeasure;
    }

    public void setUnitOfMeasure(UnitOfMeasure unitOfMeasure) {
        this.unitOfMeasure = unitOfMeasure;
    }

    public UnitOfMeasureTemp getUnitOfMeasureTemp() {
        return unitOfMeasureTemp;
    }

    public void setUnitOfMeasureTemp(UnitOfMeasureTemp unitOfMeasureTemp) {
        this.unitOfMeasureTemp = unitOfMeasureTemp;
    }

    public List<UnitOfMeasureTemp> getListUnitOfMeasureTemp() {
        return listUnitOfMeasureTemp;
    }

    public void setListUnitOfMeasureTemp(List<UnitOfMeasureTemp> listUnitOfMeasureTemp) {
        this.listUnitOfMeasureTemp = listUnitOfMeasureTemp;
    }

    public String getUnitOfMeasureSearchCode() {
        return unitOfMeasureSearchCode;
    }

    public void setUnitOfMeasureSearchCode(String unitOfMeasureSearchCode) {
        this.unitOfMeasureSearchCode = unitOfMeasureSearchCode;
    }

    public String getUnitOfMeasureSearchName() {
        return unitOfMeasureSearchName;
    }

    public void setUnitOfMeasureSearchName(String unitOfMeasureSearchName) {
        this.unitOfMeasureSearchName = unitOfMeasureSearchName;
    }

    public String getUnitOfMeasureSearchActiveStatus() {
        return unitOfMeasureSearchActiveStatus;
    }

    public void setUnitOfMeasureSearchActiveStatus(String unitOfMeasureSearchActiveStatus) {
        this.unitOfMeasureSearchActiveStatus = unitOfMeasureSearchActiveStatus;
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
