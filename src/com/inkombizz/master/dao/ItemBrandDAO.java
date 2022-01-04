

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemBrandTemp;
import com.inkombizz.master.model.ItemBrandField;
import com.inkombizz.master.model.ItemBrand;
import org.hibernate.criterion.Restrictions;



public class ItemBrandDAO {
    
    private HBMSession hbmSession;
    
    public ItemBrandDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(ItemBrand itemBrand){   
        try{
            String acronim = "ITMBRD";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBrand.class)
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
    
    public List <ItemBrand> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_brand.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_brand "
                + "WHERE mst_item_brand.code LIKE '%"+code+"%' "
                + "AND mst_item_brand.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
       
//    public int countByCriteria(DetachedCriteria dc) {
//        try {
//            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
//            criteria.setProjection(Projections.rowCount());
//            if (criteria.list().size() == 0)
//            	return 0;
//            else
//            	return ((Integer) criteria.list().get(0)).intValue();
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public ItemBrandTemp findData(String code) {
        try {
            ItemBrandTemp itemBrandTemp = (ItemBrandTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_brand.Code, "
                + "mst_item_brand.name, "
                + "mst_item_brand.activeStatus, "
                + "mst_item_brand.remark, "
                + "mst_item_brand.InActiveBy, "
                + "mst_item_brand.InActiveDate, "
                + "mst_item_brand.CreatedBy, "
                + "mst_item_brand.CreatedDate "
                + "FROM mst_item_brand "
                + "WHERE mst_item_brand.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBrandTemp.class))
                .uniqueResult(); 
                 
                return itemBrandTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBrandTemp findData(String code,boolean active) {
        try {
            ItemBrandTemp itemBrandTemp = (ItemBrandTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_brand.Code, "
                + "mst_item_brand.name, "
                + "mst_item_brand.remark "
                + "FROM mst_item_brand "
                + "WHERE mst_item_brand.code ='"+code+"' "
                + "AND mst_item_brand.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBrandTemp.class))
                .uniqueResult(); 
                 
                return itemBrandTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBrandTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_brand.ActiveStatus="+active+" ";
            }
            List<ItemBrandTemp> list = (List<ItemBrandTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_brand.Code, "
                + "mst_item_brand.name, "
                + "mst_item_brand.remark, "
                + "mst_item_brand.ActiveStatus "
                + "FROM mst_item_brand "
                + "WHERE mst_item_brand.code LIKE '%"+code+"%' "
                + "AND mst_item_brand.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBrandTemp.class))
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
    
    public void save(ItemBrand itemBrand, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBrand.setCode(createCode(itemBrand));
            if(itemBrand.isActiveStatus()){
                itemBrand.setInActiveBy("");                
            }else{
                itemBrand.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBrand.setInActiveDate(new Date());
            }
            
            itemBrand.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBrand.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBrand);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBrand.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBrand itemBrand, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBrand.isActiveStatus()){
                itemBrand.setInActiveBy("");                
            }else{
                itemBrand.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBrand.setInActiveDate(new Date());
            }
            itemBrand.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBrand.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBrand);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBrand.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBrandField.BEAN_NAME + " WHERE " + ItemBrandField.CODE + " = :prmCode")
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
    
    
    
}
