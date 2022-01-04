
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.JobPositionDAO;
import com.inkombizz.master.model.JobPosition;
import com.inkombizz.master.model.JobPositionField;
import com.inkombizz.master.model.JobPositionTemp;


public class JobPositionBLL {
    
    public static final String MODULECODE = "006_MST_JOB_POSITION";
    
    private JobPositionDAO jobPositionDAO;
    
    public JobPositionBLL(HBMSession hbmSession){
        this.jobPositionDAO=new JobPositionDAO(hbmSession);
    }
    
    public ListPaging<JobPositionTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(JobPosition.class);           
    
            paging.setRecords(jobPositionDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<JobPositionTemp> listJobPositionTemp = jobPositionDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<JobPositionTemp> listPaging = new ListPaging<JobPositionTemp>();
            
            listPaging.setList(listJobPositionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public JobPositionTemp findData(String code) throws Exception {
        try {
            return (JobPositionTemp) jobPositionDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public JobPositionTemp findData(String code,boolean active) throws Exception {
        try {
            return (JobPositionTemp) jobPositionDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(JobPosition jobPosition) throws Exception {
        try {
            jobPositionDAO.save(jobPosition, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(JobPosition jobPosition) throws Exception {
        try {
            jobPositionDAO.update(jobPosition, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            jobPositionDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(JobPosition.class)
                            .add(Restrictions.eq(JobPositionField.CODE, code));
             
            if(jobPositionDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
