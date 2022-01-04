package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CityDAO;
import com.inkombizz.master.model.City;
import com.inkombizz.master.model.CityField;
import com.inkombizz.master.model.CityTemp;

public class CityBLL {
    
    public final String MODULECODE = "006_MST_CITY";
    
    private CityDAO cityDAO;
    
    public CityBLL(HBMSession hbmSession) {
        this.cityDAO = new CityDAO(hbmSession);
    }
    
    public ListPaging<CityTemp> findData(Paging paging,String code, String name,String active) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(City.class);           
    
            paging.setRecords(cityDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CityTemp> listCityTemp = cityDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CityTemp> listPaging = new ListPaging<CityTemp>();
            
            listPaging.setList(listCityTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }      
    
        
    public CityTemp findData(String code) throws Exception {
        try {
            return (CityTemp) cityDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CityTemp findData(String code,boolean active) throws Exception {
        try {
            return (CityTemp) cityDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(City city) throws Exception {
        try {
            cityDAO.save(city, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(City city) throws Exception {
        try {
            cityDAO.update(city, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            cityDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
      
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(City.class)
                            .add(Restrictions.eq(CityField.CODE, code));
             
            if(cityDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
 
}