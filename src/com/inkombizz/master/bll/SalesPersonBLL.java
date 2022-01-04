
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.SalesPersonDAO;
import com.inkombizz.master.model.SalesPerson;
import com.inkombizz.master.model.SalesPersonDistributionChannel;
import com.inkombizz.master.model.SalesPersonDistributionChannelTemp;
import com.inkombizz.master.model.SalesPersonField;
import com.inkombizz.master.model.SalesPersonItemProductHead;
import com.inkombizz.master.model.SalesPersonItemProductHeadTemp;
import com.inkombizz.master.model.SalesPersonTemp;

public class SalesPersonBLL {
    
    public static final String MODULECODE = "006_MST_SALES_PERSON";
    
    private SalesPersonDAO salesPersonDAO;
    
    public SalesPersonBLL (HBMSession hbmSession) {
        this.salesPersonDAO = new SalesPersonDAO(hbmSession);
    }
    
    public ListPaging<SalesPersonTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(SalesPerson.class);           
    
            paging.setRecords(salesPersonDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<SalesPersonTemp> listMarketingTemp = salesPersonDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<SalesPersonTemp> listPaging = new ListPaging<SalesPersonTemp>();
            
            listPaging.setList(listMarketingTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public SalesPersonTemp findData(String code) throws Exception {
        try {
            return (SalesPersonTemp) salesPersonDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public SalesPersonTemp findData(String code,boolean active) throws Exception {
        try {
            return (SalesPersonTemp) salesPersonDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void save(SalesPerson salesPerson) throws Exception {
        try {
            salesPersonDAO.save(salesPerson, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void update(SalesPerson salesPerson) throws Exception {
        try {
            salesPersonDAO.update(salesPerson, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String code) throws Exception {
        try {
            salesPersonDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;

            DetachedCriteria criteria = DetachedCriteria.forClass(SalesPerson.class)
                            .add(Restrictions.eq(SalesPersonField.CODE, code));

            if(salesPersonDAO.countByCriteria(criteria) > 0)
                 exist = true;

            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
 
    
    public SalesPersonTemp min() throws Exception {
        try {
            return salesPersonDAO.min();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public SalesPersonTemp max() throws Exception {
        try {
            return salesPersonDAO.max();
        }
        catch (Exception e) {
            throw e;
        }
    }

   
}
