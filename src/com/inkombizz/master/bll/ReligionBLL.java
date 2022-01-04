
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ReligionDAO;
import com.inkombizz.master.model.Religion;
import com.inkombizz.master.model.ReligionField;
import com.inkombizz.master.model.ReligionTemp;

public class ReligionBLL {
 
    public static final String MODULECODE = "006_MST_RELIGION";
    
    private ReligionDAO religionDAO;
    
    public ReligionBLL (HBMSession hbmSession) {
        this.religionDAO = new ReligionDAO(hbmSession);
    }
     
    public ListPaging<Religion> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Religion.class);

            paging.setRecords(religionDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Religion> listReligion = religionDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Religion> listPaging = new ListPaging<Religion>();

            listPaging.setList(listReligion);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<Religion> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Religion.class)
                    .add(Restrictions.like(ReligionField.CODE, code + "%" ))
                    .add(Restrictions.like(ReligionField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ReligionField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ReligionField.ACTIVESTATUS, false));
            
            paging.setRecords(religionDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Religion> listReligion = religionDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Religion> listPaging = new ListPaging<Religion>();
            
            listPaging.setList(listReligion);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<Religion> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Religion.class);
            List<Religion> listReligion = religionDAO.findByCriteria(criteria);
            return listReligion;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public Religion get(String id) throws Exception {
        try {
            return (Religion) religionDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ReligionTemp findData(String code,boolean active) throws Exception {
        try {
            return (ReligionTemp) religionDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Religion religion) throws Exception {
        try {
            religionDAO.save(religion, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Religion religion) throws Exception {
        try {
            religionDAO.update(religion, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            religionDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ReligionTemp getMin() throws Exception {
        try {
            return religionDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ReligionTemp getMax() throws Exception {
        try {
            return religionDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Religion.class)
                            .add(Restrictions.eq(ReligionField.CODE, code));
             
            if(religionDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
