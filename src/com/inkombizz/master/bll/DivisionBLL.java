/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.DivisionDAO;
import com.inkombizz.master.model.Division;
import com.inkombizz.master.model.DivisionField;
import com.inkombizz.master.model.DivisionTemp;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class DivisionBLL {
     public static final String MODULECODE = "006_MST_DIVISION";
    
    private DivisionDAO departmentDAO;
    
    public DivisionBLL(HBMSession hbmSession) {
        this.departmentDAO = new DivisionDAO(hbmSession);
    }
    
    public ListPaging<DivisionTemp> findSearchData(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(departmentDAO.countSearchData(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DivisionTemp> listDivisionTemp = departmentDAO.findSearchData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<DivisionTemp> listPaging = new ListPaging<DivisionTemp>();
            
            listPaging.setList(listDivisionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    
    public ListPaging<DivisionTemp> findSearchDataWithUserAuth(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(departmentDAO.countSearchDataWithUserAuth(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DivisionTemp> listDivisionTemp = departmentDAO.findSearchDataWithUserAuth(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<DivisionTemp> listPaging = new ListPaging<DivisionTemp>();
            
            listPaging.setList(listDivisionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    
    public ListPaging<Division> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Division.class);

            paging.setRecords(departmentDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Division> listDivision = departmentDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Division> listPaging = new ListPaging<Division>();

            listPaging.setList(listDivision);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<Division> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Division.class)
                    .add(Restrictions.like(DivisionField.CODE, code + "%" ))
                    .add(Restrictions.like(DivisionField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(DivisionField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(DivisionField.ACTIVESTATUS, false));
            
            paging.setRecords(departmentDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Division> listDivision = departmentDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Division> listPaging = new ListPaging<Division>();
            
            listPaging.setList(listDivision);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<Division> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Division.class);
            List<Division> listDivision = departmentDAO.findByCriteria(criteria);
            return listDivision;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public DivisionTemp findData(String code,boolean active) throws Exception {
        try {
            return (DivisionTemp) departmentDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }    
    
    public DivisionTemp findDataWithUserAuth(String code,boolean active) throws Exception {
        try {
            return (DivisionTemp) departmentDAO.findDataWithUserAuth(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }    
    
    public DivisionTemp findData(String code) throws Exception {
        try {
            return (DivisionTemp) departmentDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Division department) throws Exception {
        try {
            departmentDAO.save(department, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Division department) throws Exception {
        try {
            departmentDAO.update(department, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            departmentDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<DivisionTemp> polulateSearchDataWithArray(String code, String name, String concat, Paging paging) throws Exception {
        try {
                     
            paging.setRecords(departmentDAO.countSearchDataWithArray(code, name, concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DivisionTemp> listDivisionTemp = departmentDAO.findSearchDataWithArray(code,name, concat, paging.getFromRow(),paging.getToRow());
            
            ListPaging<DivisionTemp> listPaging = new ListPaging<DivisionTemp>();
            
            listPaging.setList(listDivisionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }  

    public DivisionDAO getDivisionDAO() {
        return departmentDAO;
    }

    public void setDivisionDAO(DivisionDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }
    
}