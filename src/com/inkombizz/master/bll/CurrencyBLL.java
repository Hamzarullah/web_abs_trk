
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CurrencyDAO;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.CurrencyField;
import com.inkombizz.master.model.CurrencyTemp;


public class CurrencyBLL {
    
    public final String MODULECODE = "006_MST_CURRENCY";
    
    private CurrencyDAO currencyDAO;
    
    public CurrencyBLL(HBMSession hbmSession){
        this.currencyDAO=new CurrencyDAO(hbmSession);
    }
    
    public ListPaging<CurrencyTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Currency.class);           
    
            paging.setRecords(currencyDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CurrencyTemp> listCurrencyTemp = currencyDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CurrencyTemp> listPaging = new ListPaging<CurrencyTemp>();
            
            listPaging.setList(listCurrencyTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public CurrencyTemp findData(String code) throws Exception {
        try {
            return (CurrencyTemp) currencyDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CurrencyTemp findData(String code,boolean active) throws Exception {
        try {
            return (CurrencyTemp) currencyDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Currency currency) throws Exception {
        try {
            currencyDAO.save(currency, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Currency currency) throws Exception {
        try {
            currencyDAO.update(currency, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            currencyDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Currency.class)
                            .add(Restrictions.eq(CurrencyField.CODE, code));
             
            if(currencyDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
