/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.WarehouseTransferInBLL;
import com.inkombizz.inventory.model.WarehouseTransferIn;
import com.inkombizz.inventory.model.WarehouseTransferInItemDetail;
import com.inkombizz.inventory.model.WarehouseTransferInItemDetailTemp;
import com.inkombizz.inventory.model.WarehouseTransferInTemp;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author egie
 */
@Result(type = "json")
public class WarehouseTransferInJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private WarehouseTransferIn warehouseTransferIn;
    private List<WarehouseTransferIn> listWarehouseTransferIn;
    private List<WarehouseTransferInTemp> listWarehouseTransferInTemp;
    
    private WarehouseTransferInItemDetail warehouseTransferInItemDetail;
    private List<WarehouseTransferInItemDetail> listWarehouseTransferInItemDetail;
    private List<WarehouseTransferInItemDetailTemp> listWarehouseTransferInItemDetailTemp;
    
    private String listWarehouseTransferInItemDetailJSON;
        
    private String warehouseTransferInSearchCode="";
    private String warehouseTransferInSearchWarehouseCode="";
    private String warehouseTransferInSearchWarehouseName="";
    private String warehouseTransferInSearchRefNo="";
    private String warehouseTransferInSearchRemark="";
    
    Date warehouseTransferInSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date warehouseTransferInSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
        
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-in-data")
    public String findData() {
        try {
            WarehouseTransferInBLL warehouseTransferInBLL = new WarehouseTransferInBLL(hbmSession);
            
            ListPaging<WarehouseTransferInTemp> listPaging = warehouseTransferInBLL.findData(paging,warehouseTransferInSearchFirstDate,warehouseTransferInSearchLastDate,
                    warehouseTransferInSearchCode,warehouseTransferInSearchWarehouseCode,warehouseTransferInSearchWarehouseName,warehouseTransferInSearchRefNo,warehouseTransferInSearchRemark);

            listWarehouseTransferInTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("warehouse-transfer-in-item-detail-data")
    public String findDataDetailDestination(){
        try {
            
            WarehouseTransferInBLL warehouseTransferInBLL = new WarehouseTransferInBLL(hbmSession);
            List<WarehouseTransferInItemDetailTemp> list = warehouseTransferInBLL.findDataDetailDestination(this.warehouseTransferIn.getCode());

            listWarehouseTransferInItemDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-in-save")
    public String save() {
        try {
            WarehouseTransferInBLL warehouseTransferInBLL = new WarehouseTransferInBLL(hbmSession);

            Gson gson = new Gson();
            gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();

            this.listWarehouseTransferInItemDetail = gson.fromJson(this.listWarehouseTransferInItemDetailJSON, new TypeToken<List<WarehouseTransferInItemDetail>>(){}.getType());

            warehouseTransferIn.setTransactionDate(DateUtils.newDateTime(warehouseTransferIn.getTransactionDate(),true));
            warehouseTransferIn.setCreatedDate(DateUtils.newDateTime(warehouseTransferIn.getCreatedDate(),false));

            warehouseTransferInBLL.save(warehouseTransferIn,listWarehouseTransferInItemDetail);
            this.message = "SAVE DATA SUCCESS.<br/>WHM Code : " + this.warehouseTransferIn.getCode();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-in-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            WarehouseTransferInBLL warehouseTransferInBLL = new WarehouseTransferInBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            warehouseTransferInBLL.delete(this.warehouseTransferIn.getCode());
            this.message = _Messg + " DATA SUCCESS.<br/>WHM Code : " + this.warehouseTransferIn.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public WarehouseTransferIn getWarehouseTransferIn() {
        return warehouseTransferIn;
    }

    public void setWarehouseTransferIn(WarehouseTransferIn warehouseTransferIn) {
        this.warehouseTransferIn = warehouseTransferIn;
    }

    public List<WarehouseTransferIn> getListWarehouseTransferIn() {
        return listWarehouseTransferIn;
    }

    public void setListWarehouseTransferIn(List<WarehouseTransferIn> listWarehouseTransferIn) {
        this.listWarehouseTransferIn = listWarehouseTransferIn;
    }

    public List<WarehouseTransferInTemp> getListWarehouseTransferInTemp() {
        return listWarehouseTransferInTemp;
    }

    public void setListWarehouseTransferInTemp(List<WarehouseTransferInTemp> listWarehouseTransferInTemp) {
        this.listWarehouseTransferInTemp = listWarehouseTransferInTemp;
    }

    public WarehouseTransferInItemDetail getWarehouseTransferInItemDetail() {
        return warehouseTransferInItemDetail;
    }

    public void setWarehouseTransferInItemDetail(WarehouseTransferInItemDetail warehouseTransferInItemDetail) {
        this.warehouseTransferInItemDetail = warehouseTransferInItemDetail;
    }

    public List<WarehouseTransferInItemDetail> getListWarehouseTransferInItemDetail() {
        return listWarehouseTransferInItemDetail;
    }

    public void setListWarehouseTransferInItemDetail(List<WarehouseTransferInItemDetail> listWarehouseTransferInItemDetail) {
        this.listWarehouseTransferInItemDetail = listWarehouseTransferInItemDetail;
    }

    public List<WarehouseTransferInItemDetailTemp> getListWarehouseTransferInItemDetailTemp() {
        return listWarehouseTransferInItemDetailTemp;
    }

    public void setListWarehouseTransferInItemDetailTemp(List<WarehouseTransferInItemDetailTemp> listWarehouseTransferInItemDetailTemp) {
        this.listWarehouseTransferInItemDetailTemp = listWarehouseTransferInItemDetailTemp;
    }

    public String getListWarehouseTransferInItemDetailJSON() {
        return listWarehouseTransferInItemDetailJSON;
    }

    public void setListWarehouseTransferInItemDetailJSON(String listWarehouseTransferInItemDetailJSON) {
        this.listWarehouseTransferInItemDetailJSON = listWarehouseTransferInItemDetailJSON;
    }

    public String getWarehouseTransferInSearchCode() {
        return warehouseTransferInSearchCode;
    }

    public void setWarehouseTransferInSearchCode(String warehouseTransferInSearchCode) {
        this.warehouseTransferInSearchCode = warehouseTransferInSearchCode;
    }

    public String getWarehouseTransferInSearchWarehouseCode() {
        return warehouseTransferInSearchWarehouseCode;
    }

    public void setWarehouseTransferInSearchWarehouseCode(String warehouseTransferInSearchWarehouseCode) {
        this.warehouseTransferInSearchWarehouseCode = warehouseTransferInSearchWarehouseCode;
    }

    public String getWarehouseTransferInSearchWarehouseName() {
        return warehouseTransferInSearchWarehouseName;
    }

    public void setWarehouseTransferInSearchWarehouseName(String warehouseTransferInSearchWarehouseName) {
        this.warehouseTransferInSearchWarehouseName = warehouseTransferInSearchWarehouseName;
    }

    public String getWarehouseTransferInSearchRefNo() {
        return warehouseTransferInSearchRefNo;
    }

    public void setWarehouseTransferInSearchRefNo(String warehouseTransferInSearchRefNo) {
        this.warehouseTransferInSearchRefNo = warehouseTransferInSearchRefNo;
    }

    public String getWarehouseTransferInSearchRemark() {
        return warehouseTransferInSearchRemark;
    }

    public void setWarehouseTransferInSearchRemark(String warehouseTransferInSearchRemark) {
        this.warehouseTransferInSearchRemark = warehouseTransferInSearchRemark;
    }

    public Date getWarehouseTransferInSearchFirstDate() {
        return warehouseTransferInSearchFirstDate;
    }

    public void setWarehouseTransferInSearchFirstDate(Date warehouseTransferInSearchFirstDate) {
        this.warehouseTransferInSearchFirstDate = warehouseTransferInSearchFirstDate;
    }

    public Date getWarehouseTransferInSearchLastDate() {
        return warehouseTransferInSearchLastDate;
    }

    public void setWarehouseTransferInSearchLastDate(Date warehouseTransferInSearchLastDate) {
        this.warehouseTransferInSearchLastDate = warehouseTransferInSearchLastDate;
    }
}
