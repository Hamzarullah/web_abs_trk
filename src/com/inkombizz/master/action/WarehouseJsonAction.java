
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

import com.inkombizz.master.bll.WarehouseBLL;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.master.model.WarehouseTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class WarehouseJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Warehouse warehouse;
    private WarehouseTemp warehouseTemp;
    private List <WarehouseTemp> listWarehouseTemp;
    private String warehouseSearchCode = "";
    private String warehouseSearchName = "";
    private String warehouseSearchActiveStatus="true";
    private String actionAuthority="";
    private String warehouseCode="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("warehouse-data")
    public String findData() {
        try {
            WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            ListPaging <WarehouseTemp> listPaging = warehouseBLL.findData(warehouseSearchCode,warehouseSearchName,warehouseSearchActiveStatus,paging);
            
            listWarehouseTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-get-data")
    public String findData1() {
        try {
            WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            this.warehouseTemp = warehouseBLL.findData(this.warehouse.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-get")
    public String findData2() {
        try {
            WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            this.warehouseTemp = warehouseBLL.findData(warehouseCode,this.warehouse.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-authority")
    public String warehouseAuthority(){
        try{
            
            WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(warehouseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(warehouseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(warehouseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("warehouse-save")
    public String save() {
        try {
            WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            
            warehouse.setInActiveDate(commonFunction.setDateTime(warehouseTemp.getInActiveDateTemp()));
            warehouse.setCreatedDate(commonFunction.setDateTime(warehouseTemp.getCreatedDateTemp()));
            
            if(warehouseBLL.isExist(this.warehouse.getCode())){
                this.errorMessage = "CODE "+this.warehouse.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                warehouseBLL.save(this.warehouse);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.warehouse.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-update")
    public String update() {
        try {
            WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            warehouse.setInActiveDate(commonFunction.setDateTime(warehouseTemp.getInActiveDateTemp()));
            warehouse.setCreatedDate(commonFunction.setDateTime(warehouseTemp.getCreatedDateTemp()));
            warehouseBLL.update(this.warehouse);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.warehouse.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-delete")
    public String delete() {
        try {
           WarehouseBLL warehouseBLL = new WarehouseBLL(hbmSession);
            warehouseBLL.delete(this.warehouse.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.warehouse.getCode();
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

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public WarehouseTemp getWarehouseTemp() {
        return warehouseTemp;
    }

    public void setWarehouseTemp(WarehouseTemp warehouseTemp) {
        this.warehouseTemp = warehouseTemp;
    }

    public List<WarehouseTemp> getListWarehouseTemp() {
        return listWarehouseTemp;
    }

    public void setListWarehouseTemp(List<WarehouseTemp> listWarehouseTemp) {
        this.listWarehouseTemp = listWarehouseTemp;
    }

    public String getWarehouseSearchCode() {
        return warehouseSearchCode;
    }

    public void setWarehouseSearchCode(String warehouseSearchCode) {
        this.warehouseSearchCode = warehouseSearchCode;
    }

    public String getWarehouseSearchName() {
        return warehouseSearchName;
    }

    public void setWarehouseSearchName(String warehouseSearchName) {
        this.warehouseSearchName = warehouseSearchName;
    }

    public String getWarehouseSearchActiveStatus() {
        return warehouseSearchActiveStatus;
    }

    public void setWarehouseSearchActiveStatus(String warehouseSearchActiveStatus) {
        this.warehouseSearchActiveStatus = warehouseSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
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
