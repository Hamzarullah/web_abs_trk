
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.RackItemDAO;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.RackField;
import com.inkombizz.master.model.RackItem;
import com.inkombizz.master.model.RackItemField;
import com.inkombizz.master.model.RackItemTemp;
import com.inkombizz.master.model.RackTemp;

public class RackItemBLL {
 
    public static final String MODULECODE = "006_MST_RACK_ITEM";
    
    private RackItemDAO rackItemDAO;
    
    public RackItemBLL (HBMSession hbmSession) {
        this.rackItemDAO = new RackItemDAO(hbmSession);
    }
     
    public ListPaging<Rack> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class);

            paging.setRecords(rackItemDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Rack> listRack = rackItemDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Rack> listPaging = new ListPaging<Rack>();

            listPaging.setList(listRack);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<RackItemTemp> findData(String code) throws Exception {
        try {
            List<RackItemTemp> listRackItemTemp = rackItemDAO.findData(code);
            ListPaging<RackItemTemp> listPaging = new ListPaging<RackItemTemp>();
            
            listPaging.setList(listRackItemTemp);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public List<RackItemTemp> getRackItem(String headerCode) throws Exception {
        try {

            List<RackItemTemp> listRackItemTemp = rackItemDAO.findDataRackItem(headerCode);

            return listRackItemTemp;
        } catch (Exception e) {
            throw e;
        }
    }
    public ListPaging<Rack> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class)
                    .add(Restrictions.like(RackField.CODE, code + "%" ))
                    .add(Restrictions.like(RackField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(RackField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(RackField.ACTIVESTATUS, false));
            
            paging.setRecords(rackItemDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Rack> listRack = rackItemDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Rack> listPaging = new ListPaging<Rack>();
            
            listPaging.setList(listRack);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    
    
    public List<RackItem> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(RackItem.class);
            List<RackItem> listRackItem = rackItemDAO.findByCriteria(criteria);
            return listRackItem;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public RackItem get(String id) throws Exception {
        try {
            return (RackItem) rackItemDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Rack rack,List<RackItem> listRackItem) throws Exception {
        try {
            rackItemDAO.save(rack,listRackItem, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(RackItem rackItem) throws Exception {
        try {
            rackItemDAO.update(rackItem, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            rackItemDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public RackItemTemp getMin() throws Exception {
        try {
            return rackItemDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public RackItemTemp getMax() throws Exception {
        try {
            return rackItemDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(RackItem.class)
                            .add(Restrictions.eq(RackItemField.CODE, code));
             
            if(rackItemDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public RackItemDAO getRackItemDAO() {
        return rackItemDAO;
    }

    public void setRackItemDAO(RackItemDAO rackItemDAO) {
        this.rackItemDAO = rackItemDAO;
    }

    public static String getMODULECODE() {
        return MODULECODE;
    }
    
    
}
