package com.inkombizz.security.bll;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.dao.RoleAuthorizationDAO;
import com.inkombizz.security.model.RoleAuthorization;
import com.inkombizz.security.model.RoleAuthorizationField;
import com.inkombizz.security.model.RoleAuthorizationTemp;
import org.hibernate.criterion.Restrictions;


public class RoleAuthorizationBLL {
    
    public static final String MODULECODE = "007_SCR_ROLE_AUTHORIZATION";
    
    HBMSession hbmSession;
    
    private RoleAuthorizationDAO roleAuthorizationDAO;

    public RoleAuthorizationBLL(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
        this.roleAuthorizationDAO = new RoleAuthorizationDAO(hbmSession);
    }
	
    public ListPaging<RoleAuthorization> getListDetail (Paging paging, String headerCode) throws Exception{
        try{
            DetachedCriteria criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .add(Restrictions.eq(RoleAuthorizationField.HEADERCODE, headerCode));
            
            //Perintah ini untuk Pengurutan berdasarkan field dari grid yang di pilih
            // Perhatian Class PAGING
            //............................................................................
            
            //criteria = paging.addOrderCriteria(criteria);
            
            paging.setRecords(roleAuthorizationDAO.countListByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal((int) Math.ceil((double)paging.getRecords() / (double)paging.getRows()));
            
            // untuk Menghapus Projection yang telah dibentuk
            // dari perintah sebelumnya (countByCriteria)
            // criteria.setProjection(null)
            //..............................................................................
            
            
            List<RoleAuthorization> listDetail = roleAuthorizationDAO.findListByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<RoleAuthorization> listPaging = new ListPaging<RoleAuthorization>();
            
            listPaging.setList(listDetail);
            listPaging.setPaging(paging);
            
            return listPaging;            
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
    
    public RoleAuthorization get(String detailCode) throws Exception{
        try{
            return roleAuthorizationDAO.getList(detailCode);
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<RoleAuthorization> getListDetail(String headerCode) throws Exception{
        try{
            DetachedCriteria criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .add(Restrictions.eq(RoleAuthorizationField.HEADERCODE, headerCode));
            
            return roleAuthorizationDAO.findListByCriteria(criteria);
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public boolean hasAuthority(String userCode, String moduleCode, String authorizationString) throws Exception{
        try {
            boolean returnAuth = false;
            DetachedCriteria criteria = null;
            

            if(authorizationString.equalsIgnoreCase("VIEW")){
                     criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .createAlias("authorization", "authorization")
                    .add(Restrictions.eq("headerCode", BaseSession.loadProgramSession().getGroupCode()))
                    .add(Restrictions.eq("authorization.module.code", moduleCode))
                    .add(Restrictions.eq("assignAuthority", true));
            }
            
            if(authorizationString.equalsIgnoreCase("INSERT")){
                     criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .createAlias("authorization", "authorization")
                    .add(Restrictions.eq("headerCode", BaseSession.loadProgramSession().getGroupCode()))
                    .add(Restrictions.eq("authorization.module.code", moduleCode))
                    .add(Restrictions.eq("saveAuthority", true));
            }
            
            if(authorizationString.equalsIgnoreCase("UPDATE")){
                     criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .createAlias("authorization", "authorization")
                    .add(Restrictions.eq("headerCode", BaseSession.loadProgramSession().getGroupCode()))
                    .add(Restrictions.eq("authorization.module.code", moduleCode))
                    .add(Restrictions.eq("updateAuthority", true));
            }
            
            if(authorizationString.equalsIgnoreCase("DELETE")){
                     criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .createAlias("authorization", "authorization")
                    .add(Restrictions.eq("headerCode", BaseSession.loadProgramSession().getGroupCode()))
                    .add(Restrictions.eq("authorization.module.code", moduleCode))
                    .add(Restrictions.eq("deleteAuthority", true));
            }
            
            if(authorizationString.equalsIgnoreCase("PRINT")){
                     criteria = DetachedCriteria.forClass(RoleAuthorization.class)
                    .createAlias("authorization", "authorization")
                    .add(Restrictions.eq("headerCode", BaseSession.loadProgramSession().getGroupCode()))
                    .add(Restrictions.eq("authorization.module.code", moduleCode))
                    .add(Restrictions.eq("printAuthority", true));
            }

            List<RoleAuthorization> listRole = roleAuthorizationDAO.findListByCriteria(criteria);
            if (!listRole.isEmpty()){
                returnAuth = true;
            }
            
            if (listRole == null){
                returnAuth = false;
            }
                

           return returnAuth;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<RoleAuthorizationTemp> getListDetailForupdate(String headerCode) throws Exception{
        try{
            return roleAuthorizationDAO.getListDetailForUpdate(headerCode);
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(String roleCode, List<RoleAuthorization> listRoleAuthorization) throws Exception {
        try {
            roleAuthorizationDAO.save(roleCode,listRoleAuthorization, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(String roleCode, List<RoleAuthorization> listRoleAuthorization) throws Exception {
        try {
            roleAuthorizationDAO.update(roleCode,listRoleAuthorization, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String roleCode) throws Exception {
        try {
            roleAuthorizationDAO.delete(roleCode, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
}