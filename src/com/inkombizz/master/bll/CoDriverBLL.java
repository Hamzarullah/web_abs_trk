package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.CoDriverDAO;
import com.inkombizz.master.model.CoDriver;
import com.inkombizz.master.model.CoDriverField;
import com.inkombizz.master.model.CoDriverTemp;
import org.hibernate.criterion.Restrictions;

public class CoDriverBLL {
    public static final String MODULECODE = "006_MST_CO_DRIVER";
    
    private CoDriverDAO coDriverDAO;

    public CoDriverBLL(HBMSession hbmSession) {
        this.coDriverDAO = new CoDriverDAO(hbmSession);
    }
	
    public ListPaging<CoDriver> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CoDriver.class);

            paging.setRecords(coDriverDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<CoDriver> listCoDriver = coDriverDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<CoDriver> listPaging = new ListPaging<CoDriver>();

            listPaging.setList(listCoDriver);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<CoDriverTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CoDriver.class);           
    
            paging.setRecords(coDriverDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CoDriverTemp> listCoDriverTemp = coDriverDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CoDriverTemp> listPaging = new ListPaging<CoDriverTemp>();
            
            listPaging.setList(listCoDriverTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CoDriver> search(Paging paging, String code, 
                                  String name,Enum_TriState activeStatus
                                 ) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CoDriver.class)
                    .add(Restrictions.like(CoDriverField.CODE, "%" + code + "%" ))
                    .add(Restrictions.like(CoDriverField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(CoDriverField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(CoDriverField.ACTIVESTATUS, false));
            
            paging.setRecords(coDriverDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CoDriver> listCoDriver = coDriverDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CoDriver> listPaging = new ListPaging<CoDriver>();
            
            listPaging.setList(listCoDriver);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public List<CoDriver> getDuplicateEntry(String code, String name) throws Exception {
        try {            
            return coDriverDAO.getDuplicateEntry(code, name);
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public List<CoDriver> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CoDriver.class);
            List<CoDriver> listCoDriver = coDriverDAO.findByCriteria(criteria);
            return listCoDriver;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CoDriver get(String code) throws Exception {
        try {
            return (CoDriver) coDriverDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CoDriver.class)
                            .add(Restrictions.eq(CoDriverField.CODE, headerCode));
             
            if(coDriverDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public void save(CoDriver coDriver) throws Exception {
        try {
            coDriverDAO.save(coDriver, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(CoDriver coDriver) throws Exception {
        try {
            coDriverDAO.update(coDriver, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String code) throws Exception {
        try {
            coDriverDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
}
