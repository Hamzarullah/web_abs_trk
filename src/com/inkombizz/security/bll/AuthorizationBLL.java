package com.inkombizz.security.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.dao.AuthorizationDAO;
import com.inkombizz.security.model.Authorization;


public class AuthorizationBLL {
    private AuthorizationDAO authorizationDAO;

    public AuthorizationBLL(HBMSession hbmSession) {
        this.authorizationDAO = new AuthorizationDAO(hbmSession);
    }
	
    public ListPaging<Authorization> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Authorization.class);
            
            criteria = paging.addOrderCriteria(criteria);

            paging.setRecords(authorizationDAO.countByCriteria(criteria));

            // Reset count Projection
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);

            // Calculate total Pages
            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<Authorization> listAuthorization = authorizationDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<Authorization> listPaging = new ListPaging<Authorization>();

            listPaging.setList(listAuthorization);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
   
    public List<Authorization> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Authorization.class);
            List<Authorization> listAuthorization = authorizationDAO.findByCriteria(criteria);
            return listAuthorization;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public Authorization get(String code) throws Exception {
        try {
            return (Authorization) authorizationDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(Authorization authorization) throws Exception {
        try {
            System.out.println("SAVE BLL : ");
            authorizationDAO.save(authorization);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(Authorization authorization) throws Exception {
        try {
            authorizationDAO.update(authorization);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String code) throws Exception {
        try {
            authorizationDAO.delete(code);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
}