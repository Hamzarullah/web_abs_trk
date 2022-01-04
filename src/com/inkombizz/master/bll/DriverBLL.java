package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.DriverDAO;
import com.inkombizz.master.model.Driver;
import com.inkombizz.master.model.DriverField;
import com.inkombizz.master.model.DriverTemp;
import org.hibernate.criterion.Restrictions;

public class DriverBLL {
    public static final String MODULECODE = "006_MST_DRIVER";
    
    private DriverDAO driverDAO;

    public DriverBLL(HBMSession hbmSession) {
        this.driverDAO = new DriverDAO(hbmSession);
    }
	
    public ListPaging<Driver> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Driver.class);

            paging.setRecords(driverDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Driver> listDriver = driverDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Driver> listPaging = new ListPaging<Driver>();

            listPaging.setList(listDriver);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<DriverTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Driver.class);           
    
            paging.setRecords(driverDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DriverTemp> listDriverTemp = driverDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DriverTemp> listPaging = new ListPaging<DriverTemp>();
            
            listPaging.setList(listDriverTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<Driver> search(Paging paging, String code, 
                                  String name,Enum_TriState activeStatus
                                 ) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Driver.class)
                    .add(Restrictions.like(DriverField.CODE, "%" + code + "%" ))
                    .add(Restrictions.like(DriverField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(DriverField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(DriverField.ACTIVESTATUS, false));
            
            paging.setRecords(driverDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Driver> listDriver = driverDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Driver> listPaging = new ListPaging<Driver>();
            
            listPaging.setList(listDriver);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public List<Driver> getDuplicateEntry(String code, String name) throws Exception {
        try {            
            return driverDAO.getDuplicateEntry(code, name);
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public List<Driver> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Driver.class);
            List<Driver> listDriver = driverDAO.findByCriteria(criteria);
            return listDriver;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public Driver get(String code) throws Exception {
        try {
            return (Driver) driverDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Driver.class)
                            .add(Restrictions.eq(DriverField.CODE, headerCode));
             
            if(driverDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public void save(Driver driver) throws Exception {
        try {
            driverDAO.save(driver, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Driver driver) throws Exception {
        try {
            driverDAO.update(driver, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String code) throws Exception {
        try {
            driverDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
}
