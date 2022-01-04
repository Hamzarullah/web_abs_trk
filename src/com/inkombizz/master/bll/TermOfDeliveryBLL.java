
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.TermOfDeliveryDAO;
import com.inkombizz.master.model.TermOfDelivery;
import com.inkombizz.master.model.TermOfDeliveryField;
import com.inkombizz.master.model.TermOfDeliveryTemp;


public class TermOfDeliveryBLL {
    
    public final String MODULECODE = "006_MST_TERM_OF_DELIVERY";
    
    private TermOfDeliveryDAO termOfDeliveryDAO;
    
    public TermOfDeliveryBLL(HBMSession hbmSession){
        this.termOfDeliveryDAO=new TermOfDeliveryDAO(hbmSession);
    }
    
    public ListPaging<TermOfDeliveryTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(TermOfDelivery.class);           
    
            paging.setRecords(termOfDeliveryDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<TermOfDeliveryTemp> listTermOfDeliveryTemp = termOfDeliveryDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<TermOfDeliveryTemp> listPaging = new ListPaging<TermOfDeliveryTemp>();
            
            listPaging.setList(listTermOfDeliveryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public TermOfDeliveryTemp findData(String code) throws Exception {
        try {
            return (TermOfDeliveryTemp) termOfDeliveryDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public TermOfDeliveryTemp findData(String code,boolean active) throws Exception {
        try {
            return (TermOfDeliveryTemp) termOfDeliveryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(TermOfDelivery termOfDelivery) throws Exception {
        try {
            termOfDeliveryDAO.save(termOfDelivery, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(TermOfDelivery termOfDelivery) throws Exception {
        try {
            termOfDeliveryDAO.update(termOfDelivery, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            termOfDeliveryDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(TermOfDelivery.class)
                            .add(Restrictions.eq(TermOfDeliveryField.CODE, code));
             
            if(termOfDeliveryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
