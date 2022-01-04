
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CurrentStockCogsIdrDAO;
import com.inkombizz.master.model.CurrentStockCogsIdr;
import com.inkombizz.master.model.CurrentStockCogsIdrField;
import com.inkombizz.master.model.CurrentStockCogsIdrTemp;

public class CurrentStockCogsIdrBLL {
 
    public static final String MODULECODE = "006_MST_CURRENT_STOCK_COGSIDR";
    
    private CurrentStockCogsIdrDAO currentStockCogsIdrDAO;
    
    public CurrentStockCogsIdrBLL (HBMSession hbmSession) {
        this.currentStockCogsIdrDAO = new CurrentStockCogsIdrDAO(hbmSession);
    }
     
    public ListPaging<CurrentStockCogsIdr> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockCogsIdr.class);

            paging.setRecords(currentStockCogsIdrDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<CurrentStockCogsIdr> listCurrentStockCogsIdr = currentStockCogsIdrDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<CurrentStockCogsIdr> listPaging = new ListPaging<CurrentStockCogsIdr>();

            listPaging.setList(listCurrentStockCogsIdr);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<CurrentStockCogsIdrTemp> findData(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockCogsIdr.class);           
    
            paging.setRecords(currentStockCogsIdrDAO.countData());
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrentStockCogsIdrTemp> listCurrentStockCogsIdrTemp = currentStockCogsIdrDAO.findData(paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrentStockCogsIdrTemp> listPaging = new ListPaging<CurrentStockCogsIdrTemp>();
            
            listPaging.setList(listCurrentStockCogsIdrTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<CurrentStockCogsIdrTemp> searchData(String warehouseCode,String warehouseName,String itemCode,String itemName,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockCogsIdr.class);           
    
            paging.setRecords(currentStockCogsIdrDAO.countDataSearch(warehouseCode,warehouseName,itemCode,itemName));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrentStockCogsIdrTemp> listCurrentStockCogsIdrTemp = currentStockCogsIdrDAO.findDataSearch(warehouseCode,warehouseName,itemCode,itemName,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrentStockCogsIdrTemp> listPaging = new ListPaging<CurrentStockCogsIdrTemp>();
            
            listPaging.setList(listCurrentStockCogsIdrTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<CurrentStockCogsIdr> search(Paging paging, String code, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockCogsIdr.class)
                    .add(Restrictions.like(CurrentStockCogsIdrField.CODE, code + "%" ));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(CurrentStockCogsIdrField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(CurrentStockCogsIdrField.ACTIVESTATUS, false));
            
            paging.setRecords(currentStockCogsIdrDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrentStockCogsIdr> listCurrentStockCogsIdr = currentStockCogsIdrDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrentStockCogsIdr> listPaging = new ListPaging<CurrentStockCogsIdr>();
            
            listPaging.setList(listCurrentStockCogsIdr);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CurrentStockCogsIdr> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockCogsIdr.class);
            List<CurrentStockCogsIdr> listCurrentStockCogsIdr = currentStockCogsIdrDAO.findByCriteria(criteria);
            return listCurrentStockCogsIdr;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CurrentStockCogsIdr get(String id) throws Exception {
        try {
            return (CurrentStockCogsIdr) currentStockCogsIdrDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

//    public void save(CurrentStockCogsIdr currentStockCogsIdr) throws Exception {
//        try {
//            currentStockCogsIdrDAO.save(currentStockCogsIdr, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
//
//    public void update(CurrentStockCogsIdr currentStockCogsIdr) throws Exception {
//        try {
//            currentStockCogsIdrDAO.update(currentStockCogsIdr, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
//
//    public void delete(String id) throws Exception {
//        try {
//            currentStockCogsIdrDAO.delete(id, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
    
    public CurrentStockCogsIdrTemp getMin() throws Exception {
        try {
            return currentStockCogsIdrDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CurrentStockCogsIdrTemp getMax() throws Exception {
        try {
            return currentStockCogsIdrDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CurrentStockCogsIdr.class)
                            .add(Restrictions.eq(CurrentStockCogsIdrField.CODE, code));
             
            if(currentStockCogsIdrDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
