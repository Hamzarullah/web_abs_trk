
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemOperatorDAO;
import com.inkombizz.master.model.ItemOperator;
import com.inkombizz.master.model.ItemOperatorField;
import com.inkombizz.master.model.ItemOperatorTemp;


public class ItemOperatorBLL {
    
    public final String MODULECODE = "006_MST_ITEM_OPERATOR";
    
    private ItemOperatorDAO itemOperatorDAO;
    
    public ItemOperatorBLL(HBMSession hbmSession){
        this.itemOperatorDAO=new ItemOperatorDAO(hbmSession);
    }
    
    public ListPaging<ItemOperatorTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemOperator.class);           
    
            paging.setRecords(itemOperatorDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemOperatorTemp> listItemOperatorTemp = itemOperatorDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemOperatorTemp> listPaging = new ListPaging<ItemOperatorTemp>();
            
            listPaging.setList(listItemOperatorTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemOperatorTemp findData(String code) throws Exception {
        try {
            return (ItemOperatorTemp) itemOperatorDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemOperatorTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemOperatorTemp) itemOperatorDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemOperator itemOperator) throws Exception {
        try {
            itemOperatorDAO.save(itemOperator, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemOperator itemOperator) throws Exception {
        try {
            itemOperatorDAO.update(itemOperator, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemOperatorDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemOperator.class)
                            .add(Restrictions.eq(ItemOperatorField.CODE, code));
             
            if(itemOperatorDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
