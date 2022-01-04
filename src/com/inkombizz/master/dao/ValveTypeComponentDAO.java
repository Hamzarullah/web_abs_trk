

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.ValveTypeComponentTemp;
import com.inkombizz.master.model.ValveTypeComponent;
import com.inkombizz.master.model.ValveTypeComponentDetail;
import com.inkombizz.master.model.ValveTypeComponentDetailField;
import com.inkombizz.master.model.ValveTypeComponentDetailTemp;
import com.inkombizz.master.model.ValveTypeTemp;



public class ValveTypeComponentDAO {
    
    private HBMSession hbmSession;
    
    public ValveTypeComponentDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public List <ValveTypeComponent> findByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_valve_type_component.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_valve_type_component "
                + "WHERE mst_valve_type_component.code LIKE '%"+code+"%' "
                + "AND mst_valve_type_component.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
       
    
    public ValveTypeComponentTemp findData(String code) {
        try {
            ValveTypeComponentTemp valveTypeComponentTemp = (ValveTypeComponentTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_valve_type_component.Code, "
                + "mst_valve_type_component.name, "
                + "mst_valve_type_component.activeStatus, "
                + "mst_valve_type_component.remark, "
                + "mst_valve_type_component.InActiveBy, "
                + "mst_valve_type_component.InActiveDate, "
                + "mst_valve_type_component.CreatedBy, "
                + "mst_valve_type_component.CreatedDate "
                + "FROM mst_valve_type_component "
                + "WHERE mst_valve_type_component.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentTemp.class))
                .uniqueResult(); 
                 
                return valveTypeComponentTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ValveTypeComponentTemp findData(String code,boolean active) {
        try {
            ValveTypeComponentTemp valveTypeComponentTemp = (ValveTypeComponentTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_valve_type_component.Code, "
                + "mst_valve_type_component.name, "
                + "mst_valve_type_component.remark "
                + "FROM mst_valve_type_component "
                + "WHERE mst_valve_type_component.code ='"+code+"' "
                + "AND mst_valve_type_component.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentTemp.class))
                .uniqueResult(); 
                 
                return valveTypeComponentTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ValveTypeComponentTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_valve_type_component.ActiveStatus="+active+" ";
            }
            List<ValveTypeComponentTemp> list = (List<ValveTypeComponentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_valve_type_component.Code, "
                + "mst_valve_type_component.SortNo, "
                + "mst_valve_type_component.name, "
                + "mst_valve_type_component.remark, "
                + "mst_valve_type_component.ActiveStatus "
                + "FROM mst_valve_type_component "
                + "WHERE mst_valve_type_component.code LIKE '%"+code+"%' "
                + "AND mst_valve_type_component.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_valve_type_component.SortNo ASC "            
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ValveTypeComponentTemp> getDataDetail(String headerCode) {
        try {
            
            List<ValveTypeComponentTemp> list = (List<ValveTypeComponentTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "mst_valve_type_component.Code, "
                + "mst_valve_type_component.Name, "
                + "mst_valve_type_component_detail.ValveTypeComponentCode, "
                + "mst_valve_type_component_detail.ValveTypeCode "
                + "FROM mst_valve_type_component "
                + "INNER JOIN mst_valve_type_component_detail ON mst_valve_type_component_detail.ValveTypeComponentCode = mst_valve_type_component.Code "
                + "INNER JOIN mst_valve_type ON mst_valve_type.code = mst_valve_type_component_detail.ValveTypeCode "
                + "WHERE mst_valve_type_component_detail.ValveTypeCode='"+headerCode+"'")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            
            List countData = criteria.list();
            
            if (countData.isEmpty())
                return 0;
            else {
                return  ( Integer.parseInt(countData.get(0).toString()) ) ;
            }
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ValveTypeComponentDetailTemp> findDataDetail(String headerCode) {
        try {
            String where ="";
            if(!headerCode.equals("")){
                where = "WHERE mst_valve_type_component_detail.ValveTypeCode='"+headerCode+"'"; 
            }
            List<ValveTypeComponentDetailTemp> list = (List<ValveTypeComponentDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "mst_valve_type_component_detail.code, "
                + "mst_valve_type_component_detail.ValveTypeCode, "
                + "mst_valve_type_component.Code AS ValveTypeComponentCode, "
                + "mst_valve_type_component.Name AS ValveTypeName, "
                + "mst_valve_type_component_detail.activeStatus "
                + "FROM mst_valve_type_component_detail "
                + "INNER JOIN mst_valve_type ON mst_valve_type.code = mst_valve_type_component_detail.ValveTypeCode "
                + "INNER JOIN mst_valve_type_component ON mst_valve_type_component.code = mst_valve_type_component_detail.ValveTypeComponentCode "
                + where
                + "ORDER BY mst_valve_type_component.SortNo ASC " )
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTypeComponentCode", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ValveTypeComponentDetailTemp checkValveType(String code) {

        try {
               ValveTypeComponentDetailTemp valveTypeComponentDetailTemp = (ValveTypeComponentDetailTemp) hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "mst_valve_type_component_detail.ValveTypeCode, "
                + "mst_item_finish_goods.ValveTypeCode AS typeCode "
                + "FROM mst_valve_type_component_detail "
                + "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.ValveTypeCode = mst_valve_type_component_detail.ValveTypeCode "
                + "WHERE mst_valve_type_component_detail.ValveTypeCode ='"+code+"' "
                + "LIMIT 1 "
               )
                       
//                .addScalar("code", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentDetailTemp.class))
                .uniqueResult(); 
                 
                return valveTypeComponentDetailTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void update(ValveTypeComponent valveTypeComponent, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(valveTypeComponent.isActiveStatus()){
                valveTypeComponent.setInActiveBy("");                
            }else{
                valveTypeComponent.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                valveTypeComponent.setInActiveDate(new Date());
            }
            valveTypeComponent.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            valveTypeComponent.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(valveTypeComponent);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    valveTypeComponent.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(ValveTypeComponent valveTypeComponent,List<ValveTypeComponentDetail> listValveTypeComponentDetail,String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
             if(listValveTypeComponentDetail == null){
                hbmSession.hTransaction.rollback();
            }
             
            hbmSession.hSession.createQuery("DELETE FROM "+ValveTypeComponentDetailField.BEAN_NAME+" WHERE "+ValveTypeComponentDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", valveTypeComponent.getCode())    
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            int i=1; 
             for(ValveTypeComponentDetail valveTypeComponentDetail : listValveTypeComponentDetail){
                 
                String detailCode = valveTypeComponent.getCode() + "-" + valveTypeComponentDetail.getValveTypeComponent().getCode();
                valveTypeComponentDetail.setCode(detailCode);
                valveTypeComponentDetail.setValveType(valveTypeComponent.getCode());
                valveTypeComponentDetail.setValveTypeComponent(valveTypeComponentDetail.getValveTypeComponent());
                valveTypeComponentDetail.setActiveStatus(true);
                valveTypeComponentDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                valveTypeComponentDetail.setCreatedDate(new Date()); 
                
                hbmSession.hSession.save(valveTypeComponentDetail);
                i++;
            }
     
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    valveTypeComponent.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
}
