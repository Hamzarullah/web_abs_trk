
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.EmployeeDAO;
import com.inkombizz.master.model.Employee;
import com.inkombizz.master.model.EmployeeField;
import com.inkombizz.master.model.EmployeeTemp;

public class EmployeeBLL {
    
    public static final String MODULECODE = "006_MST_EMPLOYEE";
    
    private EmployeeDAO employeeDAO;
    
    public EmployeeBLL (HBMSession hbmSession) {
        this.employeeDAO = new EmployeeDAO(hbmSession);
    }
    
    public ListPaging<EmployeeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Employee.class);           
    
            paging.setRecords(employeeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<EmployeeTemp> listemployeeTemp = employeeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<EmployeeTemp> listPaging = new ListPaging<EmployeeTemp>();
            
            listPaging.setList(listemployeeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public EmployeeTemp findData(String code) throws Exception {
        try {
            return (EmployeeTemp) employeeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public EmployeeTemp findData(String code,boolean active) throws Exception {
        try {
            return (EmployeeTemp) employeeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void save(Employee employee) throws Exception {
        try {
            employeeDAO.save(employee, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void update(Employee employee) throws Exception {
        try {
            employeeDAO.update(employee, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void delete(String code) throws Exception {
        try {
            employeeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;

            DetachedCriteria criteria = DetachedCriteria.forClass(Employee.class)
                            .add(Restrictions.eq(EmployeeField.CODE, code));

            if(employeeDAO.countByCriteria(criteria) > 0)
                 exist = true;

            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
 
    
    public EmployeeTemp min() throws Exception {
        try {
            return employeeDAO.min();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public EmployeeTemp max() throws Exception {
        try {
            return employeeDAO.max();
        }
        catch (Exception e) {
            throw e;
        }
    }

    public EmployeeDAO getEmployeeDAO() {
        return employeeDAO;
    }

    public void setEmployeeDAO(EmployeeDAO employeeDAO) {
        this.employeeDAO = employeeDAO;
    }
}
