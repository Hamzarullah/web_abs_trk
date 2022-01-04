
package com.inkombizz.purchasing.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.dao.PurchaseOrderDAO;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.purchasing.model.PurchaseOrderAdditionalFee;
import com.inkombizz.purchasing.model.PurchaseOrderDetail;
import com.inkombizz.purchasing.model.PurchaseOrderItemDeliveryDate;
import com.inkombizz.purchasing.model.PurchaseOrderPurchaseRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class PurchaseOrderBLL {
    
    public static final String MODULECODE = "001_PUR_PURCHASE_ORDER";
    public static final String MODULECODE_APPROVAL = "001_PUR_PURCHASE_ORDER_APPROVAL";
    public static final String MODULECODE_CLOSING = "001_PUR_PURCHASE_ORDER_CLOSING";
    public static final String MODULECODE_UPDATE_INFORMATION = "001_PUR_PURCHASE_ORDER_UPDATE_INFORMATION";
    
    private PurchaseOrderDAO purchaseOrderDAO;
    
    public PurchaseOrderBLL (HBMSession hbmSession) {
        this.purchaseOrderDAO = new PurchaseOrderDAO(hbmSession);
    }
    
    public ListPaging<PurchaseOrder> findData(Paging paging,PurchaseOrder purchaseOrder) throws Exception {
        try {
                     
            paging.setRecords(purchaseOrderDAO.countData(purchaseOrder));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseOrder> listPurchaseOrderRelease = purchaseOrderDAO.findData(purchaseOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseOrder> listPaging = new ListPaging<PurchaseOrder>();
            
            listPaging.setList(listPurchaseOrderRelease);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PurchaseOrder> findDataApproval(Paging paging,PurchaseOrder purchaseOrder) throws Exception {
        try {
                     
            paging.setRecords(purchaseOrderDAO.countDataApproval(purchaseOrder));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseOrder> listPurchaseOrderRelease = purchaseOrderDAO.findDataApproval(purchaseOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseOrder> listPaging = new ListPaging<PurchaseOrder>();
            
            listPaging.setList(listPurchaseOrderRelease);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PurchaseOrder> findDataUpdateInformation(Paging paging,PurchaseOrder purchaseOrder) throws Exception {
        try {
                     
            paging.setRecords(purchaseOrderDAO.countDataUpdateInformation(purchaseOrder));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseOrder> listPurchaseOrderRelease = purchaseOrderDAO.findDataUpdateInformation(purchaseOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseOrder> listPaging = new ListPaging<PurchaseOrder>();
            
            listPaging.setList(listPurchaseOrderRelease);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseOrderPurchaseRequest> findDataPurchaseRequest(String headerCode) throws Exception {
        try {
            
            List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequest = purchaseOrderDAO.findDataPurchaseRequest(headerCode);
            
            return listPurchaseOrderPurchaseRequest;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public List<PurchaseOrderSubItem> findDataPurchaseOrderSubItem(String headerCode) throws Exception {
//        try {
//            
//            List<PurchaseOrderSubItem> listPurchaseOrderSubItem = purchaseOrderDAO.findDataPurchaseOrderSubItem(headerCode);
//            
//            return listPurchaseOrderSubItem;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
    public List<PurchaseOrderDetail> findDataPurchaseOrderDetail(String headerCode) throws Exception {
        try {
            
            List<PurchaseOrderDetail> listPurchaseOrderDetail = purchaseOrderDAO.findDataPurchaseOrderDetail(headerCode);
            
            return listPurchaseOrderDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseOrderDetail> findDataPurchaseOrderDetailGrn(String headerCode) throws Exception {
        try {
            
            List<PurchaseOrderDetail> listPurchaseOrderDetail = purchaseOrderDAO.findDataDetailByGrn(headerCode);
            
            return listPurchaseOrderDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseOrderAdditionalFee> findDataPurchaseOrderAdditionalFee(String headerCode) throws Exception {
        try {
            
            List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee = purchaseOrderDAO.findDataAdditonalFee(headerCode);
            
            return listPurchaseOrderAdditionalFee;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
            List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDat = purchaseOrderDAO.findDataItemDeliveryDate(headerCode);
            
            return listPurchaseOrderItemDeliveryDat;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PurchaseOrder> findataSearch(Paging paging,String code,String vendorCode,String vendorName,Date firstDate,Date lastDate) throws Exception{
        try{

            paging.setRecords(purchaseOrderDAO.countDataSearch(code,vendorCode,vendorName,firstDate,lastDate));
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<PurchaseOrder> listPurchaseOrderTemp = purchaseOrderDAO.findDataSearch(code,vendorCode,vendorName,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseOrder> listPaging = new ListPaging<PurchaseOrder>();
            
            listPaging.setList(listPurchaseOrderTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }  
    
    public ListPaging<PurchaseOrder> searchByVendorInvoiceData(Paging paging,Date firstDate, Date lastDate,String code,String vendorCode,String vendorName) throws Exception{
        try{

            paging.setRecords(purchaseOrderDAO.countSearchByVendorInvoiceData(firstDate,lastDate,code,vendorCode,vendorName));
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<PurchaseOrder> listPurchaseOrder = purchaseOrderDAO.searchByVendorInvoiceData(firstDate,lastDate,code,vendorCode,vendorName,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseOrder> listPaging = new ListPaging<PurchaseOrder>();
            
            listPaging.setList(listPurchaseOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity, PurchaseOrder purchaseOrder, List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequest, 
                     List<PurchaseOrderDetail> listPurchaseOrderDetail, 
                     List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee,
                     List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            purchaseOrderDAO.save(enumActivity, purchaseOrder, listPurchaseOrderPurchaseRequest, listPurchaseOrderDetail, listPurchaseOrderAdditionalFee, listPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(EnumActivity.ENUM_Activity enumActivity, PurchaseOrder purchaseOrder, List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequest, 
                     List<PurchaseOrderDetail> listPurchaseOrderDetail, 
                     List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee,
                     List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            purchaseOrderDAO.update(enumActivity, purchaseOrder, listPurchaseOrderPurchaseRequest, listPurchaseOrderDetail, listPurchaseOrderAdditionalFee, listPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(PurchaseOrder purchaseOrder) throws Exception{
        try{
            purchaseOrderDAO.delete(purchaseOrder, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void approval(PurchaseOrder purchaseOrder) throws Exception {
        try {
            purchaseOrderDAO.approval(purchaseOrder,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
      
    public void closing(PurchaseOrder purchaseOrder) throws Exception {
        try {
            purchaseOrderDAO.closing(purchaseOrder, MODULECODE_CLOSING);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void updateInformation(PurchaseOrder purchaseOrder, List<PurchaseOrderDetail> listPurchaseOrderDetail, 
                                  List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetail, List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate) throws Exception{
        try{
            purchaseOrderDAO.updateInformation(purchaseOrder, listPurchaseOrderDetail, listPurchaseOrderUpdateInformationDetail, listPurchaseOrderItemDeliveryDate, MODULECODE_UPDATE_INFORMATION);
        }catch(Exception e){
            throw e;
        }
    }
}
