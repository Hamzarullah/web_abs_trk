
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

import com.inkombizz.master.bll.ItemOperatorBLL;
import com.inkombizz.master.model.ItemOperator;
import com.inkombizz.master.model.ItemOperatorTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemOperatorJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemOperator itemOperator;
    private ItemOperatorTemp itemOperatorTemp;
    private List <ItemOperatorTemp> listItemOperatorTemp;
    private String itemOperatorSearchCode = "";
    private String itemOperatorSearchName = "";
    private String itemOperatorSearchActiveStatus="true";
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
    
    @Action("item-operator-data")
    public String findData() {
        try {
            ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            ListPaging <ItemOperatorTemp> listPaging = itemOperatorBLL.findData(itemOperatorSearchCode,itemOperatorSearchName,itemOperatorSearchActiveStatus,paging);
            
            listItemOperatorTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-operator-get-data")
    public String findData1() {
        try {
            ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            this.itemOperatorTemp = itemOperatorBLL.findData(this.itemOperator.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-operator-get")
    public String findData2() {
        try {
            ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            this.itemOperatorTemp = itemOperatorBLL.findData(this.itemOperator.getCode(),this.itemOperator.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-operator-authority")
    public String itemOperatorAuthority(){
        try{
            
            ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemOperatorBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemOperatorBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemOperatorBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-operator-save")
    public String save() {
        try {
            ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            
          itemOperator.setInActiveDate(commonFunction.setDateTime(itemOperatorTemp.getInActiveDateTemp()));
         itemOperator.setCreatedDate(commonFunction.setDateTime(itemOperatorTemp.getCreatedDateTemp()));
            
            if(itemOperatorBLL.isExist(this.itemOperator.getCode())){
                this.errorMessage = "CODE "+this.itemOperator.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemOperatorBLL.save(this.itemOperator);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemOperator.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-operator-update")
    public String update() {
        try {
            ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            itemOperator.setInActiveDate(commonFunction.setDateTime(itemOperatorTemp.getInActiveDateTemp()));
            itemOperator.setCreatedDate(commonFunction.setDateTime(itemOperatorTemp.getCreatedDateTemp()));
            itemOperatorBLL.update(this.itemOperator);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemOperator.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-operator-delete")
    public String delete() {
        try {
           ItemOperatorBLL itemOperatorBLL = new ItemOperatorBLL(hbmSession);
            itemOperatorBLL.delete(this.itemOperator.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemOperator.getCode();
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

    public ItemOperator getItemOperator() {
        return itemOperator;
    }

    public void setItemOperator(ItemOperator itemOperator) {
        this.itemOperator = itemOperator;
    }

    public ItemOperatorTemp getItemOperatorTemp() {
        return itemOperatorTemp;
    }

    public void setItemOperatorTemp(ItemOperatorTemp itemOperatorTemp) {
        this.itemOperatorTemp = itemOperatorTemp;
    }

    public List<ItemOperatorTemp> getListItemOperatorTemp() {
        return listItemOperatorTemp;
    }

    public void setListItemOperatorTemp(List<ItemOperatorTemp> listItemOperatorTemp) {
        this.listItemOperatorTemp = listItemOperatorTemp;
    }

    public String getItemOperatorSearchCode() {
        return itemOperatorSearchCode;
    }

    public void setItemOperatorSearchCode(String itemOperatorSearchCode) {
        this.itemOperatorSearchCode = itemOperatorSearchCode;
    }

    public String getItemOperatorSearchName() {
        return itemOperatorSearchName;
    }

    public void setItemOperatorSearchName(String itemOperatorSearchName) {
        this.itemOperatorSearchName = itemOperatorSearchName;
    }

    public String getItemOperatorSearchActiveStatus() {
        return itemOperatorSearchActiveStatus;
    }

    public void setItemOperatorSearchActiveStatus(String itemOperatorSearchActiveStatus) {
        this.itemOperatorSearchActiveStatus = itemOperatorSearchActiveStatus;
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
