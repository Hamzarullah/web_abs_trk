package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.RackField;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.master.model.RackTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

public class RackDAO {
    
    private HBMSession hbmSession;
    
    public RackDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(Rack rack){   
        try{
            String acronim = "RCK";
            DetachedCriteria dc = DetachedCriteria.forClass(Rack.class)
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
    
    
    public List <Rack> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
   public List<RackTemp> findData1(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+" ";
            }
            List<RackTemp> list = (List<RackTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_rack.Code, "
                + "mst_rack.name, "
                + "mst_rack.remark, "
                + "mst_rack.ActiveStatus "
                + "FROM mst_rack "
                + "WHERE mst_rack.code LIKE '%"+code+"%' "
                + "AND mst_rack.name LIKE '%"+name+"%' "
                + concat_qry)
               // + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(RackTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
     public int isExistRackCategory(String warehouseCode){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_rack "
                + "WHERE mst_rack.RackCategory= 'DOCK_IN' "
                + "AND mst_rack.WarehouseCode= '"+warehouseCode+"' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public int rackCheckInRackItem(String headerCode){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_rack_item "
                + "WHERE mst_rack_item.RackCode= '"+headerCode+"' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public int countSearchData(String code,String name,String active, String userCode){
        try{
            String concat_qry="";
             if(active.equals("NO") || active.equals("no")){
                active="false";
            }
            else if(active.equals("YES") || active.equals("yes")){
                active="true";
            }
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "COUNT(*) " 
                + "FROM  mst_rack "
//                + "INNER JOIN scr_user_warehouse ON scr_user_warehouse.UserCode='"+userCode+"' AND mst_rack.WarehouseCode=scr_user_warehouse.WarehouseCode "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code=mst_rack.WarehouseCode "
                
                + "WHERE 1=1 "
                    + "AND mst_rack.code LIKE :prmCode "
                    + "AND mst_rack.name LIKE :prmName "
                    + ""
                    + concat_qry)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmName", "%"+name+"%")
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
     public int countSearchDataView(String code, String name, String warehouseCode, String warehouseName, String active,String userCode){
        try{
            String concat_qry="";
             if(active.equals("NO") || active.equals("no")){
                active="false";
            }
            else if(active.equals("YES") || active.equals("yes")){
                active="true";
            }
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                        + "COUNT(*) " 
                    + "FROM mst_rack "
//                    + "INNER JOIN scr_user_warehouse ON scr_user_warehouse.UserCode = '"+userCode+"' "
//                        + "AND mst_rack.WarehouseCode = scr_user_warehouse.WarehouseCode "
                    + "INNER JOIN mst_warehouse ON mst_warehouse.code = mst_rack.WarehouseCode "
                    + "WHERE 1=1 "
                        + "AND mst_rack.code LIKE :prmCode "
                        + "AND mst_rack.name LIKE :prmName "
                        + "AND mst_warehouse.code LIKE :prmWarehouseCode "
                        + "AND mst_warehouse.name LIKE :prmWarehouseName "
                        + concat_qry)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmName", "%"+name+"%")
                    .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
                    .setParameter("prmWarehouseName", "%"+warehouseName+"%")
                    .uniqueResult();
            
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countSearchDataForRkm(String code,String name,String idWarehouseCode,String active){
        try{
            String concat_qry="";
             if(active.equals("NO") || active.equals("no")){
                active="false";
            }
            else if(active.equals("YES") || active.equals("yes")){
                active="true";
            }
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "COUNT(*) " 
                + "FROM  mst_rack "
                    
                + "WHERE 1=1 "
                    + "AND mst_rack.code LIKE :prmCode "
                    + "AND mst_rack.name LIKE :prmName "
                    + "AND mst_rack.WarehouseCode= :prmWarehouseCode "
                    + concat_qry)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmName", "%"+name+"%")
                    .setParameter("prmWarehouseCode",idWarehouseCode)
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public List<RackTemp> findSearchData(String code, String name,String userCode,String active,int from, int row) {
        try {
            String concat_qry="";
            if(active.equals("NO") || active.equals("no")){
                active="false";
            }
            else if(active.equals("YES") || active.equals("yes")){
                active="true";
            }
            
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+" ";
            }
            List<RackTemp> list = (List<RackTemp>)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_rack.Code AS code, "
                    + "mst_rack.name AS name, "
                    + "mst_rack.WarehouseCode, "
                    + "mst_warehouse.name AS warehouseName, "
                    + "mst_rack.ActiveStatus, "
                    + "mst_rack.Remark AS remark, "
                    + "mst_rack.InActiveBy AS inActiveBy, "
                    + "mst_rack.InActiveDate AS inActiveDate, "
                    + "mst_rack.CreatedBy AS createdBy, "
                    + "mst_rack.CreatedDate AS createdDate, "
                    + "mst_rack.UpdatedBy AS updatedBy, "
                    + "mst_rack.UpdatedDate AS updatedDate "
                  
                + "FROM mst_rack "
//                + "INNER JOIN scr_user_warehouse ON scr_user_warehouse.UserCode='"+userCode+"' AND mst_rack.WarehouseCode=scr_user_warehouse.WarehouseCode "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code = mst_rack.WarehouseCode "   
                + "WHERE 1=1 "
                    + "AND mst_rack.code LIKE '%"+code+"%' "
                    + "AND mst_rack.name LIKE '%"+name+"%' "
                   
                + concat_qry
                + " ORDER BY mst_rack.code ASC "
                + "")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                
                .setResultTransformer(Transformers.aliasToBean(RackTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
      public List<RackTemp> findSearchDataView(String code, String name, String warehouseCode, String warehouseName, String active,String userCode,int from, int row) {
        try {
            String concat_qry="";
            if(active.equals("NO") || active.equals("no")){
                active="false";
            }
            else if(active.equals("YES") || active.equals("yes")){
                active="true";
            }
            
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+" ";
            }
            List<RackTemp> list = (List<RackTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                        + "mst_rack.Code AS code, "
                        + "mst_rack.name AS name, "
                        + "mst_rack.RackCategory, "
                        + "mst_rack.WarehouseCode, "
                        + "mst_warehouse.name AS warehouseName, "
                        + "mst_rack.ActiveStatus, "
                        + "mst_rack.Remark AS remark, "
                        + "mst_rack.InActiveBy AS inActiveBy, "
                        + "mst_rack.InActiveDate AS inActiveDate, "
                        + "mst_rack.CreatedBy AS createdBy, "
                        + "mst_rack.CreatedDate AS createdDate, "
                        + "mst_rack.UpdatedBy AS updatedBy, "
                        + "mst_rack.UpdatedDate AS updatedDate, "
                        + "mst_warehouse.Dock_In_Code AS dockInCode, "
                        + "mst_warehouse.Dock_Dln_Code AS dockDlnCode  "
                  + "FROM mst_rack "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code = mst_rack.WarehouseCode "   
                + "WHERE 1=1 "
                    + "AND mst_rack.code LIKE '%"+code+"%' "
                    + "AND mst_rack.name LIKE '%"+name+"%' "
                    + "AND mst_warehouse.code LIKE '%"+warehouseCode+"%' "
                    + "AND mst_warehouse.name LIKE '%"+warehouseName+"%' "
                    + concat_qry
                    + "ORDER BY mst_rack.code ASC "
                    + "LIMIT "+from+","+row+"")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("rackCategory", Hibernate.STRING)
                    .addScalar("warehouseCode", Hibernate.STRING)
                    .addScalar("warehouseName", Hibernate.STRING)
                    .addScalar("activeStatus", Hibernate.BOOLEAN)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("inActiveBy", Hibernate.STRING)
                    .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                    .addScalar("createdBy", Hibernate.STRING)
                    .addScalar("createdDate", Hibernate.TIMESTAMP)
                    .addScalar("updatedDate", Hibernate.TIMESTAMP)
                    .addScalar("dockInCode", Hibernate.STRING)
                    .addScalar("dockDlnCode", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(RackTemp.class))
                    .list(); 
            
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<RackTemp> findSearchDataForRkm(String code, String name,String idWarehouseCode,String active,int from, int row) {
        try {
            String concat_qry="";
            if(active.equals("NO") || active.equals("no")){
                active="false";
            }
            else if(active.equals("YES") || active.equals("yes")){
                active="true";
            }
            
            if(!active.equals("")){
                concat_qry="AND mst_rack.ActiveStatus="+active+" ";
            }
            List<RackTemp> list = (List<RackTemp>)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_rack.Code AS code, "
                    + "mst_rack.name AS name, "
                    + "mst_rack.WarehouseCode, "
                    + "mst_warehouse.name AS warehouseName, "
                    + "mst_rack.ActiveStatus, "
                    + "mst_rack.Remark AS remark, "
                    + "mst_rack.InActiveBy AS inActiveBy, "
                    + "mst_rack.InActiveDate AS inActiveDate, "
                    + "mst_rack.CreatedBy AS createdBy, "
                    + "mst_rack.CreatedDate AS createdDate, "
                    + "mst_rack.UpdatedBy AS updatedBy, "
                    + "mst_rack.UpdatedDate AS updatedDate "
                  
                + "FROM mst_rack "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code = mst_rack.WarehouseCode "   
                + "WHERE 1=1 "
                    + "AND mst_rack.code LIKE '%"+code+"%' "
                    + "AND mst_rack.name LIKE '%"+name+"%' "
                    + "AND mst_rack.WarehouseCode = '"+idWarehouseCode+"'"
                + concat_qry
                + " ORDER BY mst_rack.code ASC "
                + "")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                
                .setResultTransformer(Transformers.aliasToBean(RackTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<Rack> findByCriteria(DetachedCriteria dc) {
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
    
   //Update
    public RackTemp get(String code) {
        try {
               RackTemp rackTemp = (RackTemp) hbmSession.hSession.createSQLQuery(""
                    +"SELECT "
                    + "mst_rack.Code AS code, "
                    + "mst_rack.name AS name, "
                    + "mst_rack.WarehouseCode, "
                    + "mst_warehouse.name AS warehouseName, "
//                    + "mst_rack.UnitOfMeasureCode, "
//                    + "mst_unit_of_measure.name AS unitOfMeasureName, "
                    + "mst_rack.ActiveStatus, "
                    + "mst_rack.RackCategory, "
                    + "mst_rack.Remark AS remark, "
                    + "mst_rack.InActiveBy AS inActiveBy, "
                    + "mst_rack.InActiveDate AS inActiveDate, "
                    + "mst_rack.CreatedBy AS createdBy, "
                    + "mst_rack.CreatedDate AS createdDate, "
                    + "mst_rack.UpdatedBy AS updatedBy, "
                    + "mst_rack.UpdatedDate AS updatedDate "
                + "FROM mst_rack "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code = mst_rack.WarehouseCode " 
      //          + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = mst_rack.UnitOfMeasureCode "
                + "WHERE 1=1 "
                    + "AND mst_rack.code = '"+code+"' ")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("rackCategory", Hibernate.STRING)
//                .addScalar("unitOfMeasureCode", Hibernate.STRING)
//                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(RackTemp.class))
                .uniqueResult(); 
                 
                return rackTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public void save(Rack rack, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            rack.setCode(createCode(rack));
            rack.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            rack.setCreatedDate(new Date()); 
//            rack.setCompanyCode(BaseSession.loadProgramSession().getCompanyCode());
//            String Id = rack.getCode();
//            rack.setId(Id);
            hbmSession.hSession.save(rack);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    rack.getCode(), "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(Rack rack, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            rack.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            rack.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(rack);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    rack.getCode(), "CAR BRAND"));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + RackField.BEAN_NAME + " WHERE " + RackField.ID + " = :prmId")
                    .setParameter("prmId", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, "CAR BRAND"));
             
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
    
    public int countData(String code,String name){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(DISTINCT mst_item_jn_current_stock.RackCode)AS count_rack "
            + "FROM mst_item_jn_current_stock "
            + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode=mst_rack.code "
            + "WHERE mst_item_jn_current_stock.RackCode LIKE '%"+code+"%' "
            + "AND mst_rack.`name` LIKE '%"+name+"%' "
            + "AND mst_rack.ActiveStatus=1 "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<RackTemp> findData(String code, String name,int from, int row) {
        try {   
            
            List<RackTemp> list = (List<RackTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "DISTINCT mst_item_jn_current_stock.RackCode as code, "
                + "mst_rack.name, "
                + "mst_rack.ActiveStatus "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode=mst_rack.code "
                + "WHERE mst_item_jn_current_stock.RackCode LIKE '%%' "
                + "AND mst_rack.`name` LIKE '%%' "
                + "AND mst_rack.ActiveStatus=1 "
                + "ORDER BY mst_item_jn_current_stock.RackCode "
                + "LIMIT "+from+","+row+"")
    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(RackTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
}