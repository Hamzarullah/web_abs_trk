/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ItemMaterialRequestBLL;
import com.inkombizz.ppic.model.ItemMaterialRequest;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemProcessedPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestPartDetail;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import static com.opensymphony.xwork2.Action.SUCCESS;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author Sukha
 */

@Result(type = "json")
public class ItemMaterialRequestJsonAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private ItemMaterialRequest itemMaterialRequest = new ItemMaterialRequest();
    private ItemMaterialRequest itemMaterialRequestApproval = new ItemMaterialRequest();
    private ItemMaterialRequest itemMaterialRequestClosing = new ItemMaterialRequest();
    
    private EnumActivity.ENUM_Activity enumItemMaterialRequestActivity;
    
    private List<ItemMaterialRequest> listItemMaterialRequest;
    private List<ItemMaterialRequestItemProcessedPartDetail> listItemMaterialRequestItemProcessedPartDetail;
    private List<ItemMaterialRequestItemBookingDetail> listItemMaterialRequestItemBookingDetail;
    private List<ItemMaterialRequestItemBookingPartDetail> listItemMaterialRequestItemBookingPartDetail;
    private List<ItemMaterialRequestItemRequestDetail> listItemMaterialRequestItemRequestDetail;
    private List<ItemMaterialRequestItemRequestPartDetail> listItemMaterialRequestItemRequestPartDetail;
    
    private String listItemMaterialRequestItemProcessedPartDetailJSON;
    private String listItemMaterialRequestItemBookingDetailJSON;
    private String listItemMaterialRequestItemBookingPartDetailJSON;
    private String listItemMaterialRequestItemRequestDetailJSON;
    private String listItemMaterialRequestItemRequestPartDetailJSON;
    
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-data")
    public String findData() {
        try {
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
            
            ListPaging<ItemMaterialRequest> listPaging = itemMaterialRequestBLL.findData(paging,itemMaterialRequest);

            listItemMaterialRequest = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-approval-data")
    public String findDataApproval() {
        try {
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
            
            ListPaging<ItemMaterialRequest> listPaging = itemMaterialRequestBLL.findDataApproval(paging,itemMaterialRequestApproval);

            listItemMaterialRequest = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-closing-data")
    public String findDataClosing() {
        try {
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
            
            ListPaging<ItemMaterialRequest> listPaging = itemMaterialRequestBLL.findDataClosing(paging,itemMaterialRequestClosing);

            listItemMaterialRequest = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-processed-part-data")
    public String findProcessedPartDetail(){
        try {
            
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
            List<ItemMaterialRequestItemProcessedPartDetail> list = itemMaterialRequestBLL.findProcessedPartDetail(this.itemMaterialRequest.getCode());

            listItemMaterialRequestItemProcessedPartDetail = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-booking-detail")
    public String findItemBookingDetail(){
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);

            List<ItemMaterialRequestItemBookingDetail> list = itemMaterialRequestBLL.findItemBookingDetail(this.itemMaterialRequest.getCode());

            listItemMaterialRequestItemBookingDetail = list;
            return SUCCESS;
        }catch (Exception e){
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-booking-part-detail")
    public String findItemBookingPartDetail(){
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);

            List<ItemMaterialRequestItemBookingPartDetail> list = itemMaterialRequestBLL.findItemBookingPartDetail(this.itemMaterialRequest.getCode());

            listItemMaterialRequestItemBookingPartDetail = list;
            return SUCCESS;
        }catch (Exception e){
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-request-detail")
    public String findItemRequestDetail(){
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);

            List<ItemMaterialRequestItemRequestDetail> list = itemMaterialRequestBLL.findItemRequestDetail(this.itemMaterialRequest.getCode());

            listItemMaterialRequestItemRequestDetail = list;
            return SUCCESS;
        }catch (Exception e){
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-request-part-detail")
    public String findItemRequestPartDetail(){
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);

            List<ItemMaterialRequestItemRequestPartDetail> list = itemMaterialRequestBLL.findItemRequestPartDetail(this.itemMaterialRequest.getCode());

            listItemMaterialRequestItemRequestPartDetail = list;
            return SUCCESS;
        }catch (Exception e){
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-save")
    public String save() {
        try {
                ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);

                Gson gson = new Gson();
                Gson hson = new Gson();
                Gson ison = new Gson();
                Gson json = new Gson();
                Gson kson = new Gson();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listItemMaterialRequestItemProcessedPartDetail = gson.fromJson(this.listItemMaterialRequestItemProcessedPartDetailJSON, new TypeToken<List<ItemMaterialRequestItemProcessedPartDetail>>(){}.getType());
                this.listItemMaterialRequestItemBookingDetail = hson.fromJson(this.listItemMaterialRequestItemBookingDetailJSON, new TypeToken<List<ItemMaterialRequestItemBookingDetail>>(){}.getType());
                this.listItemMaterialRequestItemBookingPartDetail = ison.fromJson(this.listItemMaterialRequestItemBookingPartDetailJSON, new TypeToken<List<ItemMaterialRequestItemBookingPartDetail>>(){}.getType());
                this.listItemMaterialRequestItemRequestDetail = json.fromJson(this.listItemMaterialRequestItemRequestDetailJSON, new TypeToken<List<ItemMaterialRequestItemRequestDetail>>(){}.getType());
                this.listItemMaterialRequestItemRequestPartDetail = kson.fromJson(this.listItemMaterialRequestItemRequestPartDetailJSON, new TypeToken<List<ItemMaterialRequestItemRequestPartDetail>>(){}.getType());
                                
                if(enumItemMaterialRequestActivity.equals(EnumActivity.ENUM_Activity.UPDATE)) {
//                    itemMaterialRequestBLL.update(enumItemMaterialRequestActivity, itemMaterialRequest, listItemMaterialRequestItemProcessedPartDetail, listItemMaterialRequestItemBookingDetail,
//                                                  listItemMaterialRequestItemBookingPartDetail, listItemMaterialRequestItemRequestDetail, listItemMaterialRequestItemRequestPartDetail);
//                    this.message = "UPDATE DATA SUCCESS.<br/>IMR No : " + this.itemMaterialRequest.getCode(); 
                }else if(enumItemMaterialRequestActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                    itemMaterialRequestBLL.save(enumItemMaterialRequestActivity, itemMaterialRequest, listItemMaterialRequestItemProcessedPartDetail, listItemMaterialRequestItemBookingDetail,
                                                  listItemMaterialRequestItemBookingPartDetail, listItemMaterialRequestItemRequestDetail, listItemMaterialRequestItemRequestPartDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>IMR No : " + this.itemMaterialRequest.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-delete")
    public String delete(){
        String _messg = "";
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
            itemMaterialRequestBLL.delete(itemMaterialRequest);
            
            this.message = _messg + "DATA SUCCESS.<br/> IMR No : " + this.itemMaterialRequest.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("item-material-request-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
            
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
        
            itemMaterialRequestBLL.approval(itemMaterialRequestApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>IMR No : " + this.itemMaterialRequestApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-request-closing-save")
    public String saveClosing(){
        String _Messg = "";
        try {
            
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
        
            itemMaterialRequestBLL.approval(itemMaterialRequestClosing);

            this.message = _Messg + " DATA SUCCESS.<br/>IMR No : " + this.itemMaterialRequestClosing.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    private boolean error = false;
    private String errorMessage = "";
    private String message = "";

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ItemMaterialRequest getItemMaterialRequest() {
        return itemMaterialRequest;
    }

    public void setItemMaterialRequest(ItemMaterialRequest itemMaterialRequest) {
        this.itemMaterialRequest = itemMaterialRequest;
    }

    public List<ItemMaterialRequestItemProcessedPartDetail> getListItemMaterialRequestItemProcessedPartDetail() {
        return listItemMaterialRequestItemProcessedPartDetail;
    }

    public void setListItemMaterialRequestItemProcessedPartDetail(List<ItemMaterialRequestItemProcessedPartDetail> listItemMaterialRequestItemProcessedPartDetail) {
        this.listItemMaterialRequestItemProcessedPartDetail = listItemMaterialRequestItemProcessedPartDetail;
    }

    public List<ItemMaterialRequestItemBookingDetail> getListItemMaterialRequestItemBookingDetail() {
        return listItemMaterialRequestItemBookingDetail;
    }

    public void setListItemMaterialRequestItemBookingDetail(List<ItemMaterialRequestItemBookingDetail> listItemMaterialRequestItemBookingDetail) {
        this.listItemMaterialRequestItemBookingDetail = listItemMaterialRequestItemBookingDetail;
    }

    public List<ItemMaterialRequestItemBookingPartDetail> getListItemMaterialRequestItemBookingPartDetail() {
        return listItemMaterialRequestItemBookingPartDetail;
    }

    public void setListItemMaterialRequestItemBookingPartDetail(List<ItemMaterialRequestItemBookingPartDetail> listItemMaterialRequestItemBookingPartDetail) {
        this.listItemMaterialRequestItemBookingPartDetail = listItemMaterialRequestItemBookingPartDetail;
    }

    public List<ItemMaterialRequestItemRequestDetail> getListItemMaterialRequestItemRequestDetail() {
        return listItemMaterialRequestItemRequestDetail;
    }

    public void setListItemMaterialRequestItemRequestDetail(List<ItemMaterialRequestItemRequestDetail> listItemMaterialRequestItemRequestDetail) {
        this.listItemMaterialRequestItemRequestDetail = listItemMaterialRequestItemRequestDetail;
    }

    public List<ItemMaterialRequestItemRequestPartDetail> getListItemMaterialRequestItemRequestPartDetail() {
        return listItemMaterialRequestItemRequestPartDetail;
    }

    public void setListItemMaterialRequestItemRequestPartDetail(List<ItemMaterialRequestItemRequestPartDetail> listItemMaterialRequestItemRequestPartDetail) {
        this.listItemMaterialRequestItemRequestPartDetail = listItemMaterialRequestItemRequestPartDetail;
    }

    public String getListItemMaterialRequestItemProcessedPartDetailJSON() {
        return listItemMaterialRequestItemProcessedPartDetailJSON;
    }

    public void setListItemMaterialRequestItemProcessedPartDetailJSON(String listItemMaterialRequestItemProcessedPartDetailJSON) {
        this.listItemMaterialRequestItemProcessedPartDetailJSON = listItemMaterialRequestItemProcessedPartDetailJSON;
    }

    public String getListItemMaterialRequestItemBookingDetailJSON() {
        return listItemMaterialRequestItemBookingDetailJSON;
    }

    public void setListItemMaterialRequestItemBookingDetailJSON(String listItemMaterialRequestItemBookingDetailJSON) {
        this.listItemMaterialRequestItemBookingDetailJSON = listItemMaterialRequestItemBookingDetailJSON;
    }

    public String getListItemMaterialRequestItemBookingPartDetailJSON() {
        return listItemMaterialRequestItemBookingPartDetailJSON;
    }

    public void setListItemMaterialRequestItemBookingPartDetailJSON(String listItemMaterialRequestItemBookingPartDetailJSON) {
        this.listItemMaterialRequestItemBookingPartDetailJSON = listItemMaterialRequestItemBookingPartDetailJSON;
    }

    public String getListItemMaterialRequestItemRequestDetailJSON() {
        return listItemMaterialRequestItemRequestDetailJSON;
    }

    public void setListItemMaterialRequestItemRequestDetailJSON(String listItemMaterialRequestItemRequestDetailJSON) {
        this.listItemMaterialRequestItemRequestDetailJSON = listItemMaterialRequestItemRequestDetailJSON;
    }

    public String getListItemMaterialRequestItemRequestPartDetailJSON() {
        return listItemMaterialRequestItemRequestPartDetailJSON;
    }

    public void setListItemMaterialRequestItemRequestPartDetailJSON(String listItemMaterialRequestItemRequestPartDetailJSON) {
        this.listItemMaterialRequestItemRequestPartDetailJSON = listItemMaterialRequestItemRequestPartDetailJSON;
    }

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

    public EnumActivity.ENUM_Activity getEnumItemMaterialRequestActivity() {
        return enumItemMaterialRequestActivity;
    }

    public void setEnumItemMaterialRequestActivity(EnumActivity.ENUM_Activity enumItemMaterialRequestActivity) {
        this.enumItemMaterialRequestActivity = enumItemMaterialRequestActivity;
    }

    public List<ItemMaterialRequest> getListItemMaterialRequest() {
        return listItemMaterialRequest;
    }

    public void setListItemMaterialRequest(List<ItemMaterialRequest> listItemMaterialRequest) {
        this.listItemMaterialRequest = listItemMaterialRequest;
    }

    public ItemMaterialRequest getItemMaterialRequestApproval() {
        return itemMaterialRequestApproval;
    }

    public void setItemMaterialRequestApproval(ItemMaterialRequest itemMaterialRequestApproval) {
        this.itemMaterialRequestApproval = itemMaterialRequestApproval;
    }

    public ItemMaterialRequest getItemMaterialRequestClosing() {
        return itemMaterialRequestClosing;
    }

    public void setItemMaterialRequestClosing(ItemMaterialRequest itemMaterialRequestClosing) {
        this.itemMaterialRequestClosing = itemMaterialRequestClosing;
    }
    
    
    
    
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
