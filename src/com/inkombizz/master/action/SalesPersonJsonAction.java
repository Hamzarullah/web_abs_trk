
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
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

import com.inkombizz.master.bll.SalesPersonBLL;
import com.inkombizz.master.model.SalesPerson;
import com.inkombizz.master.model.SalesPersonDistributionChannel;
import com.inkombizz.master.model.SalesPersonDistributionChannelTemp;
import com.inkombizz.master.model.SalesPersonItemProductHead;
import com.inkombizz.master.model.SalesPersonItemProductHeadTemp;
import com.inkombizz.master.model.SalesPersonTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result(type = "json")
public class SalesPersonJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private SalesPerson salesPerson;
    private SalesPersonTemp salesPersonTemp;
    private List <SalesPersonTemp> listSalesPersonTemp;
    private String salesPersonSearchCode = "";
    private String salesPersonSearchName = "";
    private String salesPersonSearchActiveStatus="true";
    private String actionAuthority="";
    private String salesPersonCode = "";
     
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
 
    @Action("sales-person-data")
    public String findData() {
        try {
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            ListPaging <SalesPersonTemp> listPaging = salesPersonBLL.findData(salesPersonSearchCode,salesPersonSearchName,salesPersonSearchActiveStatus,paging);
            
            listSalesPersonTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-person-get-data")
    public String findData1() {
        try {
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            this.salesPersonTemp = salesPersonBLL.findData(this.salesPerson.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-person-get")
    public String findData2() {
        try {
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            this.salesPersonTemp = salesPersonBLL.findData(this.salesPerson.getCode(),this.salesPerson.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-person-authority")
    public String salesPersonAuthority(){
        try{
            
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(salesPersonBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(salesPersonBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(salesPersonBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    
    @Action("sales-person-save")
    public String save() {
        try {
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            
            salesPerson.setInActiveDate(commonFunction.setDateTime(salesPersonTemp.getInActiveDateTemp()));
            salesPerson.setCreatedDate(commonFunction.setDateTime(salesPersonTemp.getCreatedDateTemp()));

           
            if(salesPersonBLL.isExist(this.salesPerson.getCode())){
                this.errorMessage = "CODE "+this.salesPerson.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                salesPersonBLL.save(this.salesPerson);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.salesPerson.getCode();
            }
                        
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-person-update")
    public String update() {
        try {
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            
            salesPerson.setInActiveDate(commonFunction.setDateTime(salesPersonTemp.getInActiveDateTemp()));
            salesPerson.setCreatedDate(commonFunction.setDateTime(salesPersonTemp.getCreatedDateTemp()));
            salesPersonBLL.update(this.salesPerson);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.salesPerson.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-person-delete")
    public String delete() {
        try {
            SalesPersonBLL salesPersonBLL = new SalesPersonBLL(hbmSession);
            
            salesPersonBLL.delete(this.salesPerson.getCode());
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.salesPerson.getCode();
            
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

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public SalesPerson getSalesPerson() {
        return salesPerson;
    }

    public void setSalesPerson(SalesPerson salesPerson) {
        this.salesPerson = salesPerson;
    }

    public SalesPersonTemp getSalesPersonTemp() {
        return salesPersonTemp;
    }

    public void setSalesPersonTemp(SalesPersonTemp salesPersonTemp) {
        this.salesPersonTemp = salesPersonTemp;
    }

    public List<SalesPersonTemp> getListSalesPersonTemp() {
        return listSalesPersonTemp;
    }

    public void setListSalesPersonTemp(List<SalesPersonTemp> listSalesPersonTemp) {
        this.listSalesPersonTemp = listSalesPersonTemp;
    }

    public String getSalesPersonSearchCode() {
        return salesPersonSearchCode;
    }

    public void setSalesPersonSearchCode(String salesPersonSearchCode) {
        this.salesPersonSearchCode = salesPersonSearchCode;
    }

    public String getSalesPersonSearchName() {
        return salesPersonSearchName;
    }

    public void setSalesPersonSearchName(String salesPersonSearchName) {
        this.salesPersonSearchName = salesPersonSearchName;
    }

    public String getSalesPersonSearchActiveStatus() {
        return salesPersonSearchActiveStatus;
    }

    public void setSalesPersonSearchActiveStatus(String salesPersonSearchActiveStatus) {
        this.salesPersonSearchActiveStatus = salesPersonSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    
    public String getSalesPersonCode() {
        return salesPersonCode;
    }

    public void setSalesPersonCode(String salesPersonCode) {
        this.salesPersonCode = salesPersonCode;
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
    
    Paging paging = new Paging();

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
