
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

import com.inkombizz.master.bll.ItemBackseatBLL;
import com.inkombizz.master.bll.ItemBackseatBLL;
import com.inkombizz.master.model.ItemBackseat;
import com.inkombizz.master.model.ItemBackseatTemp;
import com.inkombizz.master.model.ItemBackseat;
import com.inkombizz.master.model.ItemBackseat;
import com.inkombizz.master.model.ItemBackseat;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBackseatJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBackseat itemBackseat;
    private ItemBackseatTemp itemBackseatTemp;
    private List <ItemBackseatTemp> listItemBackseatTemp;
    private ItemBackseat searchItemBackseat = new ItemBackseat();
    private List <ItemBackseat> listItemBackseat;
    private String itemBackseatSearchCode = "";
    private String itemBackseatSearchName = "";
    private String itemBackseatSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemBackseatActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-backseat-data")
    public String findData() {
        try {
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            ListPaging <ItemBackseatTemp> listPaging = itemBackseatBLL.findData(itemBackseatSearchCode,itemBackseatSearchName,itemBackseatSearchActiveStatus,paging);
            
            listItemBackseatTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-backseat-get-data")
    public String findData1() {
        try {
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            this.itemBackseatTemp = itemBackseatBLL.findData(this.itemBackseat.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-backseat-get")
    public String findData2() {
        try {
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            this.itemBackseatTemp = itemBackseatBLL.findData(this.itemBackseat.getCode(),this.itemBackseat.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-backseat-authority")
    public String itemBackseatAuthority(){
        try{
            
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBackseatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBackseatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBackseatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-backseat-search")
    public String search() {
        try {
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            
            ListPaging <ItemBackseat> listPaging = itemBackseatBLL.search(paging, searchItemBackseat.getCode(), searchItemBackseat.getName(), searchItemBackseatActiveStatus);
            
            listItemBackseat = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-backseat-save")
    public String save() {
        try {
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            
          itemBackseat.setInActiveDate(commonFunction.setDateTime(itemBackseatTemp.getInActiveDateTemp()));
         itemBackseat.setCreatedDate(commonFunction.setDateTime(itemBackseatTemp.getCreatedDateTemp()));
            
            if(itemBackseatBLL.isExist(this.itemBackseat.getCode())){
                this.errorMessage = "CODE "+this.itemBackseat.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBackseatBLL.save(this.itemBackseat);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBackseat.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-backseat-update")
    public String update() {
        try {
            ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            itemBackseat.setInActiveDate(commonFunction.setDateTime(itemBackseatTemp.getInActiveDateTemp()));
            itemBackseat.setCreatedDate(commonFunction.setDateTime(itemBackseatTemp.getCreatedDateTemp()));
            itemBackseatBLL.update(this.itemBackseat);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBackseat.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-backseat-delete")
    public String delete() {
        try {
           ItemBackseatBLL itemBackseatBLL = new ItemBackseatBLL(hbmSession);
            itemBackseatBLL.delete(this.itemBackseat.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBackseat.getCode();
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

    public ItemBackseat getItemBackseat() {
        return itemBackseat;
    }

    public void setItemBackseat(ItemBackseat itemBackseat) {
        this.itemBackseat = itemBackseat;
    }

    public ItemBackseatTemp getItemBackseatTemp() {
        return itemBackseatTemp;
    }

    public void setItemBackseatTemp(ItemBackseatTemp itemBackseatTemp) {
        this.itemBackseatTemp = itemBackseatTemp;
    }

    public List<ItemBackseatTemp> getListItemBackseatTemp() {
        return listItemBackseatTemp;
    }

    public void setListItemBackseatTemp(List<ItemBackseatTemp> listItemBackseatTemp) {
        this.listItemBackseatTemp = listItemBackseatTemp;
    }

    public String getItemBackseatSearchCode() {
        return itemBackseatSearchCode;
    }

    public void setItemBackseatSearchCode(String itemBackseatSearchCode) {
        this.itemBackseatSearchCode = itemBackseatSearchCode;
    }

    public String getItemBackseatSearchName() {
        return itemBackseatSearchName;
    }

    public void setItemBackseatSearchName(String itemBackseatSearchName) {
        this.itemBackseatSearchName = itemBackseatSearchName;
    }

    public String getItemBackseatSearchActiveStatus() {
        return itemBackseatSearchActiveStatus;
    }

    public void setItemBackseatSearchActiveStatus(String itemBackseatSearchActiveStatus) {
        this.itemBackseatSearchActiveStatus = itemBackseatSearchActiveStatus;
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

    public ItemBackseat getSearchItemBackseat() {
        return searchItemBackseat;
    }

    public void setSearchItemBackseat(ItemBackseat searchItemBackseat) {
        this.searchItemBackseat = searchItemBackseat;
    }

    public EnumTriState.Enum_TriState getSearchItemBackseatActiveStatus() {
        return searchItemBackseatActiveStatus;
    }

    public void setSearchItemBackseatActiveStatus(EnumTriState.Enum_TriState searchItemBackseatActiveStatus) {
        this.searchItemBackseatActiveStatus = searchItemBackseatActiveStatus;
    }

    public List<ItemBackseat> getListItemBackseat() {
        return listItemBackseat;
    }

    public void setListItemBackseat(List<ItemBackseat> listItemBackseat) {
        this.listItemBackseat = listItemBackseat;
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
