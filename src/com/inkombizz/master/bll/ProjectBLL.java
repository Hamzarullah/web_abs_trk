
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ProjectDAO;
import com.inkombizz.master.model.Project;
import com.inkombizz.master.model.ProjectField;
import com.inkombizz.master.model.ProjectTemp;


public class ProjectBLL {
    
    public final String MODULECODE = "006_MST_BANK";
    
    private ProjectDAO projectDAO;
    
    public ProjectBLL(HBMSession hbmSession){
        this.projectDAO=new ProjectDAO(hbmSession);
    }
    
    public ListPaging<ProjectTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Project.class);           
    
            paging.setRecords(projectDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ProjectTemp> listProjectTemp = projectDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProjectTemp> listPaging = new ListPaging<ProjectTemp>();
            
            listPaging.setList(listProjectTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ProjectTemp findData(String code) throws Exception {
        try {
            return (ProjectTemp) projectDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ProjectTemp findData(String code,boolean active) throws Exception {
        try {
            return (ProjectTemp) projectDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Project project) throws Exception {
        try {
            projectDAO.save(project, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Project project) throws Exception {
        try {
            projectDAO.update(project, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            projectDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Project.class)
                            .add(Restrictions.eq(ProjectField.CODE, code));
             
            if(projectDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
