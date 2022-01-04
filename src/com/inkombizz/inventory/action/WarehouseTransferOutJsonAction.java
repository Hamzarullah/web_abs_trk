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
import com.inkombizz.inventory.bll.WarehouseTransferOutBLL;
import com.inkombizz.inventory.model.WarehouseTransferOut;
import com.inkombizz.inventory.model.WarehouseTransferOutItemDetail;
import com.inkombizz.inventory.model.WarehouseTransferOutItemDetailTemp;
import com.inkombizz.inventory.model.WarehouseTransferOutTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
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
public class WarehouseTransferOutJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private WarehouseTransferOut warehouseTransferOut;
    private List<WarehouseTransferOut> listWarehouseTransferOut;
    private List<WarehouseTransferOutTemp> listWarehouseTransferOutTemp;
    
    private WarehouseTransferOutItemDetail warehouseTransferOutItemDetail;
    private List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail;
    private List<WarehouseTransferOutItemDetailTemp> listWarehouseTransferOutItemDetailTemp;
    
    private String listWarehouseTransferOutItemDetailJSON;
        
    private String warehouseTransferOutSearchCode="";
    private String warehouseTransferOutSearchWarehouseCode="";
    private String warehouseTransferOutSearchWarehouseName="";
    private String warehouseTransferOutSearchRefNo="";
    private String warehouseTransferOutSearchRemark="";
    
    Date warehouseTransferOutSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date warehouseTransferOutSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
        
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-out-data")
    public String findData() {
        try {
            WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);
            
            ListPaging<WarehouseTransferOutTemp> listPaging = warehouseTransferOutBLL.findData(paging,warehouseTransferOutSearchFirstDate,warehouseTransferOutSearchLastDate,warehouseTransferOutSearchCode,warehouseTransferOutSearchWarehouseCode,warehouseTransferOutSearchWarehouseName,warehouseTransferOutSearchRefNo,warehouseTransferOutSearchRemark);

            listWarehouseTransferOutTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-out-item-detail-data")
    public String findDataDetailSource(){
        try {
            
            WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);
            List<WarehouseTransferOutItemDetailTemp> list = warehouseTransferOutBLL.findDataDetailSource(this.warehouseTransferOut.getCode());

            listWarehouseTransferOutItemDetailTemp = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-out-save")
    public String save() {
        try {
                WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);

                Gson gson = new Gson();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listWarehouseTransferOutItemDetail = gson.fromJson(this.listWarehouseTransferOutItemDetailJSON, new TypeToken<List<WarehouseTransferOutItemDetail>>(){}.getType());

                warehouseTransferOut.setTransactionDate(DateUtils.newDateTime(warehouseTransferOut.getTransactionDate(),true));
                warehouseTransferOut.setCreatedDate(DateUtils.newDateTime(warehouseTransferOut.getCreatedDate(),false));
                
                if(warehouseTransferOutBLL.isExist(this.warehouseTransferOut.getCode())) {
                    warehouseTransferOutBLL.update(warehouseTransferOut,listWarehouseTransferOutItemDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/>WHM Code : " + this.warehouseTransferOut.getCode(); 
                }else{
                    warehouseTransferOutBLL.save(warehouseTransferOut,listWarehouseTransferOutItemDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>WHM Code : " + this.warehouseTransferOut.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-out-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            warehouseTransferOutBLL.delete(this.warehouseTransferOut.getCode());
            this.message = _Messg + " DATA SUCCESS.<br/>WHM Code : " + this.warehouseTransferOut.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("warehouse-transfer-out-data-for-search")
    public String searchData() {
        try {
            WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);
            
            ListPaging<WarehouseTransferOutTemp> listPaging = warehouseTransferOutBLL.searchCountDatasearchDataWHTO(paging,warehouseTransferOutSearchFirstDate,warehouseTransferOutSearchLastDate,warehouseTransferOutSearchCode,warehouseTransferOutSearchWarehouseCode,warehouseTransferOutSearchWarehouseName,warehouseTransferOutSearchRefNo,warehouseTransferOutSearchRemark);

            listWarehouseTransferOutTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
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

    public WarehouseTransferOut getWarehouseTransferOut() {
        return warehouseTransferOut;
    }

    public void setWarehouseTransferOut(WarehouseTransferOut warehouseTransferOut) {
        this.warehouseTransferOut = warehouseTransferOut;
    }

    public List<WarehouseTransferOut> getListWarehouseTransferOut() {
        return listWarehouseTransferOut;
    }

    public void setListWarehouseTransferOut(List<WarehouseTransferOut> listWarehouseTransferOut) {
        this.listWarehouseTransferOut = listWarehouseTransferOut;
    }

    public List<WarehouseTransferOutTemp> getListWarehouseTransferOutTemp() {
        return listWarehouseTransferOutTemp;
    }

    public void setListWarehouseTransferOutTemp(List<WarehouseTransferOutTemp> listWarehouseTransferOutTemp) {
        this.listWarehouseTransferOutTemp = listWarehouseTransferOutTemp;
    }

    public WarehouseTransferOutItemDetail getWarehouseTransferOutItemDetail() {
        return warehouseTransferOutItemDetail;
    }

    public void setWarehouseTransferOutItemDetail(WarehouseTransferOutItemDetail warehouseTransferOutItemDetail) {
        this.warehouseTransferOutItemDetail = warehouseTransferOutItemDetail;
    }

    public List<WarehouseTransferOutItemDetail> getListWarehouseTransferOutItemDetail() {
        return listWarehouseTransferOutItemDetail;
    }

    public void setListWarehouseTransferOutItemDetail(List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail) {
        this.listWarehouseTransferOutItemDetail = listWarehouseTransferOutItemDetail;
    }

    public List<WarehouseTransferOutItemDetailTemp> getListWarehouseTransferOutItemDetailTemp() {
        return listWarehouseTransferOutItemDetailTemp;
    }

    public void setListWarehouseTransferOutItemDetailTemp(List<WarehouseTransferOutItemDetailTemp> listWarehouseTransferOutItemDetailTemp) {
        this.listWarehouseTransferOutItemDetailTemp = listWarehouseTransferOutItemDetailTemp;
    }

    public String getListWarehouseTransferOutItemDetailJSON() {
        return listWarehouseTransferOutItemDetailJSON;
    }

    public void setListWarehouseTransferOutItemDetailJSON(String listWarehouseTransferOutItemDetailJSON) {
        this.listWarehouseTransferOutItemDetailJSON = listWarehouseTransferOutItemDetailJSON;
    }

    public String getWarehouseTransferOutSearchCode() {
        return warehouseTransferOutSearchCode;
    }

    public void setWarehouseTransferOutSearchCode(String warehouseTransferOutSearchCode) {
        this.warehouseTransferOutSearchCode = warehouseTransferOutSearchCode;
    }

    public String getWarehouseTransferOutSearchWarehouseCode() {
        return warehouseTransferOutSearchWarehouseCode;
    }

    public void setWarehouseTransferOutSearchWarehouseCode(String warehouseTransferOutSearchWarehouseCode) {
        this.warehouseTransferOutSearchWarehouseCode = warehouseTransferOutSearchWarehouseCode;
    }

    public String getWarehouseTransferOutSearchWarehouseName() {
        return warehouseTransferOutSearchWarehouseName;
    }

    public void setWarehouseTransferOutSearchWarehouseName(String warehouseTransferOutSearchWarehouseName) {
        this.warehouseTransferOutSearchWarehouseName = warehouseTransferOutSearchWarehouseName;
    }

    public String getWarehouseTransferOutSearchRefNo() {
        return warehouseTransferOutSearchRefNo;
    }

    public void setWarehouseTransferOutSearchRefNo(String warehouseTransferOutSearchRefNo) {
        this.warehouseTransferOutSearchRefNo = warehouseTransferOutSearchRefNo;
    }

    public String getWarehouseTransferOutSearchRemark() {
        return warehouseTransferOutSearchRemark;
    }

    public void setWarehouseTransferOutSearchRemark(String warehouseTransferOutSearchRemark) {
        this.warehouseTransferOutSearchRemark = warehouseTransferOutSearchRemark;
    }

    public Date getWarehouseTransferOutSearchFirstDate() {
        return warehouseTransferOutSearchFirstDate;
    }

    public void setWarehouseTransferOutSearchFirstDate(Date warehouseTransferOutSearchFirstDate) {
        this.warehouseTransferOutSearchFirstDate = warehouseTransferOutSearchFirstDate;
    }

    public Date getWarehouseTransferOutSearchLastDate() {
        return warehouseTransferOutSearchLastDate;
    }

    public void setWarehouseTransferOutSearchLastDate(Date warehouseTransferOutSearchLastDate) {
        this.warehouseTransferOutSearchLastDate = warehouseTransferOutSearchLastDate;
    }
}
