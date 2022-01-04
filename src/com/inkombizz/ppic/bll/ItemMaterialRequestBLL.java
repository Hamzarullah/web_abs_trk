/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.dao.ItemMaterialRequestDAO;
import com.inkombizz.ppic.model.ItemMaterialRequest;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemProcessedPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestPartDetail;
import java.util.List;

public class ItemMaterialRequestBLL {
    
    public static final String MODULECODE = "009_PPIC_ITEM_MATERIAL_REQUEST";
    public static final String MODULECODE_APPROVAL = "009_PPIC_ITEM_MATERIAL_REQUEST_APPROVAL";
    public static final String MODULECODE_CLOSING = "009_PPIC_ITEM_MATERIAL_REQUEST_CLOSING";
    
    private ItemMaterialRequestDAO itemMaterialRequestDAO;
    
    public ItemMaterialRequestBLL (HBMSession hbmSession) {
        this.itemMaterialRequestDAO = new ItemMaterialRequestDAO(hbmSession);
    }
    
    public ListPaging<ItemMaterialRequest> findData(Paging paging,ItemMaterialRequest itemMaterialRequest) throws Exception{
        try{

            paging.setRecords(itemMaterialRequestDAO.countData(itemMaterialRequest));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemMaterialRequest> listItemMaterialRequest = itemMaterialRequestDAO.findData(itemMaterialRequest,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialRequest> listPaging = new ListPaging<ItemMaterialRequest>();
            listPaging.setList(listItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ItemMaterialRequest> findDataApproval(Paging paging,ItemMaterialRequest itemMaterialRequestApproval) throws Exception{
        try{

            paging.setRecords(itemMaterialRequestDAO.countDataApproval(itemMaterialRequestApproval));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemMaterialRequest> listItemMaterialRequest = itemMaterialRequestDAO.findDataApproval(itemMaterialRequestApproval,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialRequest> listPaging = new ListPaging<ItemMaterialRequest>();
            listPaging.setList(listItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ItemMaterialRequest> findDataClosing(Paging paging,ItemMaterialRequest itemMaterialRequestClosing) throws Exception{
        try{

            paging.setRecords(itemMaterialRequestDAO.countDataClosing(itemMaterialRequestClosing));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemMaterialRequest> listItemMaterialRequest = itemMaterialRequestDAO.findDataClosing(itemMaterialRequestClosing,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialRequest> listPaging = new ListPaging<ItemMaterialRequest>();
            listPaging.setList(listItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<ItemMaterialRequestItemProcessedPartDetail> findProcessedPartDetail(String headerCode) throws Exception{
       try{
            
            List<ItemMaterialRequestItemProcessedPartDetail> listItemMaterialRequestItemProcessedPartDetail = itemMaterialRequestDAO.findProcessedPartDetail(headerCode);
                        
            return listItemMaterialRequestItemProcessedPartDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemBookingDetail> findItemBookingDetail(String headerCode)throws Exception{
        try{
            List<ItemMaterialRequestItemBookingDetail> listItemMaterialRequestItemBookingDetail = itemMaterialRequestDAO.findItemBookingDetail(headerCode);
            
            return listItemMaterialRequestItemBookingDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemBookingPartDetail> findItemBookingPartDetail(String headerCode)throws Exception{
        try{
            List<ItemMaterialRequestItemBookingPartDetail> listItemMaterialRequestItemBookingPartDetail = itemMaterialRequestDAO.findItemBookingPartDetail(headerCode);
            
            return listItemMaterialRequestItemBookingPartDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemRequestDetail> findItemRequestDetail(String headerCode)throws Exception{
        try{
            List<ItemMaterialRequestItemRequestDetail> listItemMaterialRequestItemRequestDetail = itemMaterialRequestDAO.findItemRequestDetail(headerCode);
            
            return listItemMaterialRequestItemRequestDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemRequestPartDetail> findItemRequestPartDetail(String headerCode)throws Exception{
        try{
            List<ItemMaterialRequestItemRequestPartDetail> listItemMaterialRequestItemRequestPartDetail = itemMaterialRequestDAO.findItemRequestPartDetail(headerCode);
            
            return listItemMaterialRequestItemRequestPartDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity, ItemMaterialRequest itemMaterialRequest, List<ItemMaterialRequestItemProcessedPartDetail> listItemMaterialRequestItemProcessedPartDetail,
                     List<ItemMaterialRequestItemBookingDetail> listItemMaterialRequestItemBookingDetail, List<ItemMaterialRequestItemBookingPartDetail> listItemMaterialRequestItemBookingPartDetail,
                     List<ItemMaterialRequestItemRequestDetail> listItemMaterialRequestItemRequestDetail, List<ItemMaterialRequestItemRequestPartDetail> listItemMaterialRequestItemRequestPartDetail) throws Exception {
        try {
            itemMaterialRequestDAO.save(enumActivity, itemMaterialRequest, listItemMaterialRequestItemProcessedPartDetail, listItemMaterialRequestItemBookingDetail,
                                        listItemMaterialRequestItemBookingPartDetail, listItemMaterialRequestItemRequestDetail, listItemMaterialRequestItemRequestPartDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(ItemMaterialRequest itemMaterialRequest) throws Exception{
        try{
            itemMaterialRequestDAO.delete(itemMaterialRequest, MODULECODE);
        }catch (Exception e){
            throw e;
        }
    }
    
    public void approval(ItemMaterialRequest itemMaterialRequest) throws Exception {
        try {
            itemMaterialRequestDAO.approval(itemMaterialRequest,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void closing(ItemMaterialRequest itemMaterialRequest) throws Exception {
        try {
            itemMaterialRequestDAO.approval(itemMaterialRequest,MODULECODE_CLOSING);
        } catch (Exception e) {
            throw e;
        }
    }
}
