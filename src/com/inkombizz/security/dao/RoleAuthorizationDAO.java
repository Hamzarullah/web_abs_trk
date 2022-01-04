package com.inkombizz.security.dao;

import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.security.model.RoleAuthorization;
import com.inkombizz.security.model.RoleAuthorizationField;
import com.inkombizz.security.model.RoleAuthorizationTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

public class RoleAuthorizationDAO {
    private HBMSession hbmSession;
	
    public RoleAuthorizationDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public RoleAuthorization getList(String code){
        try{
            return (RoleAuthorization) hbmSession.hSession.get(RoleAuthorization.class, code);
        }
        catch(HibernateException e) {
            throw e;
        }
    }
    
    public List<RoleAuthorization> findListByCriteria(DetachedCriteria dc, int from, int size){
        try{
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            // ini buat sort asc
            criteria.createAlias("authorization.module", "Menu");
            criteria.addOrder(Order.asc("Menu.parentCode"));
            criteria.addOrder(Order.asc("Menu.sortNO"));

            criteria.setFirstResult(from);
            criteria.setMaxResults(size);            
            
            return criteria.list();
        }
        catch(HibernateException e){
            throw e;
        }
    }
         
    public List<RoleAuthorization> findListByCriteria(DetachedCriteria dc){
        try{
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            
            return criteria.list();
        }
        catch(HibernateException e){
            throw e;
        }
    }
    
    public List<RoleAuthorizationTemp> getListDetailForUpdate(String headerCode){
        try{
            
            String qry =   "SELECT CODE, modulecode,modulename,IFNULL(assignauthority,0) assignauthority, " +
                            "IFNULL(deleteauthority,0) deleteauthority,IFNULL(printauthority,0) printauthority,IFNULL(saveauthority,0) saveauthority, " +
                            "IFNULL(updateauthority,0) updateauthority,IFNULL(authorizationcode,'') authorizationcode FROM "
                            + "(SELECT * FROM " +
                            "( " +
                            "		SELECT auth.code , auth.modulecode modulecode, scr_menu.text modulename " +
                            "	        FROM scr_authorization auth " +
                            "		INNER JOIN scr_menu ON scr_menu.`Code` = auth.`modulecode` " +
                            ") AS qry1 " +
                            "LEFT JOIN ( " +
                            "	 	SELECT role_auth.`assignauthority`,role_auth.`deleteauthority`,role_auth.`printauthority`, " +
                            "		role_auth.`saveauthority`,role_auth.`updateauthority`,role_auth.`authorizationcode` " +
                            "		FROM scr_role_authorization role_auth " +
                            "		WHERE role_auth.`headercode` = '"+headerCode+"' " +
                            ")qry2 ON qry2.authorizationcode = qry1.code "
                            + ")qry3"
                            +" ORDER BY CODE ASC ";
            
            List<RoleAuthorizationTemp> listRoleAuthorization = hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("modulecode", Hibernate.STRING)
                    .addScalar("modulename", Hibernate.STRING)
                    .addScalar("assignauthority", Hibernate.BOOLEAN)
                    .addScalar("deleteauthority", Hibernate.BOOLEAN)
                    .addScalar("printauthority", Hibernate.BOOLEAN)
                    .addScalar("saveauthority", Hibernate.BOOLEAN)
                    .addScalar("updateauthority", Hibernate.BOOLEAN)
                    .setResultTransformer(Transformers.aliasToBean(RoleAuthorizationTemp.class))
                    .list();
            
            return listRoleAuthorization;
        }
        catch(HibernateException e){
            e.printStackTrace();
        }
        return null;
    }
    
    public int countListByCriteria(DetachedCriteria dc){
        try{
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            
            criteria.setProjection(Projections.rowCount());
            
            if(criteria.list().isEmpty())
                return 0;
            else
                return ((Integer)criteria.list().get(0)).intValue();
        }
        catch(HibernateException e){
            throw e;
        }
    }
    
    public void save(String roleCode, List<RoleAuthorization> listRoleAuthorization, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            int i = 1;            
            for (RoleAuthorization roleAuthorization : listRoleAuthorization) {
                String detailCode = roleCode + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_DETAIL_TRANSACTION_LENGTH, "0");
                
                roleAuthorization.setCode(detailCode);
                roleAuthorization.setHeaderCode(roleCode);
                
                hbmSession.hSession.save(roleAuthorization);

                i++;
            }   
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    roleCode, ""));

            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public void update(String roleCode, List<RoleAuthorization> listRoleAuthorization, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();

            hbmSession.hSession.createQuery("DELETE FROM " + RoleAuthorizationField.BEAN_NAME + " WHERE " + RoleAuthorizationField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", roleCode)
                    .executeUpdate();
            
            int i = 1;            
            for (RoleAuthorization roleAuthorization : listRoleAuthorization) {
                String detailCode = roleCode + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_DETAIL_TRANSACTION_LENGTH, "0");
                String headCode = roleAuthorization.getAuthorization().getModule().getCode();

                
                hbmSession.hSession.createSQLQuery("INSERT INTO scr_role_authorization(CODE,assignauthority,deleteauthority,printauthority,saveauthority,updateauthority,headercode,authorizationcode) " +
                                     "VALUES('"+detailCode+"',"+roleAuthorization.isAssignAuthority()+", "
                                    +roleAuthorization.isDeleteAuthority()+","+roleAuthorization.isPrintAuthority()+", "
                                    +roleAuthorization.isSaveAuthority()+","+roleAuthorization.isUpdateAuthority()+",'"+roleCode+"','"+headCode+"')").executeUpdate();

                i++;
            }   
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    roleCode, ""));

            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            
            e.printStackTrace();
        }
    }

    public void delete(String roleCode, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("DELETE FROM " + RoleAuthorizationField.BEAN_NAME + " WHERE " + RoleAuthorizationField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", roleCode)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    roleCode, ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
}