
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

import com.inkombizz.master.bll.ItemBallBLL;
import com.inkombizz.master.bll.ItemBallBLL;
import com.inkombizz.master.model.ItemBall;
import com.inkombizz.master.model.ItemBallTemp;
import com.inkombizz.master.model.ItemBall;
import com.inkombizz.master.model.ItemBall;
import com.inkombizz.master.model.ItemBall;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBallJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBall itemBall;
    private ItemBallTemp itemBallTemp;
    private List <ItemBallTemp> listItemBallTemp;
    private ItemBall searchItemBall = new ItemBall();
    private List <ItemBall> listItemBall;
    private String itemBallSearchCode = "";
    private String itemBallSearchName = "";
    private String itemBallSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemBallActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-ball-data")
    public String findData() {
        try {
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            ListPaging <ItemBallTemp> listPaging = itemBallBLL.findData(itemBallSearchCode,itemBallSearchName,itemBallSearchActiveStatus,paging);
            
            listItemBallTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-ball-get-data")
    public String findData1() {
        try {
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            this.itemBallTemp = itemBallBLL.findData(this.itemBall.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-ball-get")
    public String findData2() {
        try {
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            this.itemBallTemp = itemBallBLL.findData(this.itemBall.getCode(),this.itemBall.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-ball-authority")
    public String itemBallAuthority(){
        try{
            
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBallBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBallBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBallBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-ball-search")
    public String search() {
        try {
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            
            ListPaging <ItemBall> listPaging = itemBallBLL.search(paging, searchItemBall.getCode(), searchItemBall.getName(), searchItemBallActiveStatus);
            
            listItemBall = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-ball-save")
    public String save() {
        try {
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            
          itemBall.setInActiveDate(commonFunction.setDateTime(itemBallTemp.getInActiveDateTemp()));
         itemBall.setCreatedDate(commonFunction.setDateTime(itemBallTemp.getCreatedDateTemp()));
            
            if(itemBallBLL.isExist(this.itemBall.getCode())){
                this.errorMessage = "CODE "+this.itemBall.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBallBLL.save(this.itemBall);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBall.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-ball-update")
    public String update() {
        try {
            ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            itemBall.setInActiveDate(commonFunction.setDateTime(itemBallTemp.getInActiveDateTemp()));
            itemBall.setCreatedDate(commonFunction.setDateTime(itemBallTemp.getCreatedDateTemp()));
            itemBallBLL.update(this.itemBall);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBall.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-ball-delete")
    public String delete() {
        try {
           ItemBallBLL itemBallBLL = new ItemBallBLL(hbmSession);
            itemBallBLL.delete(this.itemBall.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBall.getCode();
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

    public ItemBall getItemBall() {
        return itemBall;
    }

    public void setItemBall(ItemBall itemBall) {
        this.itemBall = itemBall;
    }

    public ItemBallTemp getItemBallTemp() {
        return itemBallTemp;
    }

    public void setItemBallTemp(ItemBallTemp itemBallTemp) {
        this.itemBallTemp = itemBallTemp;
    }

    public List<ItemBallTemp> getListItemBallTemp() {
        return listItemBallTemp;
    }

    public void setListItemBallTemp(List<ItemBallTemp> listItemBallTemp) {
        this.listItemBallTemp = listItemBallTemp;
    }

    public String getItemBallSearchCode() {
        return itemBallSearchCode;
    }

    public void setItemBallSearchCode(String itemBallSearchCode) {
        this.itemBallSearchCode = itemBallSearchCode;
    }

    public String getItemBallSearchName() {
        return itemBallSearchName;
    }

    public void setItemBallSearchName(String itemBallSearchName) {
        this.itemBallSearchName = itemBallSearchName;
    }

    public String getItemBallSearchActiveStatus() {
        return itemBallSearchActiveStatus;
    }

    public void setItemBallSearchActiveStatus(String itemBallSearchActiveStatus) {
        this.itemBallSearchActiveStatus = itemBallSearchActiveStatus;
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

    public ItemBall getSearchItemBall() {
        return searchItemBall;
    }

    public void setSearchItemBall(ItemBall searchItemBall) {
        this.searchItemBall = searchItemBall;
    }

    public EnumTriState.Enum_TriState getSearchItemBallActiveStatus() {
        return searchItemBallActiveStatus;
    }

    public void setSearchItemBallActiveStatus(EnumTriState.Enum_TriState searchItemBallActiveStatus) {
        this.searchItemBallActiveStatus = searchItemBallActiveStatus;
    }

    public List<ItemBall> getListItemBall() {
        return listItemBall;
    }

    public void setListItemBall(List<ItemBall> listItemBall) {
        this.listItemBall = listItemBall;
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
