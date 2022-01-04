

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.ItemBall;
import com.inkombizz.master.model.ItemBallTemp;
import com.inkombizz.master.model.ItemBallField;
import com.inkombizz.master.model.ItemBall;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemBallDAO {
    
    private HBMSession hbmSession;
    
    public ItemBallDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemBall itemBall){   
        try{
            String acronim = "BALL";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBall.class)
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
    public List <ItemBall> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_ball.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_ball "
                + "WHERE mst_item_ball.code LIKE '%"+code+"%' "
                + "AND mst_item_ball.name LIKE '%"+name+"%' "
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
    
    public ItemBallTemp findData(String code) {
        try {
            ItemBallTemp itemBallTemp = (ItemBallTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_ball.Code, "
                + "mst_item_ball.name, "
                + "mst_item_ball.activeStatus, "
                + "mst_item_ball.remark, "
                + "mst_item_ball.InActiveBy, "
                + "mst_item_ball.InActiveDate, "
                + "mst_item_ball.CreatedBy, "
                + "mst_item_ball.CreatedDate "
                + "FROM mst_item_ball "
                + "WHERE mst_item_ball.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBallTemp.class))
                .uniqueResult(); 
                 
                return itemBallTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBallTemp findData(String code,boolean active) {
        try {
            ItemBallTemp itemBallTemp = (ItemBallTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_ball.Code, "
                + "mst_item_ball.name, "
                + "mst_item_ball.remark "
                + "FROM mst_item_ball "
                + "WHERE mst_item_ball.code ='"+code+"' "
                + "AND mst_item_ball.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBallTemp.class))
                .uniqueResult(); 
                 
                return itemBallTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBallTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_ball.ActiveStatus="+active+" ";
            }
            List<ItemBallTemp> list = (List<ItemBallTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_ball.Code, "
                + "mst_item_ball.name, "
                + "mst_item_ball.remark, "
                + "mst_item_ball.ActiveStatus "
                + "FROM mst_item_ball "
                + "WHERE mst_item_ball.code LIKE '%"+code+"%' "
                + "AND mst_item_ball.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBallTemp.class))
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
    
    public void save(ItemBall itemBall, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBall.setCode(createCode(itemBall));
            if(itemBall.isActiveStatus()){
                itemBall.setInActiveBy("");                
            }else{
                itemBall.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBall.setInActiveDate(new Date());
            }
            
            itemBall.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBall.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBall);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBall.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBall itemBall, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBall.isActiveStatus()){
                itemBall.setInActiveBy("");                
            }else{
                itemBall.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBall.setInActiveDate(new Date());
            }
            itemBall.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBall.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBall);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBall.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBallField.BEAN_NAME + " WHERE " + ItemBallField.CODE + " = :prmCode")
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
