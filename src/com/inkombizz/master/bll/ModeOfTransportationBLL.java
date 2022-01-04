
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ModeOfTransportationDAO;
import com.inkombizz.master.model.ModeOfTransportationTemp;
import com.inkombizz.master.model.ModeOfTransportation;
import com.inkombizz.master.model.ModeOfTransportationField;


public class ModeOfTransportationBLL {
    
    public final String MODULECODE = "006_MST_MODE_OF_TRANSPORTATION";
    
    private ModeOfTransportationDAO modeOfTransportationDAO;
    
    public ModeOfTransportationBLL(HBMSession hbmSession){
        this.modeOfTransportationDAO=new ModeOfTransportationDAO(hbmSession);
    }
    
    public ListPaging<ModeOfTransportationTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ModeOfTransportation.class);           
    
            paging.setRecords(modeOfTransportationDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ModeOfTransportationTemp> listModeOfTransportationTemp = modeOfTransportationDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ModeOfTransportationTemp> listPaging = new ListPaging<ModeOfTransportationTemp>();
            
            listPaging.setList(listModeOfTransportationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ModeOfTransportation> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ModeOfTransportation.class)
                    .add(Restrictions.like(ModeOfTransportationField.CODE, code + "%" ))
                    .add(Restrictions.like(ModeOfTransportationField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ModeOfTransportationField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ModeOfTransportationField.ACTIVESTATUS, false));
            
            paging.setRecords(modeOfTransportationDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ModeOfTransportation> listModeOfTransportation = modeOfTransportationDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ModeOfTransportation> listPaging = new ListPaging<ModeOfTransportation>();
            
            listPaging.setList(listModeOfTransportation);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ModeOfTransportationTemp findData(String code) throws Exception {
        try {
            return (ModeOfTransportationTemp) modeOfTransportationDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ModeOfTransportationTemp findData(String code,boolean active) throws Exception {
        try {
            return (ModeOfTransportationTemp) modeOfTransportationDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ModeOfTransportation modeOfTransportation) throws Exception {
        try {
            modeOfTransportationDAO.save(modeOfTransportation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ModeOfTransportation modeOfTransportation) throws Exception {
        try {
            modeOfTransportationDAO.update(modeOfTransportation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            modeOfTransportationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ModeOfTransportation.class)
                            .add(Restrictions.eq(ModeOfTransportationField.CODE, code));
             
            if(modeOfTransportationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
