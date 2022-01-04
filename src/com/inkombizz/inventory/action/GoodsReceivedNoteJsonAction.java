/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonConst;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.GoodsReceivedNoteBLL;
import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemDetail;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemSerialNoDetail;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author ikb
 */
@Result(type = "json")
public class GoodsReceivedNoteJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private EnumAuthorizationString.ENUM_AuthorizationString actionAuthority;

    private GoodsReceivedNote goodsReceivedNote=new GoodsReceivedNote(); 
    private GoodsReceivedNote goodsReceivedNoteUpdatePo=new GoodsReceivedNote(); 
    private GoodsReceivedNote goodsReceivedNoteConfirmation=new GoodsReceivedNote(); 
     
    private List<GoodsReceivedNote> listGoodsReceivedNote;
    private List<GoodsReceivedNote> listGoodsReceivedNoteUpdatePo;
    private List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail;
    private List<GoodsReceivedNoteItemSerialNoDetail> listGoodsReceivedNoteSerialNoItemDetail;
    private List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteConfirmationItemDetail;
    private List<GoodsReceivedNoteItemSerialNoDetail> listGoodsReceivedNoteConfirmationSerialNoItemDetail;
    
    private List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteUpdatePoItemDetail;
    private String listGoodsReceivedNoteUpdatePoItemDetailJSON;
    
    private String listGoodsReceivedNoteItemDetailJSON;
    private String listGoodsReceivedNoteSerialNoItemDetailJSON;
    
    private String listGoodsReceivedNoteConfirmationItemDetailJSON;
    private String listGoodsReceivedNoteConfirmationSerialNoItemDetailJSON;
    
    private String purchaseOrderSearchCode="";
    private String vinNo="";
    
    private String poCode = "";
    private String podCode = "";
    private String itemMaterialCode = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    
    @Action("goods-received-note-data")
    public String findData() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            goodsReceivedNote.setConfirmationStatus(EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.ALL));
            ListPaging<GoodsReceivedNote> listPaging = goodsReceivedNoteBLL.findData(paging,goodsReceivedNote);

            listGoodsReceivedNote = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-confirmation-data")
    public String findConfirmationData() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);

            ListPaging<GoodsReceivedNote> listPaging = goodsReceivedNoteBLL.findDataConfirmation(paging,goodsReceivedNoteConfirmation);

            listGoodsReceivedNote = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     
    @Action("goods-received-note-detail-item-detail-data")
    public String findDataGRNItemDetail(){
        try {
            
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            List<GoodsReceivedNoteItemDetail> list = goodsReceivedNoteBLL.findDataGRNItemDetail(this.goodsReceivedNote.getCode());
            
            listGoodsReceivedNoteItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-detail-serial-no-data")
    public String findDataItemSerialNoDetail(){
        try {
            
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            List<GoodsReceivedNoteItemSerialNoDetail> list = goodsReceivedNoteBLL.findDataItemSerialNoDetail(this.goodsReceivedNote.getCode());
            
            listGoodsReceivedNoteSerialNoItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-update-po-data")
    public String findDataGrnUdt() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            ListPaging<GoodsReceivedNote> listPaging = goodsReceivedNoteBLL.findDataGrnUpdt(paging,goodsReceivedNoteUpdatePo);

            listGoodsReceivedNoteUpdatePo = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     
    @Action("goods-received-note-po-non-cash-by-vendor-invoice-data-update")
    public String findDataByVendorInvoiceUpdate() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            
            listGoodsReceivedNote =  goodsReceivedNoteBLL.findDataByVendorInvoiceUpdate(purchaseOrderSearchCode,vinNo);

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-authority")
    public String goodsReceivedNoteAuthority(){
        try{
            
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
                        
            switch(actionAuthority){
                case INSERT:
                    if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage =EnumAuthorizationString.messages(actionAuthority) ;
                        return SUCCESS;
                    }
                    break;
                    
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage =EnumAuthorizationString.messages(actionAuthority);
                        return SUCCESS;
                    }
                    break;
                    
                case CONFIRMATION:
                    if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE_CONFIRMATION, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage =EnumAuthorizationString.messages(actionAuthority);
                        return SUCCESS;
                    }
                    break;
                    
                case DELETE:
                    if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage =EnumAuthorizationString.messages(actionAuthority);
                        return SUCCESS;
                    }
                    break;
                    
                case PRINT:
                    if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
                        this.error = true;
                        this.errorMessage =EnumAuthorizationString.messages(actionAuthority);
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
    
    @Action("goods-received-note-save")
    public String save() {
        String _Messg = "";
        try {
                GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                Gson gson = new Gson();                
                
                this.listGoodsReceivedNoteItemDetail = gson.fromJson(this.listGoodsReceivedNoteItemDetailJSON, new TypeToken<List<GoodsReceivedNoteItemDetail>>(){}.getType());
            
                Date createdDate = sdf.parse(goodsReceivedNote.getCreatedDateTemp());
                Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
                goodsReceivedNote.setCreatedDate(createdDatetime);
                

                Date TransactionDateTemp = sdf.parse(goodsReceivedNote.getTransactionDateTemp());
                Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
                goodsReceivedNote.setTransactionDate(getTransactionDateTemp);
                
                
                if(goodsReceivedNoteBLL.isExist(this.goodsReceivedNote.getCode())){
                    
                    _Messg=CommonConst.MsgUpdateSuccess;
                    goodsReceivedNoteBLL.update(goodsReceivedNote, listGoodsReceivedNoteItemDetail);

                }else{
                    
                    _Messg = CommonConst.MsgSaveSuccess;
                    goodsReceivedNoteBLL.save(goodsReceivedNote, listGoodsReceivedNoteItemDetail);

                }

                this.message = _Messg + "<br/>GRN No : " + this.goodsReceivedNote.getCode();
         
                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.MESSAGE : <br/><br/><br/>" + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-update-po-save")
    public String saveUpdateInform() {
        String _Messg = "";
        try {
                GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                Gson gson = new Gson();                
                
                this.listGoodsReceivedNoteUpdatePoItemDetail = gson.fromJson(this.listGoodsReceivedNoteUpdatePoItemDetailJSON, new TypeToken<List<GoodsReceivedNoteItemDetail>>(){}.getType());
               
                _Messg=CommonConst.MsgUpdateSuccess;
                goodsReceivedNoteBLL.updateGrnPo(goodsReceivedNoteUpdatePo, listGoodsReceivedNoteUpdatePoItemDetail);

                this.message = _Messg + "<br/>GRN No : " + this.goodsReceivedNoteUpdatePo.getCode();
         
                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.MESSAGE : <br/><br/><br/>" + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-confirmation-save")
    public String confirmation() {
        try {
                GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                Gson gson = new Gson();                
                
                this.listGoodsReceivedNoteConfirmationItemDetail = gson.fromJson(this.listGoodsReceivedNoteConfirmationItemDetailJSON, new TypeToken<List<GoodsReceivedNoteItemDetail>>(){}.getType());
                
                Date TransactionDateTemp = sdf.parse(goodsReceivedNoteConfirmation.getTransactionDateTemp());
                Date getTransactionDateTemp = new java.sql.Timestamp(TransactionDateTemp.getTime());
                goodsReceivedNoteConfirmation.setTransactionDate(getTransactionDateTemp);
            
                Date createdDate = sdf.parse(goodsReceivedNoteConfirmation.getCreatedDateTemp());
                Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
                goodsReceivedNoteConfirmation.setCreatedDate(createdDatetime);
                
                goodsReceivedNoteBLL.confirmation(goodsReceivedNoteConfirmation, listGoodsReceivedNoteConfirmationItemDetail);

                this.message = CommonConst.MsgConfirmationSuccess + "<br/>GRN No : " + this.goodsReceivedNoteConfirmation.getCode();
         
                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "CONFIRMATION DATA FAILED.MESSAGE : <br/><br/><br/>" + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-delete")
    public String delete(){
        try{
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);   

            goodsReceivedNoteBLL.delete(goodsReceivedNote.getCode());
            
            this.message = CommonConst.MsgDeleteSuccess + "<br/> GRN No : " + this.goodsReceivedNote.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-po-by-vendor-invoice-data")
    public String findDataByVendorInvoice() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            
            listGoodsReceivedNote = goodsReceivedNoteBLL.findDataByVendorInvoice(purchaseOrderSearchCode);

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-detail-po-by-vendor-invoice-data")
    public String findItemDetailByVendorInvoice() {
        try {
            
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
        
            listGoodsReceivedNoteItemDetail =  goodsReceivedNoteBLL.findItemDetailByVendorInvoice(goodsReceivedNote.getCode());

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("goods-received-note-check-item")
    public String checkItem(){
        try{
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);
            
            List<GoodsReceivedNote> list = goodsReceivedNoteBLL.checkItemGrn(poCode, podCode, itemMaterialCode);
            
            if(!list.isEmpty()){
                this.error = true;
                this.errorMessage = "Item Material " + this.itemMaterialCode+ "<br/> Has Been Used in: <br/>"+list.get(0).getCode();

                return SUCCESS;
            }
            
            return SUCCESS;
            
        }catch(Exception ex){
            this.error = true;
            this.errorMessage= "DATA FAILED " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public EnumAuthorizationString.ENUM_AuthorizationString getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(EnumAuthorizationString.ENUM_AuthorizationString actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public GoodsReceivedNote getGoodsReceivedNote() {
        return goodsReceivedNote;
    }

    public void setGoodsReceivedNote(GoodsReceivedNote goodsReceivedNote) {
        this.goodsReceivedNote = goodsReceivedNote;
    }

    public List<GoodsReceivedNoteItemDetail> getListGoodsReceivedNoteItemDetail() {
        return listGoodsReceivedNoteItemDetail;
    }

    public void setListGoodsReceivedNoteItemDetail(List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail) {
        this.listGoodsReceivedNoteItemDetail = listGoodsReceivedNoteItemDetail;
    }

    public List<GoodsReceivedNoteItemSerialNoDetail> getListGoodsReceivedNoteSerialNoItemDetail() {
        return listGoodsReceivedNoteSerialNoItemDetail;
    }

    public void setListGoodsReceivedNoteSerialNoItemDetail(List<GoodsReceivedNoteItemSerialNoDetail> listGoodsReceivedNoteSerialNoItemDetail) {
        this.listGoodsReceivedNoteSerialNoItemDetail = listGoodsReceivedNoteSerialNoItemDetail;
    }

    public String getListGoodsReceivedNoteItemDetailJSON() {
        return listGoodsReceivedNoteItemDetailJSON;
    }

    public void setListGoodsReceivedNoteItemDetailJSON(String listGoodsReceivedNoteItemDetailJSON) {
        this.listGoodsReceivedNoteItemDetailJSON = listGoodsReceivedNoteItemDetailJSON;
    }

    public String getListGoodsReceivedNoteSerialNoItemDetailJSON() {
        return listGoodsReceivedNoteSerialNoItemDetailJSON;
    }

    public void setListGoodsReceivedNoteSerialNoItemDetailJSON(String listGoodsReceivedNoteSerialNoItemDetailJSON) {
        this.listGoodsReceivedNoteSerialNoItemDetailJSON = listGoodsReceivedNoteSerialNoItemDetailJSON;
    }

    public List<GoodsReceivedNote> getListGoodsReceivedNote() {
        return listGoodsReceivedNote;
    }

    public void setListGoodsReceivedNote(List<GoodsReceivedNote> listGoodsReceivedNote) {
        this.listGoodsReceivedNote = listGoodsReceivedNote;
    }

    public GoodsReceivedNote getGoodsReceivedNoteConfirmation() {
        return goodsReceivedNoteConfirmation;
    }

    public void setGoodsReceivedNoteConfirmation(GoodsReceivedNote goodsReceivedNoteConfirmation) {
        this.goodsReceivedNoteConfirmation = goodsReceivedNoteConfirmation;
    }

    public List<GoodsReceivedNoteItemDetail> getListGoodsReceivedNoteConfirmationItemDetail() {
        return listGoodsReceivedNoteConfirmationItemDetail;
    }

    public void setListGoodsReceivedNoteConfirmationItemDetail(List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteConfirmationItemDetail) {
        this.listGoodsReceivedNoteConfirmationItemDetail = listGoodsReceivedNoteConfirmationItemDetail;
    }

    public List<GoodsReceivedNoteItemSerialNoDetail> getListGoodsReceivedNoteConfirmationSerialNoItemDetail() {
        return listGoodsReceivedNoteConfirmationSerialNoItemDetail;
    }

    public void setListGoodsReceivedNoteConfirmationSerialNoItemDetail(List<GoodsReceivedNoteItemSerialNoDetail> listGoodsReceivedNoteConfirmationSerialNoItemDetail) {
        this.listGoodsReceivedNoteConfirmationSerialNoItemDetail = listGoodsReceivedNoteConfirmationSerialNoItemDetail;
    }

    public String getListGoodsReceivedNoteConfirmationItemDetailJSON() {
        return listGoodsReceivedNoteConfirmationItemDetailJSON;
    }

    public void setListGoodsReceivedNoteConfirmationItemDetailJSON(String listGoodsReceivedNoteConfirmationItemDetailJSON) {
        this.listGoodsReceivedNoteConfirmationItemDetailJSON = listGoodsReceivedNoteConfirmationItemDetailJSON;
    }

    public String getListGoodsReceivedNoteConfirmationSerialNoItemDetailJSON() {
        return listGoodsReceivedNoteConfirmationSerialNoItemDetailJSON;
    }

    public void setListGoodsReceivedNoteConfirmationSerialNoItemDetailJSON(String listGoodsReceivedNoteConfirmationSerialNoItemDetailJSON) {
        this.listGoodsReceivedNoteConfirmationSerialNoItemDetailJSON = listGoodsReceivedNoteConfirmationSerialNoItemDetailJSON;
    }

    public String getPurchaseOrderSearchCode() {
        return purchaseOrderSearchCode;
    }

    public void setPurchaseOrderSearchCode(String purchaseOrderSearchCode) {
        this.purchaseOrderSearchCode = purchaseOrderSearchCode;
    }

    public List<GoodsReceivedNote> getListGoodsReceivedNoteUpdatePo() {
        return listGoodsReceivedNoteUpdatePo;
    }

    public void setListGoodsReceivedNoteUpdatePo(List<GoodsReceivedNote> listGoodsReceivedNoteUpdatePo) {
        this.listGoodsReceivedNoteUpdatePo = listGoodsReceivedNoteUpdatePo;
    }

    public GoodsReceivedNote getGoodsReceivedNoteUpdatePo() {
        return goodsReceivedNoteUpdatePo;
    }

    public void setGoodsReceivedNoteUpdatePo(GoodsReceivedNote goodsReceivedNoteUpdatePo) {
        this.goodsReceivedNoteUpdatePo = goodsReceivedNoteUpdatePo;
    }

    public String getPoCode() {
        return poCode;
    }

    public void setPoCode(String poCode) {
        this.poCode = poCode;
    }

    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }

    public String getPodCode() {
        return podCode;
    }

    public void setPodCode(String podCode) {
        this.podCode = podCode;
    }

    public List<GoodsReceivedNoteItemDetail> getListGoodsReceivedNoteUpdatePoItemDetail() {
        return listGoodsReceivedNoteUpdatePoItemDetail;
    }

    public void setListGoodsReceivedNoteUpdatePoItemDetail(List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteUpdatePoItemDetail) {
        this.listGoodsReceivedNoteUpdatePoItemDetail = listGoodsReceivedNoteUpdatePoItemDetail;
    }

    public String getListGoodsReceivedNoteUpdatePoItemDetailJSON() {
        return listGoodsReceivedNoteUpdatePoItemDetailJSON;
    }

    public void setListGoodsReceivedNoteUpdatePoItemDetailJSON(String listGoodsReceivedNoteUpdatePoItemDetailJSON) {
        this.listGoodsReceivedNoteUpdatePoItemDetailJSON = listGoodsReceivedNoteUpdatePoItemDetailJSON;
    }

    public String getVinNo() {
        return vinNo;
    }

    public void setVinNo(String vinNo) {
        this.vinNo = vinNo;
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
