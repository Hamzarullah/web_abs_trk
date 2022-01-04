/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.VendorInvoiceDAO;
import com.inkombizz.finance.model.VendorInvoice;
import com.inkombizz.finance.model.VendorInvoiceForexGainLoss;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNote;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNoteTemp;
import com.inkombizz.finance.model.VendorInvoiceItemDetail;
import com.inkombizz.finance.model.VendorInvoiceItemDetailTemp;
import com.inkombizz.finance.model.VendorInvoiceTemp;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPayment;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPaymentTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Sukha
 */
public class VendorInvoiceBLL {
    
    public final String MODULECODE = "004_FIN_VENDOR_INVOICE";
    public final String MODULECODE_OUSTANDING = "005_FIN_VENDOR_INVOICE_OUSTANDING";
    
    private VendorInvoiceDAO vendorInvoiceDAO;
    
    public VendorInvoiceBLL(HBMSession hbmSession) {
        this.vendorInvoiceDAO = new VendorInvoiceDAO(hbmSession);
    }
    
    public ListPaging<VendorInvoiceTemp> findData(Paging paging,Date firstDate, Date lastDate, Date firstDueDate, Date lastDueDate, String code , String purchaseOrderCode , String paymentTermCode,
            String branchCode, String branchName, String vendorCode, String vendorName, String refno
            ) throws Exception {
        try {

            paging.setRecords(vendorInvoiceDAO.countData(firstDate, lastDate, firstDueDate, lastDueDate, code, purchaseOrderCode, paymentTermCode,
                    branchCode,  branchName, vendorCode, vendorName,refno));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorInvoiceTemp> listVendorInvoiceTemp = vendorInvoiceDAO.findData(firstDate, lastDate,firstDueDate, lastDueDate, code, purchaseOrderCode, paymentTermCode,
                    branchCode,  branchName, vendorCode, vendorName, refno
            ,paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorInvoiceTemp> listPaging = new ListPaging<VendorInvoiceTemp>();
            
            listPaging.setList(listVendorInvoiceTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }      
    
    public ListPaging<VendorInvoiceTemp> findSearchData(Paging paging, Date firstDate, Date lastDate, String code) throws Exception {
        try {

            paging.setRecords(vendorInvoiceDAO.countSearchData(firstDate, lastDate, code));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorInvoiceTemp> listVendorInvoiceTemp = vendorInvoiceDAO.findSearchData(firstDate, lastDate, 
            code, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorInvoiceTemp> listPaging = new ListPaging<VendorInvoiceTemp>();
            
            listPaging.setList(listVendorInvoiceTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<VendorInvoiceGoodsReceivedNoteTemp> findGRNData(String code) throws Exception {
        try {
              return vendorInvoiceDAO.findGRNData(code);
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<VendorInvoiceVendorDownPaymentTemp> findDPData(String code) throws Exception {
        try {
              return vendorInvoiceDAO.findDPData(code);
        }
        catch(Exception ex) {
            throw ex;
        }
    }  
    
    public List<VendorInvoiceItemDetailTemp> findItemData(String code) throws Exception {
        try {
              return vendorInvoiceDAO.findItemData(code);
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<VendorInvoiceItemDetailTemp> findItemDetailSearchData(VendorInvoiceItemDetailTemp vendorInvoiceItemDetailTemp) throws Exception {
        try {
              return vendorInvoiceDAO.findItemDetailSearchData(vendorInvoiceItemDetailTemp);
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<VendorInvoiceItemDetailTemp> findItemDataPR(String vendorInvoiceVendorCode, String vendorInvoiceItemCode) throws Exception {
        try {
              return vendorInvoiceDAO.findItemDataPR(vendorInvoiceVendorCode, vendorInvoiceItemCode);
        }
        catch(Exception ex) {
            throw ex;
        }
    }  

    public VendorInvoice get(String code) throws Exception {
        try {
            return (VendorInvoice) vendorInvoiceDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(VendorInvoice vendorInvoice,List<VendorInvoiceGoodsReceivedNote>  listVendorInvoiceGRN, 
            List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPayment,
            List<VendorInvoiceItemDetail> listVendorInvoiceItemDetail, 
//            List<VendorInvoicePostingItemDetail> listVendorInvoicePostingItemDetail, 
            VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss) throws Exception {
        try {
            vendorInvoiceDAO.save(vendorInvoice, listVendorInvoiceGRN, listVendorInvoiceVendorDownPayment,
                    listVendorInvoiceItemDetail, 
//                    listVendorInvoicePostingItemDetail, 
                    vendorInvoiceForexGainLoss, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(VendorInvoice vendorInvoice,
            List<VendorInvoiceGoodsReceivedNote>listVendorInvoiceGRN, 
            List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPayment,
            List<VendorInvoiceItemDetail> listVendorInvoiceItemDetail,
            VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss
    ) throws Exception {
        try {
        vendorInvoiceDAO.update(vendorInvoice,listVendorInvoiceGRN,listVendorInvoiceVendorDownPayment,
                    listVendorInvoiceItemDetail,vendorInvoiceForexGainLoss, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            vendorInvoiceDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
      
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorInvoice.class)
                            .add(Restrictions.eq("code", code));
             
            if(vendorInvoiceDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public int countValidateGRNByPOCash(String code) throws Exception{
        try{
            return vendorInvoiceDAO.countValidateGRNByPOCash(code);
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public ListPaging<VendorInvoiceTemp> findSearchDataForPosting(Paging paging, Date firstDate, Date lastDate, String code) throws Exception {
        try {

            paging.setRecords(vendorInvoiceDAO.countSearchDataForPosting(firstDate, lastDate, code));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorInvoiceTemp> listVendorInvoiceTemp = vendorInvoiceDAO.findSearchDataForPosting(firstDate, lastDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorInvoiceTemp> listPaging = new ListPaging<VendorInvoiceTemp>();
            
            listPaging.setList(listVendorInvoiceTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public int vendorInvoiceUsedInPosting(String code){
        try{
            return vendorInvoiceDAO.vendorInvoiceUsedInPosting(code);
        }catch(Exception e){
             return 0;
        }
    }

    public ListPaging<VendorInvoiceTemp> findOutstandingData(Paging paging,String code,String vendorCode,String vendorName,String statusInvoice) throws Exception {
        try {

            paging.setRecords(vendorInvoiceDAO.countOutstandingData(code,vendorCode,vendorName,statusInvoice));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorInvoiceTemp> listVendorInvoiceTemp = vendorInvoiceDAO.findOutstandingData(code,vendorCode,vendorName,statusInvoice,paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorInvoiceTemp> listPaging = new ListPaging<VendorInvoiceTemp>();
            
            listPaging.setList(listVendorInvoiceTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public VendorInvoiceDAO getVendorInvoiceDAO() {
        return vendorInvoiceDAO;
    }

    public void setVendorInvoiceDAO(VendorInvoiceDAO vendorInvoiceDAO) {
        this.vendorInvoiceDAO = vendorInvoiceDAO;
    }

    public String getMODULECODE() {
        return MODULECODE;
    }

    public String getMODULECODE_OUSTANDING() {
        return MODULECODE_OUSTANDING;
    }
    
    
}
