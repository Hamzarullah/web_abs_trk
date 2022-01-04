
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ValveTypeComponentDAO;
import com.inkombizz.master.model.ValveTypeComponentTemp;
import com.inkombizz.master.model.ValveTypeComponent;
import com.inkombizz.master.model.ValveTypeComponentDetail;
import com.inkombizz.master.model.ValveTypeComponentDetailTemp;
import com.inkombizz.master.model.ValveTypeComponentField;
import com.inkombizz.master.model.ValveTypeTemp;


public class ValveTypeComponentBLL {
    
    public final String MODULECODE = "006_MST_VALVE_TYPE_COMPONENT";
    
    private ValveTypeComponentDAO valveTypeComponentDAO;
    
    public ValveTypeComponentBLL(HBMSession hbmSession){
        this.valveTypeComponentDAO=new ValveTypeComponentDAO(hbmSession);
    }
    
    public ListPaging<ValveTypeComponentTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ValveTypeComponent.class);           
    
            paging.setRecords(valveTypeComponentDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ValveTypeComponentTemp> listValveTypeComponentTemp = valveTypeComponentDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ValveTypeComponentTemp> listPaging = new ListPaging<ValveTypeComponentTemp>();
            
            listPaging.setList(listValveTypeComponentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<ValveTypeComponentDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<ValveTypeComponentDetailTemp> listValveTypeComponentDetailTemp = valveTypeComponentDAO.findDataDetail(headerCode);
            
            return listValveTypeComponentDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ValveTypeComponent> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ValveTypeComponent.class)
                    .add(Restrictions.like(ValveTypeComponentField.CODE, code + "%" ))
                    .add(Restrictions.like(ValveTypeComponentField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ValveTypeComponentField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ValveTypeComponentField.ACTIVESTATUS, false));
            
            paging.setRecords(valveTypeComponentDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ValveTypeComponent> listValveTypeComponent = valveTypeComponentDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ValveTypeComponent> listPaging = new ListPaging<ValveTypeComponent>();
            
            listPaging.setList(listValveTypeComponent);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ValveTypeComponentTemp findData(String code) throws Exception {
        try {
            return (ValveTypeComponentTemp) valveTypeComponentDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ValveTypeComponentTemp findData(String code,boolean active) throws Exception {
        try {
            return (ValveTypeComponentTemp) valveTypeComponentDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ValveTypeComponent valveTypeComponent) throws Exception {
        try {
            valveTypeComponentDAO.update(valveTypeComponent, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<ValveTypeComponentTemp> getDataDetail(String headerCode) throws Exception {
        try {
            
            List<ValveTypeComponentTemp> listValveTypeComponentTemp = valveTypeComponentDAO.getDataDetail(headerCode);
            
            return listValveTypeComponentTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(ValveTypeComponent valveTypeComponent,List<ValveTypeComponentDetail> listValveTypeComponentDetail) throws Exception{
        valveTypeComponentDAO.save(valveTypeComponent,listValveTypeComponentDetail, MODULECODE);
    }
    
    public ValveTypeComponentDetailTemp checkValveType(String code) throws Exception {
        try {
            return (ValveTypeComponentDetailTemp) valveTypeComponentDAO.checkValveType(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ValveTypeComponent.class)
                            .add(Restrictions.eq(ValveTypeComponentField.CODE, code));
             
            if(valveTypeComponentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
