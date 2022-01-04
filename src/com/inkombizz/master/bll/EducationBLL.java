
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.EducationDAO;
import com.inkombizz.master.model.Education;
import com.inkombizz.master.model.EducationField;
import com.inkombizz.master.model.EducationTemp;


public class EducationBLL {
    
    public final String MODULECODE = "006_MST_EDUCATION";
    
    private EducationDAO educationDAO;
    
    public EducationBLL(HBMSession hbmSession){
        this.educationDAO=new EducationDAO(hbmSession);
    }
    
    public ListPaging<EducationTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Education.class);           
    
            paging.setRecords(educationDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<EducationTemp> listEducationTemp = educationDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<EducationTemp> listPaging = new ListPaging<EducationTemp>();
            
            listPaging.setList(listEducationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public EducationTemp findData(String code) throws Exception {
        try {
            return (EducationTemp) educationDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public EducationTemp findData(String code,boolean active) throws Exception {
        try {
            return (EducationTemp) educationDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Education education) throws Exception {
        try {
            educationDAO.save(education, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Education education) throws Exception {
        try {
            educationDAO.update(education, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            educationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Education.class)
                            .add(Restrictions.eq(EducationField.CODE, code));
             
            if(educationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
