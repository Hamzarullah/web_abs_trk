package com.inkombizz.security.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.dao.RoleDAO;
import com.inkombizz.security.model.Role;
import com.inkombizz.security.model.RoleField;
import com.inkombizz.security.model.RoleTemp;
import org.hibernate.criterion.Restrictions;


public class RoleBLL {
    
    public static final String MODULECODE = "007_SCR_ROLE";
    
    private RoleDAO roleDAO;

    public RoleBLL(HBMSession hbmSession) {
        this.roleDAO = new RoleDAO(hbmSession);
    }
	
    public ListPaging<Role> getListHeader(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
            
            criteria = paging.addOrderCriteria(criteria);

            paging.setRecords(roleDAO.countByCriteria(criteria));

            // Reset count Projection
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);

            // Calculate total Pages
            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Role> listRole = roleDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Role> listPaging = new ListPaging<Role>();

            listPaging.setList(listRole);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
 
    public List<Role> getListHeader() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
            List<Role> listRole = roleDAO.findByCriteria(criteria);
            return listRole;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<Role> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Role.class)
                    .add(Restrictions.like(RoleField.CODE, code + "%" ))
                    .add(Restrictions.like(RoleField.NAME, "%" + name + "%"));
            
//            if (activeStatus == activeStatus.YES)
//                criteria.add(Restrictions.eq(RoleField.ACTIVESTATUS, true));
//            else if (activeStatus == activeStatus.NO)
//                criteria.add(Restrictions.eq(RoleField.ACTIVESTATUS, false));
//            
//            
            paging.setRecords(roleDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Role> listRole = roleDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Role> listPaging = new ListPaging<Role>();
            
            listPaging.setList(listRole);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public Role getHeader(String code) throws Exception {
        try {
            return (Role) roleDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public RoleTemp findData(String code) throws Exception {
        try {
            return (RoleTemp) roleDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Role.class)
                            .add(Restrictions.eq(RoleField.CODE, headerCode));
             
            if(roleDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(Role role) throws Exception {
        try {
            roleDAO.save(role, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Role role) throws Exception {
        try {
            roleDAO.update(role, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String code) throws Exception {
        try {
            roleDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
}