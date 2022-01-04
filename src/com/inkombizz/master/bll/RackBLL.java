package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.master.dao.RackDAO;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.RackField;
import com.inkombizz.master.model.RackTemp;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.master.model.WarehouseField;
import org.hibernate.criterion.Restrictions;

public class RackBLL {
    public static final String MODULECODE = "006_MST_RACK";
    
    private RackDAO rackDAO;
    
    public RackBLL(HBMSession hbmSession) {
        this.rackDAO = new RackDAO(hbmSession);
    }
    
    public ListPaging<Rack> find(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class);

            paging.setRecords(rackDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Rack> listRack = rackDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Rack> listPaging = new ListPaging<Rack>();

            listPaging.setList(listRack);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<RackTemp> findSearchData(String code, String name,String active,String userCode,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class);           
    
            paging.setRecords(rackDAO.countSearchData(code,name,active,userCode));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RackTemp> listRackTemp = rackDAO.findSearchData(code,name,active,userCode, paging.getFromRow(), paging.getToRow());
            
            ListPaging<RackTemp> listPaging = new ListPaging<RackTemp>();
            
            listPaging.setList(listRackTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
   
     public ListPaging<RackTemp> findSearchDataView(String code, String name,String warehouseCode, String warehouseName,String active,String userCode,Paging paging) throws Exception {
        try {
            paging.setRecords(rackDAO.countSearchDataView(code, name, warehouseCode, warehouseName, active,userCode));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RackTemp> listRackTemp = rackDAO.findSearchDataView(code, name, warehouseCode, warehouseName, active, userCode, paging.getFromRow(), paging.getToRow());
            
            ListPaging<RackTemp> listPaging = new ListPaging<RackTemp>();
            
            listPaging.setList(listRackTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<RackTemp> findSearchDataForRkm(String code, String name,String idWarehouseCode,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class);           
    
            paging.setRecords(rackDAO.countSearchDataForRkm(code,name,idWarehouseCode,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RackTemp> listRackTemp = rackDAO.findSearchDataForRkm(code,name,idWarehouseCode,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<RackTemp> listPaging = new ListPaging<RackTemp>();
            
            listPaging.setList(listRackTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
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
            
            paging.setRecords(rackDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Rack> listRack = rackDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Rack> listPaging = new ListPaging<Rack>();
            
            listPaging.setList(listRack);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<Rack> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class);
            List<Rack> listRack = rackDAO.findByCriteria(criteria);
            return listRack;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
   public ListPaging<RackTemp> findData1(String code, String name,String active,Paging paging) throws Exception {
        try {
            List<RackTemp> listRackTemp =  rackDAO.findData1(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<RackTemp> listPaging = new ListPaging<RackTemp>();
            
            listPaging.setList(listRackTemp); 
            listPaging.setPaging(paging);
            
            
            return listPaging;  
            
        }
        catch (Exception e) {
            throw e;
        }
    }
    
     public RackTemp get(String code) throws Exception {
        try {
            return (RackTemp) rackDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Rack rack) throws Exception {
        try {
            rackDAO.save(rack, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Rack rack) throws Exception {
        try {
            rackDAO.update(rack, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            rackDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public RackDAO getRackDAO() {
        return rackDAO;
    }

    public void setRackDAO(RackDAO rackDAO) {
        this.rackDAO = rackDAO;
    }
    
    public ListPaging<RackTemp> findData(Paging paging,String code, String name) throws Exception {
        try {

            paging.setRecords(rackDAO.countData(code,name));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RackTemp> listRackTemp = rackDAO.findData(code,name,paging.getFromRow(), paging.getToRow());
            
            ListPaging<RackTemp> listPaging = new ListPaging<RackTemp>();
            
            listPaging.setList(listRackTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public int isExistRackCategory(String warehouseCode) throws Exception {
        try {

            return rackDAO.isExistRackCategory(warehouseCode);
        } catch (Exception e) {
            throw e;
        }
    }
     public int rackCheckInRackItem(String headerCode) throws Exception {
        try {

            return rackDAO.rackCheckInRackItem(headerCode);
        } catch (Exception e) {
            throw e;
        }
    }
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Rack.class)
                            .add(Restrictions.eq(RackField.CODE, code));
             
            if(rackDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }  
    public static String getMODULECODE() {
        return MODULECODE;
    }
    
}