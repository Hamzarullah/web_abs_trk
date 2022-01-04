

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
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.RackType;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Warehouse;
import com.inkombizz.master.model.WarehouseTemp;
import com.inkombizz.master.model.WarehouseField;
import com.inkombizz.system.model.Setup;
import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import org.hibernate.criterion.Restrictions;



public class WarehouseDAO {
    
    private HBMSession hbmSession;
    
    public WarehouseDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(){   
        try{
            String acronim = "WHR";
            DetachedCriteria dc = DetachedCriteria.forClass(Warehouse.class)
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
                concat_qry="AND mst_warehouse.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_warehouse "
                + "INNER JOIN mst_city ON mst_city.code = mst_warehouse.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "            
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "             
                + "LEFT JOIN `mst_rack` ON `mst_rack`.`Code` = `mst_warehouse`.`Dock_In_Code` "
//                + "LEFT JOIN `mst_rack` ON `mst_rack`.`Code` = `mst_warehouse`.`Dock_DLN_Code` "
                + "WHERE mst_warehouse.code LIKE '%"+code+"%' "
                + "AND mst_warehouse.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
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
    
    public WarehouseTemp findData(String code) {
        try {
            WarehouseTemp warehouseTemp = (WarehouseTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_warehouse.Code, "
                + "mst_warehouse.name, "
                + "mst_warehouse.address, "
                + "mst_warehouse.phone1, "
                + "mst_warehouse.phone2, "
                + "mst_warehouse.fax, "            
                + "mst_warehouse.emailAddress, "            
                + "mst_warehouse.contactPerson, "
                + "mst_warehouse.cityCode, "
                + "mst_city.Name AS cityName, "
                + "mst_city.provinceCode, "
                + "mst_province.Name AS provinceName, "
                + "mst_province.islandCode, "
                + "mst_island.Name AS islandName, "
                + "mst_island.countryCode, "
                + "mst_country.Name AS countryName, "            
                + "mst_warehouse.Dock_In_Code AS dockInCode, "
                + "mst_warehouse.`DOCK_DLN_Code` AS dockDlnCode, "
                + "mst_warehouse.zipCode, "
                + "mst_warehouse.activeStatus, "
                + "mst_warehouse.remark, "
                + "mst_warehouse.InActiveBy, "
                + "mst_warehouse.InActiveDate, "
                + "mst_warehouse.CreatedBy, "
                + "mst_warehouse.CreatedDate "
                + "FROM mst_warehouse "
                + "INNER JOIN mst_city ON mst_city.code = mst_warehouse.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "            
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "               
                + "WHERE mst_warehouse.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("dockInCode", Hibernate.STRING)
                .addScalar("dockDlnCode", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(WarehouseTemp.class))
                .uniqueResult(); 
                 
                return warehouseTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public WarehouseTemp findData(String code,boolean active) {
        try {
            WarehouseTemp warehouseTemp = (WarehouseTemp)hbmSession.hSession.createSQLQuery(
                   "SELECT "
                + "mst_warehouse.Code, "
                + "mst_warehouse.name, "
                + "mst_warehouse.address, "
                + "mst_warehouse.phone1, "
                + "mst_warehouse.phone2, "       
                + "mst_warehouse.emailAddress, "       
                + "mst_warehouse.contactPerson, "
                + "mst_warehouse.cityCode, "
                + "mst_city.Name AS cityName, "
                + "mst_city.provinceCode, "
                + "mst_province.Name AS provinceName, "
                + "mst_province.islandCode, "
                + "mst_island.Name AS islandName, "
                + "mst_island.countryCode, "
                + "mst_country.Name AS countryName, "               
                + "mst_warehouse.dock_in_code AS dockInCode, "
                + "`DockIn`.`Name` AS dockInName, "
                + "mst_warehouse.`DOCK_DLN_Code` as dockDlnCode, "
                + "DockDln.name AS dockDlnName, "
                + "mst_warehouse.zipCode, "
                + "mst_warehouse.activeStatus, "
                + "mst_warehouse.remark "
//                + "mst_warehouse.InActiveBy, "
//                + "mst_warehouse.InActiveDate, "
//                + "mst_warehouse.CreatedBy, "
//                + "mst_warehouse.CreatedDate "
                + "FROM mst_warehouse "
                + "INNER JOIN mst_city ON mst_city.code = mst_warehouse.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "            
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "             
                + "LEFT JOIN `mst_rack` DockIn ON `DockIn`.`Code` = `mst_warehouse`.`Dock_In_Code` "
                + "LEFT JOIN `mst_rack` DockDln ON `DockDln`.`Code` = `mst_warehouse`.`Dock_DLN_Code` "
                + "WHERE mst_warehouse.code ='"+code+"' "
                + "AND mst_warehouse.ActiveStatus ="+active+" ")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("dockInCode", Hibernate.STRING)
                .addScalar("dockInName", Hibernate.STRING)
                .addScalar("dockDlnCode", Hibernate.STRING)
                .addScalar("dockDlnName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(WarehouseTemp.class))
                .uniqueResult(); 
                 
                return warehouseTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<WarehouseTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_warehouse.ActiveStatus="+active+" ";
            }
            List<WarehouseTemp> list = (List<WarehouseTemp>)hbmSession.hSession.createSQLQuery(
                     "SELECT "
                + "mst_warehouse.Code, "
                + "mst_warehouse.name, "
                + "mst_warehouse.address, "
                + "mst_warehouse.phone1, "
                + "mst_warehouse.phone2, "       
                + "mst_warehouse.emailAddress, "       
                + "mst_warehouse.contactPerson, "
                + "mst_warehouse.cityCode, "
                + "mst_city.Name AS cityName, "
                + "mst_city.provinceCode, "
                + "mst_province.Name AS provinceName, "
                + "mst_province.islandCode, "
                + "mst_island.Name AS islandName, "
                + "mst_island.countryCode, "
                + "mst_country.Name AS countryName, "               
                + "mst_warehouse.dock_in_code AS dockInCode, "
                + "`mst_rack`.`Name` AS dockInName, "
                + "mst_warehouse.`DOCK_DLN_Code` AS dockDlnCode, "
                + "mst_rack.name AS dockDlnName, "
                + "mst_warehouse.zipCode, "
                + "mst_warehouse.activeStatus, "
                + "mst_warehouse.remark "
//                + "mst_warehouse.InActiveBy, "
//                + "mst_warehouse.InActiveDate, "
//                + "mst_warehouse.CreatedBy, "
//                + "mst_warehouse.CreatedDate "
                + "FROM mst_warehouse "
                + "INNER JOIN mst_city ON mst_city.code = mst_warehouse.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "            
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "             
                + "LEFT JOIN `mst_rack` ON `mst_rack`.`Code` = `mst_warehouse`.`Dock_In_Code` "
//                + "LEFT JOIN `mst_rack` ON `mst_rack`.`Code` = `mst_warehouse`.`Dock_DLN_Code` "
                + "WHERE mst_warehouse.code LIKE '%"+code+"%' "
                + "AND mst_warehouse.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("dockInCode", Hibernate.STRING)
                .addScalar("dockInName", Hibernate.STRING)
                .addScalar("dockDlnCode", Hibernate.STRING)
                .addScalar("dockDlnName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
//                .addScalar("inActiveBy", Hibernate.STRING)
//                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
//                .addScalar("createdBy", Hibernate.STRING)
//                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(WarehouseTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Warehouse warehouse, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            warehouse.setCode(createCode());
            String codeDockIn = warehouse.getCode()  + "_DCI_001";
            String codeDockDln = warehouse.getCode()  + "_DLN_001";
            
            warehouse.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            warehouse.setCreatedDate(new Date()); 
            warehouse.setDockInCode(codeDockIn);
            warehouse.setDockDlnCode(codeDockDln);
            
            if(warehouse.getInActiveDate() == null){
                warehouse.setInActiveDate(DateUtils.newDate(1900, 01, 01));
            }
                        
            hbmSession.hSession.save(warehouse);
            
            String createdBy = warehouse.getCreatedBy();
            Date createdDate =  warehouse.getCreatedDate();
            String warehouseCode =  warehouse.getCode();
            
            // auto create dock-in
            Rack rack = new Rack();
            rack.setCode(codeDockIn);
            rack.setName(warehouse.getName() + " - DOCK IN");
                RackType rackType = new RackType();
                rackType.setCode(BaseSession.loadProgramSession().getSetup().getDefaultRackTypeCode());
            rack.setWarehouse(warehouse);
            rack.setRackCategory("DOCK_IN");
            rack.setActiveStatus(true);
            rack.setCreatedBy(createdBy);
            rack.setCreatedDate(createdDate);
            hbmSession.hSession.save(rack);
            
            Rack rack2 = new Rack();
            rack2.setCode(codeDockDln);
            rack2.setName(warehouse.getName() + " - DOCK DLN");
                RackType rackType2 = new RackType();
                rackType2.setCode(BaseSession.loadProgramSession().getSetup().getDefaultRackTypeCode());
            rack2.setWarehouse(warehouse);
            rack2.setRackCategory("DOCK_DLN");
            rack2.setActiveStatus(true);
            rack2.setCreatedBy(createdBy);
            rack2.setCreatedDate(createdDate);
            hbmSession.hSession.save(rack2);
  
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    warehouse.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
      public void saveRack(Warehouse warehouse, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            warehouse.setCode(createCode());
            // create header warehouse
            warehouse.setDockInCode(warehouse.getCode() + "_DCI_001");
            warehouse.setDockDlnCode(warehouse.getCode() + "_DDLN_001");
            warehouse.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            warehouse.setCreatedDate(new Date()); 
            
            if(warehouse.getInActiveDate() == null){
                warehouse.setInActiveDate(DateUtils.newDate(1900, 01, 01));
            }
                        
            hbmSession.hSession.save(warehouse);
            hbmSession.hSession.flush();
            
            // create rack automaticly
            Rack rack = new Rack();
            rack.setCode(warehouse.getCode() + "_DCI_001");
            rack.setCode(warehouse.getCode() + "_DDLN_001");
            rack.setName(warehouse.getName());
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Setup.class, "Setup");
            Setup setup = (Setup) criteria.getExecutableCriteria(hbmSession.hSession).list().get(0);
            
            RackType rackType = new RackType();
            rackType.setCode(setup.getCode());
            
            rack.setRackCategory("DOCK_IN");
            rack.setRackCategory("DOCK_DLN");
            rack.setWarehouse(warehouse);
            
            rack.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            rack.setCreatedDate(new Date());
            hbmSession.hSession.save(rack);
            hbmSession.hSession.flush();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    warehouse.getCode(), "WAREHOUSE_RACK"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void updateCustomerAddress(Warehouse warehouse, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            warehouse.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            warehouse.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(warehouse);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    warehouse.getCode(), "WAREHOUSE_CUSTOMER_ADDRESS"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
     
    public void update(Warehouse warehouse, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
           
            warehouse.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            warehouse.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(warehouse);
            hbmSession.hSession.flush();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    warehouse.getCode(), ""));
             
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
            hbmSession.hSession.createSQLQuery("DELETE FROM mst_rack WHERE WarehouseCode = '" + code + "'")
                    .executeUpdate();
            hbmSession.hSession.createQuery("DELETE FROM " + WarehouseField.BEAN_NAME + " WHERE " + WarehouseField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
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
