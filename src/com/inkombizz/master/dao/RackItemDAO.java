
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Rack;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.RackItem;
import com.inkombizz.master.model.RackItemField;
import com.inkombizz.master.model.RackItemTemp;
import com.inkombizz.master.model.RackTemp;
import com.inkombizz.utils.DateUtils;
import java.math.BigInteger;
import org.hibernate.criterion.Restrictions;


public class RackItemDAO {
    
    private HBMSession hbmSession;

    public RackItemDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(RackItem rackItem){   
        try{
            String acronim = "RCKITM";
            DetachedCriteria dc = DetachedCriteria.forClass(RackItem.class)
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
    
    
    private String executeStatus(String val){
        
            String value="";
            if((!val.equals("") && val.equals("Active")) || (val.equals("YES"))){
                value=" AND mst_rack_item.ActiveStatus = 1 ";
            }else if((!val.equals("") && val.equals("InActive")) || (val.equals("NO"))){
                value=" AND mst_rack_item.ActiveStatus = 0 ";
            }else{
                value=" ";
            }
            
        return value;
    }
    
//    public List<RackItem> findByCriteria(DetachedCriteria dc, int from, int size) {
//        try {
//            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
//            criteria.setFirstResult(from);
//            criteria.setMaxResults(size);
//            return criteria.list();
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
     public List<Rack> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
     public List<RackItemTemp> findData(String code) {
        try {   
            
            List<RackItemTemp> list = (List<RackItemTemp>)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_rack_item.code, "
                    + "mst_rack_item.RackCode, "
                    + "mst_rack.name AS RackName, "
                    + "mst_rack_item.ItemMaterialCode AS itemCode, "
                    + "mst_item_material.name AS itemName, "
                    + "mst_item_material.DefaultUnitOfMeasureCode AS UOM,"
                    + "mst_rack_item.quantity, "
                    + "mst_rack_item.remark "
                   
                + "FROM mst_rack_item "
                + "INNER JOIN mst_rack ON mst_rack.code=mst_rack_item.RackCode "
                + "INNER JOIN mst_item_material ON mst_item_material.code=mst_rack_item.ItemMaterialCode "
                   
                + "WHERE 1=1 "
                    + " AND mst_rack_item.code = :prmCode "
                + "ORDER BY mst_rack.code ASC "
                + "")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("UOM", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .setParameter("prmCode", "%"+code+"%")
                .setResultTransformer(Transformers.aliasToBean(RackItemTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
      public List<RackItemTemp> findDataRackItem(String headerCode) {
        try {
            List<RackItemTemp> list = (List<RackItemTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "mst_rack_item.code, "
                    + "mst_rack_item.RackCode, "
                    + "mst_rack.name AS RackName, "
                    + "mst_rack_item.ItemMaterialCode AS itemCode, "
                    + "mst_item_material.name AS itemName, "
                    + "mst_item_material.UnitOfMeasureCode AS UOM,"
                    + "mst_rack_item.quantity, "
                    + "mst_rack_item.remark "
                    + "FROM mst_rack_item "
                    + "INNER JOIN mst_rack ON mst_rack.code=mst_rack_item.RackCode "
                    + "INNER JOIN mst_item_material ON mst_item_material.code=mst_rack_item.ItemMaterialCode "
                    + "WHERE mst_rack_item.RackCode = '"+headerCode+"' "
                    + "ORDER BY mst_rack_item.code ASC "
                    + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("UOM", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(RackItemTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
      
    
    public List<RackItem> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
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
    
    public RackItem get(String id) {
        try {
            return (RackItem) hbmSession.hSession.get(RackItem.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Rack rack,List<RackItem> listRackItem, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
             hbmSession.hSession.createSQLQuery("DELETE FROM mst_rack_item WHERE RackCode = '" + rack.getCode() + "'")
                    .executeUpdate();
//            rackItem.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//            rackItem.setCreatedDate(new Date()); 
//            if(rackItem.getInActiveDate() == null){
//                rackItem.setInActiveDate(DateUtils.newDate(1990, 01, 01));
//            }
//            rackItem.setRackItemCode(BaseSession.loadProgramSession().getRackItemCode());
//            String Id = rackItem.getCode();
//            rackItem.setId(Id);
            String createdBy = rack.getCreatedBy();
            Date createdDate =  rack.getCreatedDate();
            String rackCode =  rack.getCode();
            for(RackItem detail : listRackItem){
                                                            
                String detailCode = rackCode+ "-"+ detail.getItemMaterial().getCode();
                detail.setCode(detailCode);
//                detail.setRack(rackItem);
                
                detail.setCreatedBy(createdBy);
                detail.setCreatedDate(createdDate);
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    rack.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(RackItem rackItem, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            rackItem.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            rackItem.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(rackItem);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    rackItem.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void delete(String id, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + RackItemField.BEAN_NAME + " WHERE " + RackItemField.CODE + " = :prmCode")
                    .setParameter("prmCode", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
    
    public RackItemTemp getMin() {
        try {
            
            String qry = "SELECT mst_rack_item.code,mst_rack_item.Name FROM mst_rack_item ORDER BY mst_rack_item.code LIMIT 0,1";
            RackItemTemp companyTemp =(RackItemTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(RackItemTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public RackItemTemp getMax() {
        try {
            
            String qry = "SELECT mst_rack_item.code,mst_rack_item.Name FROM mst_rack_item ORDER BY mst_rack_item.code DESC LIMIT 0,1";
            RackItemTemp companyTemp =(RackItemTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(RackItemTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
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
