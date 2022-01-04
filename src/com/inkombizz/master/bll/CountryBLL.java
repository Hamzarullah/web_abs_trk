
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CountryDAO;
import com.inkombizz.master.model.Country;
import com.inkombizz.master.model.CountryField;
import com.inkombizz.master.model.CountryTemp;


public class CountryBLL {
    
    public final String MODULECODE = "006_MST_COUNTRY";
    
    private CountryDAO countryDAO;
    
    public CountryBLL(HBMSession hbmSession){
        this.countryDAO=new CountryDAO(hbmSession);
    }
    
    public ListPaging<CountryTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Country.class);           
    
            paging.setRecords(countryDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CountryTemp> listCountryTemp = countryDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CountryTemp> listPaging = new ListPaging<CountryTemp>();
            
            listPaging.setList(listCountryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public CountryTemp findData(String code) throws Exception {
        try {
            return (CountryTemp) countryDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CountryTemp findData(String code,boolean active) throws Exception {
        try {
            return (CountryTemp) countryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Country country) throws Exception {
        try {
            countryDAO.save(country, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Country country) throws Exception {
        try {
            countryDAO.update(country, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            countryDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Country.class)
                            .add(Restrictions.eq(CountryField.CODE, code));
             
            if(countryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
