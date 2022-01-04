
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CurrentStockQuantityDAO;
import com.inkombizz.master.model.CurrentStockQuantity;
import com.inkombizz.master.model.CurrentStockQuantityField;
import com.inkombizz.master.model.CurrentStockQuantityTemp;

public class CurrentStockQuantityBLL {
 
    public static final String MODULECODE = "006_MST_CURRENT_STOCK_QUANTITY";
    
    private CurrentStockQuantityDAO currentStockQuantityDAO;
    
    public CurrentStockQuantityBLL (HBMSession hbmSession) {
        this.currentStockQuantityDAO = new CurrentStockQuantityDAO(hbmSession);
    }
     
    public ListPaging<CurrentStockQuantity> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockQuantity.class);

            paging.setRecords(currentStockQuantityDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<CurrentStockQuantity> listCurrentStockQuantity = currentStockQuantityDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<CurrentStockQuantity> listPaging = new ListPaging<CurrentStockQuantity>();

            listPaging.setList(listCurrentStockQuantity);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CurrentStockQuantityTemp> findData(String warehouseCode,String warehouseName,String itemCode,String itemName,
             String rackCode, String rackName,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockQuantity.class);           
    
            paging.setRecords(currentStockQuantityDAO.countData());
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrentStockQuantityTemp> listCurrentStockQuantityTemp = currentStockQuantityDAO.findData( warehouseCode,  warehouseName, 
             itemCode,  itemName , rackCode,  rackName, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrentStockQuantityTemp> listPaging = new ListPaging<CurrentStockQuantityTemp>();
            
            listPaging.setList(listCurrentStockQuantityTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
     public ListPaging<CurrentStockQuantityTemp> searchData(String warehouseCode,String warehouseName,String itemCode,String itemName,
             String rackCode, String rackName,Paging paging) throws Exception {
        try {
            paging.setRecords(currentStockQuantityDAO.countDataSearch(warehouseCode,warehouseName,itemCode,itemName,rackCode,rackName));      
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrentStockQuantityTemp> listCurrentStockQuantityTemp = currentStockQuantityDAO.findDataSearch(warehouseCode,warehouseName,itemCode,itemName,
                    rackCode,rackName,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrentStockQuantityTemp> listPaging = new ListPaging<CurrentStockQuantityTemp>();
            
            listPaging.setList(listCurrentStockQuantityTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public ListPaging<CurrentStockQuantity> search(Paging paging, String code, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockQuantity.class)
                    .add(Restrictions.like(CurrentStockQuantityField.CODE, code + "%" ));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(CurrentStockQuantityField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(CurrentStockQuantityField.ACTIVESTATUS, false));
            
            paging.setRecords(currentStockQuantityDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrentStockQuantity> listCurrentStockQuantity = currentStockQuantityDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrentStockQuantity> listPaging = new ListPaging<CurrentStockQuantity>();
            
            listPaging.setList(listCurrentStockQuantity);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CurrentStockQuantity> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockQuantity.class);
            List<CurrentStockQuantity> listCurrentStockQuantity = currentStockQuantityDAO.findByCriteria(criteria);
            return listCurrentStockQuantity;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CurrentStockQuantity get(String id) throws Exception {
        try {
            return (CurrentStockQuantity) currentStockQuantityDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

//    public void save(CurrentStockQuantity currentStockQuantity) throws Exception {
//        try {
//            currentStockQuantityDAO.save(currentStockQuantity, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
//
//    public void update(CurrentStockQuantity currentStockQuantity) throws Exception {
//        try {
//            currentStockQuantityDAO.update(currentStockQuantity, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
//
//    public void delete(String id) throws Exception {
//        try {
//            currentStockQuantityDAO.delete(id, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
    
    public CurrentStockQuantityTemp getMin() throws Exception {
        try {
            return currentStockQuantityDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CurrentStockQuantityTemp getMax() throws Exception {
        try {
            return currentStockQuantityDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockQuantity.class)
                            .add(Restrictions.eq(CurrentStockQuantityField.CODE, code));
             
            if(currentStockQuantityDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public CurrentStockQuantityDAO getCurrentStockQuantityDAO() {
        return currentStockQuantityDAO;
    }

    public void setCurrentStockQuantityDAO(CurrentStockQuantityDAO currentStockQuantityDAO) {
        this.currentStockQuantityDAO = currentStockQuantityDAO;
    }
    
}
