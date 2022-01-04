
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.UnitOfMeasureDAO;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasureField;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasureField;
import com.inkombizz.master.model.UnitOfMeasureTemp;


public class UnitOfMeasureBLL {
    
    public final String MODULECODE = "006_MST_UNIT_OF_MEASURE";
    
    private UnitOfMeasureDAO unitOfMeasureDAO;
    
    public UnitOfMeasureBLL(HBMSession hbmSession){
        this.unitOfMeasureDAO=new UnitOfMeasureDAO(hbmSession);
    }
    
    public ListPaging<UnitOfMeasureTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(UnitOfMeasure.class);           
    
            paging.setRecords(unitOfMeasureDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<UnitOfMeasureTemp> listUnitOfMeasureTemp = unitOfMeasureDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<UnitOfMeasureTemp> listPaging = new ListPaging<UnitOfMeasureTemp>();
            
            listPaging.setList(listUnitOfMeasureTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<UnitOfMeasure> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(UnitOfMeasure.class)
                    .add(Restrictions.like(UnitOfMeasureField.CODE, code + "%" ))
                    .add(Restrictions.like(UnitOfMeasureField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(UnitOfMeasureField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(UnitOfMeasureField.ACTIVESTATUS, false));
            
            paging.setRecords(unitOfMeasureDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<UnitOfMeasure> listUnitOfMeasure = unitOfMeasureDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<UnitOfMeasure> listPaging = new ListPaging<UnitOfMeasure>();
            
            listPaging.setList(listUnitOfMeasure);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public UnitOfMeasureTemp findData(String code) throws Exception {
        try {
            return (UnitOfMeasureTemp) unitOfMeasureDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public UnitOfMeasureTemp findData(String code,boolean active) throws Exception {
        try {
            return (UnitOfMeasureTemp) unitOfMeasureDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(UnitOfMeasure unitOfMeasure) throws Exception {
        try {
            unitOfMeasureDAO.save(unitOfMeasure, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(UnitOfMeasure unitOfMeasure) throws Exception {
        try {
            unitOfMeasureDAO.update(unitOfMeasure, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            unitOfMeasureDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(UnitOfMeasure.class)
                            .add(Restrictions.eq(UnitOfMeasureField.CODE, code));
             
            if(unitOfMeasureDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
