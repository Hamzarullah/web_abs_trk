
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.IslandDAO;
import com.inkombizz.master.model.Island;
import com.inkombizz.master.model.IslandField;
import com.inkombizz.master.model.IslandTemp;

public class IslandBLL {
 
    public static final String MODULECODE = "006_MST_ISLAND";
    
    private IslandDAO islandDAO;
    
    public IslandBLL (HBMSession hbmSession) {
        this.islandDAO = new IslandDAO(hbmSession);
    }
     
    
    public ListPaging<Island> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Island.class);

            paging.setRecords(islandDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Island> listIsland = islandDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Island> listPaging = new ListPaging<Island>();

            listPaging.setList(listIsland);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public IslandTemp findData(String code,boolean active) throws Exception {
        try {
            return (IslandTemp) islandDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public ListPaging<Island> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Island.class)
                    .add(Restrictions.like(IslandField.CODE, code + "%" ))
                    .add(Restrictions.like(IslandField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(IslandField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(IslandField.ACTIVESTATUS, false));
            
            paging.setRecords(islandDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Island> listIsland = islandDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Island> listPaging = new ListPaging<Island>();
            
            listPaging.setList(listIsland);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<Island> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Island.class);
            List<Island> listIsland = islandDAO.findByCriteria(criteria);
            return listIsland;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public Island get(String id) throws Exception {
        try {
            return (Island) islandDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Island island) throws Exception {
        try {
            islandDAO.save(island, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Island island) throws Exception {
        try {
            islandDAO.update(island, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            islandDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public IslandTemp getMin() throws Exception {
        try {
            return islandDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public IslandTemp getMax() throws Exception {
        try {
            return islandDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Island.class)
                            .add(Restrictions.eq(IslandField.CODE, code));
             
            if(islandDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public IslandDAO getIslandDAO() {
        return islandDAO;
    }

    public void setIslandDAO(IslandDAO islandDAO) {
        this.islandDAO = islandDAO;
    }
    
}
