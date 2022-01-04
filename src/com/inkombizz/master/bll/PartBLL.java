
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.PartDAO;
import com.inkombizz.master.model.PartTemp;
import com.inkombizz.master.model.Part;
import com.inkombizz.master.model.PartField;


public class PartBLL {
    
    public final String MODULECODE = "006_MST_PART";
    
    private PartDAO partDAO;
    
    public PartBLL(HBMSession hbmSession){
        this.partDAO=new PartDAO(hbmSession);
    }
    
    public ListPaging<PartTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Part.class);           
    
            paging.setRecords(partDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PartTemp> listPartTemp = partDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PartTemp> listPaging = new ListPaging<PartTemp>();
            
            listPaging.setList(listPartTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<Part> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Part.class)
                    .add(Restrictions.like(PartField.CODE, code + "%" ))
                    .add(Restrictions.like(PartField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(PartField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(PartField.ACTIVESTATUS, false));
            
            paging.setRecords(partDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Part> listPart = partDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Part> listPaging = new ListPaging<Part>();
            
            listPaging.setList(listPart);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public PartTemp findData(String code) throws Exception {
        try {
            return (PartTemp) partDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public PartTemp findData(String code,boolean active) throws Exception {
        try {
            return (PartTemp) partDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Part part) throws Exception {
        try {
            partDAO.save(part, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Part part) throws Exception {
        try {
            partDAO.update(part, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            partDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Part.class)
                            .add(Restrictions.eq(PartField.CODE, code));
             
            if(partDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
