
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.WarehouseDAO;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.master.model.WarehouseField;
import com.inkombizz.master.model.WarehouseTemp;


public class WarehouseBLL {
    
    public final String MODULECODE = "006_MST_WAREHOUSE";
    
    private WarehouseDAO warehouseDAO;
    
    public WarehouseBLL(HBMSession hbmSession){
        this.warehouseDAO=new WarehouseDAO(hbmSession);
    }
    
    public ListPaging<WarehouseTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Warehouse.class);           
    
            paging.setRecords(warehouseDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<WarehouseTemp> listWarehouseTemp = warehouseDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<WarehouseTemp> listPaging = new ListPaging<WarehouseTemp>();
            
            listPaging.setList(listWarehouseTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public WarehouseTemp findData(String code) throws Exception {
        try {
            return (WarehouseTemp) warehouseDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public WarehouseTemp findData(String code,boolean active) throws Exception {
        try {
            return (WarehouseTemp) warehouseDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Warehouse warehouse) throws Exception {
        try {
            warehouseDAO.save(warehouse, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Warehouse warehouse) throws Exception {
        try {
            warehouseDAO.update(warehouse, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            warehouseDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Warehouse.class)
                            .add(Restrictions.eq(WarehouseField.CODE, code));
             
            if(warehouseDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
