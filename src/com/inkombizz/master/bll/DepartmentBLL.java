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
import com.inkombizz.master.dao.DepartmentDAO;
import com.inkombizz.master.model.Department;
import com.inkombizz.master.model.DepartmentField;
import com.inkombizz.master.model.DepartmentTemp;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Rayis
 */
public class DepartmentBLL {
     public static final String MODULECODE = "006_MST_DEPARTMENT";
    
    private DepartmentDAO departmentDAO;
    
    public DepartmentBLL(HBMSession hbmSession) {
        this.departmentDAO = new DepartmentDAO(hbmSession);
    }
    
    public ListPaging<DepartmentTemp> findSearchData(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(departmentDAO.countSearchData(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DepartmentTemp> listDepartmentTemp = departmentDAO.findSearchData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<DepartmentTemp> listPaging = new ListPaging<DepartmentTemp>();
            
            listPaging.setList(listDepartmentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    
    public ListPaging<Department> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Department.class);

            paging.setRecords(departmentDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Department> listDepartment = departmentDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Department> listPaging = new ListPaging<Department>();

            listPaging.setList(listDepartment);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<Department> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Department.class)
                    .add(Restrictions.like(DepartmentField.CODE, code + "%" ))
                    .add(Restrictions.like(DepartmentField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(DepartmentField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(DepartmentField.ACTIVESTATUS, false));
            
            paging.setRecords(departmentDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Department> listDepartment = departmentDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Department> listPaging = new ListPaging<Department>();
            
            listPaging.setList(listDepartment);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<Department> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Department.class);
            List<Department> listDepartment = departmentDAO.findByCriteria(criteria);
            return listDepartment;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public DepartmentTemp findData(String code,boolean active) throws Exception {
        try {
            return (DepartmentTemp) departmentDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }    
    
    public DepartmentTemp findData(String code) throws Exception {
        try {
            return (DepartmentTemp) departmentDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Department department) throws Exception {
        try {
            departmentDAO.save(department, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Department department) throws Exception {
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
    
    public ListPaging<DepartmentTemp> polulateSearchDataWithArray(String code, String name, String concat, Paging paging) throws Exception {
        try {
                     
            paging.setRecords(departmentDAO.countSearchDataWithArray(code, name, concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DepartmentTemp> listDivisionTemp = departmentDAO.findSearchDataWithArray(code,name, concat, paging.getFromRow(),paging.getToRow());
            
            ListPaging<DepartmentTemp> listPaging = new ListPaging<DepartmentTemp>();
            
            listPaging.setList(listDivisionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }  

    public DepartmentDAO getDepartmentDAO() {
        return departmentDAO;
    }

    public void setDepartmentDAO(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }
    
}