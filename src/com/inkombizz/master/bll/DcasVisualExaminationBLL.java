
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasVisualExaminationDAO;
import com.inkombizz.master.model.DcasVisualExamination;
import com.inkombizz.master.model.DcasVisualExaminationField;
import com.inkombizz.master.model.DcasVisualExaminationTemp;


public class DcasVisualExaminationBLL {
    
    public final String MODULECODE = "006_MST_DCAS_VISUAL_EXAMINATION";
    
    private DcasVisualExaminationDAO dcasVisualExaminationDAO;
    
    public DcasVisualExaminationBLL(HBMSession hbmSession){
        this.dcasVisualExaminationDAO=new DcasVisualExaminationDAO(hbmSession);
    }
    
    public ListPaging<DcasVisualExaminationTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasVisualExamination.class);           
    
            paging.setRecords(dcasVisualExaminationDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasVisualExaminationTemp> listDcasVisualExaminationTemp = dcasVisualExaminationDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasVisualExaminationTemp> listPaging = new ListPaging<DcasVisualExaminationTemp>();
            
            listPaging.setList(listDcasVisualExaminationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasVisualExaminationTemp findData(String code) throws Exception {
        try {
            return (DcasVisualExaminationTemp) dcasVisualExaminationDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasVisualExaminationTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasVisualExaminationTemp) dcasVisualExaminationDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasVisualExamination dcasVisualExamination) throws Exception {
        try {
            dcasVisualExaminationDAO.save(dcasVisualExamination, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasVisualExamination dcasVisualExamination) throws Exception {
        try {
            dcasVisualExaminationDAO.update(dcasVisualExamination, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasVisualExaminationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasVisualExamination.class)
                            .add(Restrictions.eq(DcasVisualExaminationField.CODE, code));
             
            if(dcasVisualExaminationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
