

package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.master.model.Rack;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.ReasonTemp;
import com.inkombizz.master.model.ReasonField;
import com.inkombizz.master.model.ReasonModuleDetail;
import com.inkombizz.master.model.ReasonModuleDetailTemp;
import org.hibernate.criterion.Restrictions;



public class ReasonDAO {
    
    private HBMSession hbmSession;
    
    public ReasonDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(Reason reason){   
        try{
            String acronim = "RSN";
            DetachedCriteria dc = DetachedCriteria.forClass(Reason.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));
            
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();
            
            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        }        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_reason.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_reason "
                + "WHERE mst_reason.code LIKE '%"+code+"%' "
                + "AND mst_reason.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDetail(String headerCode){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                    + " SELECT COUNT(*) FROM mst_reason_jn_module_detail "
                    + " WHERE "
                    + " mst_reason_jn_module_detail.ReasonCode='"+headerCode+"'"
            )
                    .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }   
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<ReasonModuleDetailTemp> findDataReasonModuleCoaTempNew() {
        try {
            List<ReasonModuleDetailTemp> list = (List<ReasonModuleDetailTemp>) hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                        + "' ' AS code,"
                        + "mst_reason_jn_module.Code AS authorizationCode, "
                        + "scr_menu.Text AS authorizationName, "
                        + "CASE "
                            + "WHEN mst_reason_jn_module.COAStatus = 1 THEN 'TRUE'   "
                            + "WHEN mst_reason_jn_module.COAStatus = 0 THEN 'FALSE' "
                        + "END AS coaStatus "
                    + "FROM mst_reason_jn_module "
                    + "INNER JOIN scr_menu ON scr_menu.Code = mst_reason_jn_module.Code "
                        + "WHERE scr_menu.Classes = 'File' ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("authorizationCode", Hibernate.STRING)
                    .addScalar("authorizationName", Hibernate.STRING)
                    .addScalar("coaStatus", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ReasonModuleDetailTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    public List<ReasonModuleDetailTemp> findDataReasonModuleCoaTemp(String headerCode) {
        try {
            List<ReasonModuleDetailTemp> list = (List<ReasonModuleDetailTemp>) hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_reason_jn_module_detail.Code, "
                    + "IFNULL(mst_reason_jn_module_detail.ModuleCode,'') AS moduleCode, "
                    + "IFNULL(scr_menu.Text,'') AS moduleName, "
                    + "IFNULL(mst_reason_jn_module_detail.ChartOfAccountCode,'') AS chartOfAccountCode, "
                    + "IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName "
                + "FROM "
                    + "mst_reason_jn_module_detail "
                + "LEFT JOIN scr_menu ON scr_menu.Code = mst_reason_jn_module_detail.ModuleCode "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_reason_jn_module_detail.ChartOfAccountCode "
                + "WHERE "
                    + " mst_reason_jn_module_detail.ReasonCode = '"+headerCode+"' "
                    
            )
                    
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("moduleCode", Hibernate.STRING)
                    .addScalar("moduleName", Hibernate.STRING)
//                    .addScalar("assignAuthority", Hibernate.BOOLEAN)
                    .addScalar("chartOfAccountCode", Hibernate.STRING)
                    .addScalar("chartOfAccountName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ReasonModuleDetailTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public ReasonTemp findData(String code) {
        try {
            ReasonTemp reasonTemp = (ReasonTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_reason.Code, "
                + "mst_reason.name, "
                + "mst_reason.activeStatus, "
                + "mst_reason.remark, "
                + "mst_reason.InActiveBy, "
                + "mst_reason.InActiveDate, "
                + "mst_reason.CreatedBy, "
                + "mst_reason.CreatedDate "
                + "FROM mst_reason "
                + "WHERE mst_reason.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ReasonTemp.class))
                .uniqueResult(); 
                 
                return reasonTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ReasonTemp findData(String code,boolean active) {
        try {
            ReasonTemp reasonTemp = (ReasonTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_reason.Code, "
                + "mst_reason.name, "
                + "mst_reason.remark "
                + "FROM mst_reason "
                + "WHERE mst_reason.code ='"+code+"' "
                + "AND mst_reason.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ReasonTemp.class))
                .uniqueResult(); 
                 
                return reasonTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ReasonTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_reason.ActiveStatus="+active+" ";
            }
            List<ReasonTemp> list = (List<ReasonTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_reason.Code, "
                + "mst_reason.name, "
                + "mst_reason.remark, "
                + "mst_reason.ActiveStatus "
                + "FROM mst_reason "
                + "WHERE mst_reason.code LIKE '%"+code+"%' "
                + "AND mst_reason.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ReasonTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<ReasonModuleDetailTemp> findDataReasonModuleCoaTempUpdate(String headerCode) {
        try {
            List<ReasonModuleDetailTemp> list = (List<ReasonModuleDetailTemp>) hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_reason_jn_module_detail.Code, "
                    + "IFNULL(mst_reason_jn_module_detail.ModuleCode,'') AS authorizationCode, "
                    + "IFNULL(scr_menu.Text,'') AS authorizationName, "
                    + "IFNULL(mst_reason_jn_module_detail.ChartOfAccountCode,'') AS chartOfAccountCode, "
                    + "IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName, "
                    + "qr1.coaStatus AS assignAuthority "
                + "FROM "
                    + "mst_reason_jn_module_detail "
                + "LEFT JOIN scr_menu ON scr_menu.Code = mst_reason_jn_module_detail.ModuleCode "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_reason_jn_module_detail.ChartOfAccountCode "
                + "LEFT JOIN ( "
                    + "SELECT "
                    + "' ' AS CODE, "
                    + "mst_reason_jn_module.Code AS authorizationCode,  "
                    + "scr_menu.Text AS authorizationName,  "
                    + "CASE "
                    + "WHEN mst_reason_jn_module.COAStatus = 1 THEN 'TRUE'  "
                    + "WHEN mst_reason_jn_module.COAStatus = 0 THEN 'FALSE'  "
                    + "END AS coaStatus  "
                    + "FROM mst_reason_jn_module  "
                    + "INNER JOIN scr_menu ON scr_menu.Code = mst_reason_jn_module.Code  "
                    + ") AS qr1 ON qr1.authorizationCode = mst_reason_jn_module_detail.ModuleCode "
                + "WHERE "
                    + " mst_reason_jn_module_detail.ReasonCode = '"+headerCode+"' "
                )
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("authorizationCode", Hibernate.STRING)
                    .addScalar("authorizationName", Hibernate.STRING)
                    .addScalar("assignAuthority", Hibernate.BOOLEAN)
                    .addScalar("chartOfAccountCode", Hibernate.STRING)
                    .addScalar("chartOfAccountName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ReasonModuleDetailTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Reason reason,List<ReasonModuleDetail> listReasonModuleCoa, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            reason.setCode(createCode(reason));
            if(reason.isActiveStatus()){
                reason.setInActiveBy("");                
            }else{
                reason.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                reason.setInActiveDate(new Date());
            }
            
            reason.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            reason.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(reason);
            int i = 1;            
            for (ReasonModuleDetail reasonModuleCoa : listReasonModuleCoa) {
                String detailCode = reason.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_DETAIL_TRANSACTION_LENGTH, "0");
                
                reasonModuleCoa.setCode(detailCode);
                reasonModuleCoa.setReasonCode(reason.getCode());
                if (reasonModuleCoa.getChartOfAccount().getCode().equals("") || reasonModuleCoa.getChartOfAccount().getCode()==null){
                    reasonModuleCoa.setChartOfAccount(null);
                    reasonModuleCoa.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    reasonModuleCoa.setCreatedDate(new Date());
                }
                hbmSession.hSession.save(reasonModuleCoa);

                i++;
            }   
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    reason.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Reason reason,List<ReasonModuleDetail> listReasonModuleCoa, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createSQLQuery("DELETE FROM mst_reason_jn_module_detail WHERE ReasonCode = '" + reason.getCode() + "'")
                    .executeUpdate();
            if(reason.isActiveStatus()){
                reason.setInActiveBy("");                
            }else{
                reason.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                reason.setInActiveDate(new Date());
            }
            reason.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            reason.setUpdatedDate(new Date()); 
            
            
            int i = 1;            
            for (ReasonModuleDetail reasonModuleCoa : listReasonModuleCoa) {
                String detailCode = reason.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_DETAIL_TRANSACTION_LENGTH, "0");
                
                reasonModuleCoa.setCode(detailCode);
                reasonModuleCoa.setReasonCode(reason.getCode());
                
                if (reasonModuleCoa.getChartOfAccount().getCode().equals("") || reasonModuleCoa.getChartOfAccount().getCode()==null){
                    reasonModuleCoa.setChartOfAccount(null);
                }
                
                reasonModuleCoa.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                reasonModuleCoa.setUpdatedDate(new Date());
                hbmSession.hSession.save(reasonModuleCoa);

                i++;
            }   hbmSession.hSession.update(reason);
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    reason.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createSQLQuery("DELETE FROM mst_reason_jn_module_detail WHERE ReasonCode = '" + code + "'")
                    .executeUpdate();
            hbmSession.hSession.createQuery("DELETE FROM " + ReasonField.BEAN_NAME + " WHERE " + ReasonField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
    
}
