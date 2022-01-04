/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.dao.ProductionPlanningOrderDAO;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetail;
import com.inkombizz.ppic.model.ProductionPlanningOrderField;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class ProductionPlanningOrderBLL {
    
    public static final String MODULECODE = "009_PPIC_PRODUCTION_PLANNING_ORDER";
    public static final String MODULECODE_APPROVAL = "009_PPIC_PRODUCTION_PLANNING_ORDER_APPROVAL";
    public static final String MODULECODE_CLOSING = "009_PPIC_PRODUCTION_PLANNING_ORDER_CLOSING";
    
    private ProductionPlanningOrderDAO productionPlanningOrderDAO;
    
    public ProductionPlanningOrderBLL (HBMSession hbmSession) {
        this.productionPlanningOrderDAO = new ProductionPlanningOrderDAO(hbmSession);
    }
    
    public ListPaging<ProductionPlanningOrder> findData(Paging paging,ProductionPlanningOrder productionPlanningOrder) throws Exception{
        try{

            paging.setRecords(productionPlanningOrderDAO.countData(productionPlanningOrder));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ProductionPlanningOrder> listProductionPlanningOrder = productionPlanningOrderDAO.findData(productionPlanningOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProductionPlanningOrder> listPaging = new ListPaging<ProductionPlanningOrder>();
            listPaging.setList(listProductionPlanningOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ProductionPlanningOrder> findDataSearch(Paging paging,ProductionPlanningOrder productionPlanningOrder) throws Exception{
        try{

            paging.setRecords(productionPlanningOrderDAO.countDataSearch(productionPlanningOrder));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ProductionPlanningOrder> listProductionPlanningOrder = productionPlanningOrderDAO.findDataSearch(productionPlanningOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProductionPlanningOrder> listPaging = new ListPaging<ProductionPlanningOrder>();
            listPaging.setList(listProductionPlanningOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ProductionPlanningOrder> findDataBom(Paging paging,ProductionPlanningOrder productionPlanningOrderItemBillOfMaterial) throws Exception{
        try{

            paging.setRecords(productionPlanningOrderDAO.countDataBom(productionPlanningOrderItemBillOfMaterial));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ProductionPlanningOrder> listProductionPlanningOrder = productionPlanningOrderDAO.findDataBom(productionPlanningOrderItemBillOfMaterial,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProductionPlanningOrder> listPaging = new ListPaging<ProductionPlanningOrder>();
            listPaging.setList(listProductionPlanningOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ProductionPlanningOrder> findApprovalData(Paging paging,String code,String remark,String refno,
            Date firstDate,Date lastDate,String customerCode,String customerName,String approvalStatus,String documentType) throws Exception{
        try{

            paging.setRecords(productionPlanningOrderDAO.countApprovalData(code,remark,refno,firstDate,lastDate,customerCode,customerName,approvalStatus,documentType));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ProductionPlanningOrder> listProductionPlanningOrder = productionPlanningOrderDAO.findApprovalData(code,remark,refno,firstDate,lastDate,customerCode,customerName,approvalStatus,documentType,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProductionPlanningOrder> listPaging = new ListPaging<ProductionPlanningOrder>();
            listPaging.setList(listProductionPlanningOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ProductionPlanningOrder> findClosingData(Paging paging,String code,String remark,String refno,
            Date firstDate,Date lastDate,String customerCode,String customerName,String closingStatus,String documentType) throws Exception{
        try{

            paging.setRecords(productionPlanningOrderDAO.countClosingData(code,remark,refno,firstDate,lastDate,customerCode,customerName,closingStatus,documentType));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ProductionPlanningOrder> listProductionPlanningOrder = productionPlanningOrderDAO.findClosingData(code,remark,refno,firstDate,lastDate,customerCode,customerName,closingStatus,documentType,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProductionPlanningOrder> listPaging = new ListPaging<ProductionPlanningOrder>();
            listPaging.setList(listProductionPlanningOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findDataItemDetail(String headerCode,String documentType) throws Exception{
       try{
            
            List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemDetail = productionPlanningOrderDAO.findDataItemDetail(headerCode,documentType);
                        
            return listProductionPlanningOrderItemDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findDataBomItemDetail(String headerCode) throws Exception{
       try{
            
            List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemDetail = productionPlanningOrderDAO.findDataBomItemDetail(headerCode);
                        
            return listProductionPlanningOrderItemDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findApprovalDataItemDetail(String headerCode,String documentType) throws Exception{
       try{
            
            List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemDetail = productionPlanningOrderDAO.findApprovalDataItemDetail(headerCode,documentType);
                        
            return listProductionPlanningOrderItemDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findClosingDataItemDetail(String headerCode,String documentType) throws Exception{
       try{
            
            List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemDetail = productionPlanningOrderDAO.findClosingDataItemDetail(headerCode,documentType);
                        
            return listProductionPlanningOrderItemDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public ProductionPlanningOrder get(String code) throws Exception {
        try {
            return (ProductionPlanningOrder) productionPlanningOrderDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ProductionPlanningOrder productionPlanning, List<ProductionPlanningOrderItemDetail> listProductionPlanningDetail) throws Exception {
        try {
            productionPlanningOrderDAO.save(productionPlanning, listProductionPlanningDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void approval(ProductionPlanningOrder productionPlanning) throws Exception {
        try {
            productionPlanningOrderDAO.approval(productionPlanning,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void closing(ProductionPlanningOrder productionPlanning) throws Exception {
        try {
            productionPlanningOrderDAO.closing(productionPlanning,MODULECODE_CLOSING);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ProductionPlanningOrder productionPlanning, List<ProductionPlanningOrderItemDetail> listProductionPlanningDetail) throws Exception{
        productionPlanningOrderDAO.update(productionPlanning, listProductionPlanningDetail, MODULECODE);
    }
     
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ProductionPlanningOrder.class)
                            .add(Restrictions.eq(ProductionPlanningOrderField.CODE, headerCode));
             
            if(productionPlanningOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
       
    public void delete(String code) throws Exception{
        try{
            productionPlanningOrderDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    } 
}
