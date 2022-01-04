/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.GoodsRecivedNoteDAO;
import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.inventory.model.GoodsReceivedNoteField;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemDetail;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemSerialNoDetail;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author ikb
 */
public class GoodsReceivedNoteBLL {
     public static final String MODULECODE = "003_IVT_GOODS_RECEIVED_NOTE";
     public static final String MODULECODE_UPDATE_PO = "003_IVT_GOODS_RECEIVED_NOTE_UPDATE_PO";
     public static final String MODULECODE_CONFIRMATION = "003_IVT_GOODS_RECEIVED_NOTE_CONFIRMATION";
    
    private GoodsRecivedNoteDAO goodsReceivedNoteDAO;
    
    public GoodsReceivedNoteBLL (HBMSession hbmSession) {
        this.goodsReceivedNoteDAO = new GoodsRecivedNoteDAO(hbmSession);
    }
    
    public ListPaging<GoodsReceivedNote> findData(Paging paging,GoodsReceivedNote goodsReceivedNote) throws Exception{
        try{
            
            paging.setRecords(goodsReceivedNoteDAO.countData(goodsReceivedNote));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<GoodsReceivedNote> listGoodsReceivedNote = goodsReceivedNoteDAO.findData(goodsReceivedNote,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GoodsReceivedNote> listPaging = new ListPaging<GoodsReceivedNote>();
            listPaging.setList(listGoodsReceivedNote);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<GoodsReceivedNote> findDataConfirmation(Paging paging,GoodsReceivedNote goodsReceivedNote) throws Exception{
        try{
            
            paging.setRecords(goodsReceivedNoteDAO.countDataConfirmation(goodsReceivedNote));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<GoodsReceivedNote> listGoodsReceivedNote = goodsReceivedNoteDAO.findDataConfirmation(goodsReceivedNote,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GoodsReceivedNote> listPaging = new ListPaging<GoodsReceivedNote>();
            listPaging.setList(listGoodsReceivedNote);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<GoodsReceivedNoteItemDetail> findDataGRNItemDetail(String headerCode) throws Exception{
       try{
            
            List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail = goodsReceivedNoteDAO.findDataGRNItemDetail(headerCode);
                        
            return listGoodsReceivedNoteItemDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<GoodsReceivedNoteItemSerialNoDetail> findDataItemSerialNoDetail(String headerCode) throws Exception{
       try{
            
            List<GoodsReceivedNoteItemSerialNoDetail> listGoodsReceivedNoteItemSerialNoDetail = goodsReceivedNoteDAO.findDataItemSerialNoDetail(headerCode);
                        
            return listGoodsReceivedNoteItemSerialNoDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public GoodsReceivedNote get(String code) throws Exception {
        try {
            return (GoodsReceivedNote) goodsReceivedNoteDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<GoodsReceivedNote> findDataGrnUpdt(Paging paging,GoodsReceivedNote goodsReceivedNoteUpdatePo) throws Exception{
        try{
            
            paging.setRecords(goodsReceivedNoteDAO.countGrnUdt(goodsReceivedNoteUpdatePo));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<GoodsReceivedNote> listGoodsReceivedNote = goodsReceivedNoteDAO.findDataGrnUdt(goodsReceivedNoteUpdatePo,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GoodsReceivedNote> listPaging = new ListPaging<GoodsReceivedNote>();
            listPaging.setList(listGoodsReceivedNote);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<GoodsReceivedNote> findDataByVendorInvoice(String code){
        try{
        
           return goodsReceivedNoteDAO.findDataByVendorInvoice(code);
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<GoodsReceivedNoteItemDetail> findItemDetailByVendorInvoice(String code){
        try{
        
           return goodsReceivedNoteDAO.findDataItemDetailByVendorInvoice(code);
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
     public List<GoodsReceivedNote> findDataByVendorInvoiceUpdate(String purchaseOrderNo,String vendorInvoiceNo){
        try{
        
           return goodsReceivedNoteDAO.findDataByVendorInvoiceUpdate(purchaseOrderNo,vendorInvoiceNo);
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<GoodsReceivedNote> checkItemGrn(String poCode, String podCode, String itemMaterialCode){
        try{
            return goodsReceivedNoteDAO.checkItemGrn(poCode,podCode,itemMaterialCode);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(GoodsReceivedNote goodsReceivedNote, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail) throws Exception {
        try {
            goodsReceivedNoteDAO.save(goodsReceivedNote, listGoodsReceivedNoteItemDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(GoodsReceivedNote goodsReceivedNotePo, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteLocalNonSerialNoItemDetail) throws Exception{
        goodsReceivedNoteDAO.update(goodsReceivedNotePo, listGoodsReceivedNoteLocalNonSerialNoItemDetail ,MODULECODE);
    }
    
    public void updateGrnPo(GoodsReceivedNote goodsReceivedNotePo, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteLocalNonSerialNoItemDetail) throws Exception{
        goodsReceivedNoteDAO.updateGrnPo(goodsReceivedNotePo, listGoodsReceivedNoteLocalNonSerialNoItemDetail ,MODULECODE_UPDATE_PO);
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(GoodsReceivedNote.class)
                            .add(Restrictions.eq(GoodsReceivedNoteField.CODE, headerCode));
             
            if(goodsReceivedNoteDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }   
    
    public void delete(String headerCode) throws Exception {
        try {
            goodsReceivedNoteDAO.delete(headerCode, MODULECODE);
        } catch (Exception e){
            throw e;
        }
    }
    
    public void confirmation(GoodsReceivedNote goodsReceivedNote, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail) throws Exception {
        try {
            goodsReceivedNoteDAO.confirmation(goodsReceivedNote, listGoodsReceivedNoteItemDetail, MODULECODE_CONFIRMATION);
        }
        catch (Exception e) {
            throw e;
        }
    }
}
