

package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBolt;
import com.inkombizz.system.dao.TransactionLogDAO;

import com.inkombizz.master.model.PurchaseDestination;
import com.inkombizz.master.model.PurchaseDestinationField;
import com.inkombizz.master.model.PurchaseDestinationTemp;
import java.math.BigInteger;
import java.text.ParseException;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;



public class PurchaseDestinationDAO {
    
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    public PurchaseDestinationDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(PurchaseDestination purchaseDestination){   
        try{
            String acronim = "PRCDST";
            DetachedCriteria dc = DetachedCriteria.forClass(PurchaseDestination.class)
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
                    concat_qry="AND mst_purchase_destination.ActiveStatus="+active+"";
                }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "WHERE mst_purchase_destination.code LIKE '%"+code+"%' "
                + "AND mst_purchase_destination.name LIKE '%"+name+"%' "
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
 
    public int countDataPD(String code,String name,String active,String billTo,String shipTo){
        try{
            String concat_qry="";
                if(!active.equals("")){
                    concat_qry="AND mst_purchase_destination.ActiveStatus="+active+"";
                }
                
            String bill_To = "";
                if(billTo.equals("TRUE")){
                    bill_To=" AND mst_purchase_destination.BillToStatus="+billTo+"";
                }
                
            String ship_To = "";
                if(shipTo.equals("TRUE")){
                    ship_To=" AND mst_purchase_destination.ShipToStatus="+shipTo+"";
                }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "WHERE mst_purchase_destination.code LIKE '%"+code+"%' "
                + "AND mst_purchase_destination.name LIKE '%"+name+"%' "
                + concat_qry
                + bill_To
                + ship_To
            ).uniqueResult();
            return temp.intValue();

        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseDestinationTemp> findDataPD(String code, String name,String active, String billTo, String shipTo, int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_purchase_destination.ActiveStatus="+active+" ";
            }
            
            String bill_To = "";
                if(billTo.equals("TRUE")){
                    bill_To=" AND mst_purchase_destination.BillToStatus="+billTo+"";
                }
                
            String ship_To = "";
                if(shipTo.equals("TRUE")){
                    ship_To=" AND mst_purchase_destination.ShipToStatus="+shipTo+"";
                }
            
            List<PurchaseDestinationTemp> list = (List<PurchaseDestinationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_purchase_destination.code, "
                + "mst_purchase_destination.name, "
                + "mst_purchase_destination.address, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_purchase_destination.phone1, "
                + "mst_purchase_destination.phone2, "
                + "mst_purchase_destination.fax, "
                + "mst_purchase_destination.EmailAddress, "
                + "mst_purchase_destination.ZipCode, "
                + "mst_purchase_destination.ContactPerson, "
                + "mst_purchase_destination.shipToStatus, "
                + "mst_purchase_destination.billToStatus, "
                + "mst_purchase_destination.activeStatus, "
                + "mst_purchase_destination.remark, "
                + "mst_purchase_destination.InActiveBy, "
                + "mst_purchase_destination.InActiveDate "
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "WHERE mst_purchase_destination.code LIKE '%"+code+"%' "
                + "AND mst_purchase_destination.name LIKE '%"+name+"%' "
                + concat_qry
                + bill_To
                + ship_To            
                + " ORDER BY mst_purchase_destination.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)  
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)     
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public PurchaseDestinationTemp findData(String code){
        try {
            PurchaseDestinationTemp purchaseDestinationTemp = (PurchaseDestinationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_purchase_destination.code, "
                + "mst_purchase_destination.name, "
                + "mst_purchase_destination.address, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_province.code AS ProvinceCode, "
                + "mst_province.name AS ProvinceName, "
                + "mst_island.code AS IslandCode, "
                + "mst_island.name As IslandName, "
                + "mst_country.code AS CountryCode, "
                + "mst_country.name As CountryName, "
                + "mst_purchase_destination.zipCode, "            
                + "mst_purchase_destination.phone1, "
                + "mst_purchase_destination.phone2, "
                + "mst_purchase_destination.fax, "
                + "mst_purchase_destination.EmailAddress, "
                + "mst_purchase_destination.ContactPerson, "
                + "mst_purchase_destination.shipToStatus, "
                + "mst_purchase_destination.billToStatus, "
                + "mst_purchase_destination.activeStatus, "
                + "mst_purchase_destination.Remark, "
                + "mst_purchase_destination.InActiveBy, "
                + "mst_purchase_destination.InActiveDate, "
                + "mst_purchase_destination.createdBy, "
                + "mst_purchase_destination.createdDate, "
                + "CASE WHEN IFNULL(sys_setup_bill.DefaultBillToCode,'')='' THEN "
                + "0 "
                + "WHEN sys_setup_bill.DefaultBillToCode=mst_purchase_destination.code THEN "
                + "1 "
                + "END AS DefaultBillToCode, "
                + "CASE WHEN IFNULL(sys_setup_ship.DefaultShipToCode,'')='' THEN "
                + "FALSE "
                + "WHEN sys_setup_ship.DefaultShipToCode=mst_purchase_destination.code THEN "
                + "TRUE "
                + "END AS DefaultShipToCode "
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.code "
                + "LEFT JOIN sys_setup sys_setup_bill ON mst_purchase_destination.`Code`=sys_setup_bill.DefaultBillToCode "
                + "LEFT JOIN sys_setup sys_setup_ship ON mst_purchase_destination.`Code`=sys_setup_ship.DefaultShipToCode "
                + "WHERE mst_purchase_destination.code ='"+code+"' ")

                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)    
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)    
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING) 
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)    
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
                .uniqueResult(); 

                return purchaseDestinationTemp;
        }catch (HibernateException e) {
            throw e;
        }
    }


    public PurchaseDestinationTemp findData(String code,boolean active) {
        try {
            PurchaseDestinationTemp purchaseDestinationTemp = (PurchaseDestinationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_purchase_destination.Code, "
                + "mst_purchase_destination.name, "
                + "mst_purchase_destination.address, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_province.Code AS ProvinceCode, "
                + "mst_province.Name AS ProvinceName, "
                + "mst_island.code AS IslandCode, "
                + "mst_island.name As IslandName, "
                + "mst_country.Code AS CountryCode, "
                + "mst_country.name As CountryName, "
                + "mst_purchase_destination.phone1, "
                + "mst_purchase_destination.phone2, "
                + "mst_purchase_destination.fax, "
                + "mst_purchase_destination.EmailAddress, "
                + "mst_purchase_destination.ZipCode, "
                + "mst_purchase_destination.ContactPerson "
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.code "     
                + "WHERE mst_purchase_destination.code ='"+code+"' "
                + "AND mst_purchase_destination.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)    
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)    
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)  
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
                .uniqueResult(); 
                 
                return purchaseDestinationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<PurchaseDestinationTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_purchase_destination.ActiveStatus="+active+" ";
            }
            List<PurchaseDestinationTemp> list = (List<PurchaseDestinationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_purchase_destination.code, "
                + "mst_purchase_destination.name, "
                + "mst_purchase_destination.address, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_purchase_destination.phone1, "
                + "mst_purchase_destination.phone2, "
                + "mst_purchase_destination.fax, "
                + "mst_purchase_destination.EmailAddress, "
                + "mst_purchase_destination.ZipCode, "
                + "mst_purchase_destination.ContactPerson, "
                + "mst_purchase_destination.shipToStatus, "
                + "mst_purchase_destination.billToStatus, "
                + "mst_purchase_destination.activeStatus, "
                + "mst_purchase_destination.remark, "
                + "mst_purchase_destination.InActiveBy, "
                + "mst_purchase_destination.InActiveDate "
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "WHERE mst_purchase_destination.code LIKE '%"+code+"%' "
                + "AND mst_purchase_destination.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_purchase_destination.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)  
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)     
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public PurchaseDestinationTemp findDataBillAndShip(String code, String status, String statusBillShip) {
        try {
               PurchaseDestinationTemp purchaseDestinationTemp = (PurchaseDestinationTemp) hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                + "mst_purchase_destination.code, "
                + "mst_purchase_destination.name, "
                + "mst_purchase_destination.address, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_purchase_destination.phone1, "
                + "mst_purchase_destination.phone2, "
                + "mst_purchase_destination.fax, "
                + "mst_purchase_destination.EmailAddress, "
                + "mst_purchase_destination.ZipCode, "
                + "mst_purchase_destination.ContactPerson, "
                + "mst_purchase_destination.shipToStatus, "
                + "mst_purchase_destination.billToStatus, "
                + "mst_purchase_destination.activeStatus, "
                + "mst_purchase_destination.remark, "
                + "mst_purchase_destination.InActiveBy, "
                + "mst_purchase_destination.InActiveDate "
                + "FROM mst_purchase_destination "
                + "INNER JOIN mst_city ON mst_purchase_destination.CityCode=mst_city.code "
                + "WHERE mst_purchase_destination.code LIKE :prmCode "
                + executeStatus(status)
                + status(statusBillShip) )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
                .uniqueResult(); 
                 
                return purchaseDestinationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    private String executeStatus(String val){
        
            String value="";
            if((val.equals("Active")) || (val.equals("YES"))){
                value=" AND mst_purchase_destination.ActiveStatus = 1 ";
            }else if((val.equals("InActive")) || (val.equals("NO"))){
                value=" AND mst_purchase_destination.ActiveStatus = 0 ";
            }else{
                value=" ";
            }
            
        return value;
    }
    
    private String status(String val){
        
            String value="";
            if((val.equals("BillTo")) || (val.equals("billTo"))){
                value=" AND mst_purchase_destination.BillToStatus = 1 ";
            }else if((val.equals("ShipTo")) || (val.equals("shipTo"))){
                value=" AND mst_purchase_destination.ShipToStatus = 1 ";
            }else{
                value=" ";
            }
            
        return value;
    }
    
    
//    public String createCode(){   
//        try{
//            
//            String acronim ="PD" + "-";
//            
//            DetachedCriteria dc = DetachedCriteria.forClass(PurchaseDestination.class)
//                    .setProjection(Projections.max("code"))
//                    .add(Restrictions.like("code",  acronim + "%" ));
//
//            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
//            List list = criteria.list();
//            
//            String oldID = "";
//            if(list != null){
//                if (list.size() > 0)
//                    if(list.get(0) != null)
//                        oldID = list.get(0).toString();
//            }
//            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_MASTER_LENGTH);
//        }        
//        catch(HibernateException e){
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
    public void save(PurchaseDestination purchaseDestination, PurchaseDestinationTemp purchaseDestinationTemp, String moduleCode) throws ParseException {
        try {
            hbmSession.hSession.beginTransaction();
            
//            purchaseDestination.setCode(createCode(purchaseDestination));
//            purchaseDestination.setCode(createCode());
            if(purchaseDestination.isActiveStatus()){
                purchaseDestination.setInActiveBy("");
                purchaseDestination.setInActiveDate(commonFunction.setDateTime("01/01/1900 00:00:00"));
            }else{
                purchaseDestination.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                purchaseDestination.setInActiveDate(new Date());
            }
            purchaseDestination.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseDestination.setCreatedDate(new Date()); 

            hbmSession.hSession.save(purchaseDestination);
            
//            if(purchaseDestinationTemp.getDefaultBillToCode() == true || purchaseDestinationTemp.getShipToStatus() == true){
            
                String code1apalahbebas = BaseSession.loadProgramSession().getSetup().getCode();

    //            Setup setup = new Setup();
                String concat_qry="";
                String concat_qry2="";
                 
                if(purchaseDestinationTemp.getDefaultBillToCode() == true && purchaseDestinationTemp.getDefaultShipToCode() == false){
                    concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"' ";
                }
                
                if(purchaseDestinationTemp.getDefaultBillToCode() == false && purchaseDestinationTemp.getDefaultShipToCode() == true){
                    concat_qry2=" sys_setup.DefaultShipToCode = '" +purchaseDestination.getCode() +"' ";
                }
                
                if(purchaseDestinationTemp.getDefaultBillToCode() == true && purchaseDestinationTemp.getDefaultShipToCode() == true){
                    concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"' , ";
                    concat_qry2=" sys_setup.DefaultShipToCode = '" +purchaseDestination.getCode() +"' ";
                } 
                
                if(purchaseDestinationTemp.getDefaultBillToCode() == false && purchaseDestinationTemp.getDefaultShipToCode() == false){
                    concat_qry=" sys_setup.DefaultBillToCode ='' , ";
                    concat_qry2=" sys_setup.DefaultShipToCode ='' ";
                }
//                if(purchaseDestinationTemp.getDefaultBillToCode() == true){
//                    if(purchaseDestinationTemp.getDefaultShipToCode() == true){
//                        concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"' , ";
//                    } else {
//                        concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"'  ";
//                    }
//                }
                    
//                if(purchaseDestinationTemp.getDefaultShipToCode() == true){
//                    concat_qry2=" sys_setup.DefaultShipToCode = '" +purchaseDestination.getCode() +"' ";
//                } 
                 hbmSession.hSession.createSQLQuery(""
                         + "UPDATE sys_setup "
                         + " SET "
                         + concat_qry 
                         + concat_qry2
                         + " WHERE code = '"+code1apalahbebas+"'").executeUpdate();
//            }
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    purchaseDestination.getCode() , ""));

            hbmSession.hTransaction.commit();
            }
        
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(PurchaseDestination purchaseDestination,PurchaseDestinationTemp purchaseDestinationTemp, String moduleCode) throws ParseException {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(purchaseDestination.isActiveStatus()){
                purchaseDestination.setInActiveBy("");
                purchaseDestination.setInActiveDate(commonFunction.setDateTime("01/01/1900 00:00:00"));
            }else{
                purchaseDestination.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                purchaseDestination.setInActiveDate(new Date());
            }
            purchaseDestination.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseDestination.setUpdatedDate(new Date()); 

            hbmSession.hSession.update(purchaseDestination);
            
            String code1apalahbebas = BaseSession.loadProgramSession().getSetup().getCode();

    //            Setup setup = new Setup();
                String concat_qry="";
                String concat_qry2="";
                 
                if(purchaseDestinationTemp.getDefaultBillToCode() == true && purchaseDestinationTemp.getDefaultShipToCode() == false){
                    concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"' ";
                }
                
                if(purchaseDestinationTemp.getDefaultBillToCode() == false && purchaseDestinationTemp.getDefaultShipToCode() == true){
                    concat_qry2=" sys_setup.DefaultShipToCode = '" +purchaseDestination.getCode() +"' ";
                }
                
                if(purchaseDestinationTemp.getDefaultBillToCode() == true && purchaseDestinationTemp.getDefaultShipToCode() == true){
                    concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"' , ";
                    concat_qry2=" sys_setup.DefaultShipToCode = '" +purchaseDestination.getCode() +"' ";
                } 
                
                if(purchaseDestinationTemp.getDefaultBillToCode() == false && purchaseDestinationTemp.getDefaultShipToCode() == false){
                    concat_qry=" sys_setup.DefaultBillToCode ='' , ";
                    concat_qry2=" sys_setup.DefaultShipToCode ='' ";
                } 
                
//                if(purchaseDestinationTemp.getDefaultBillToCode() == true){
//                    if(purchaseDestinationTemp.getDefaultShipToCode() == true){
//                        concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"' , ";
//                    } else {
//                        concat_qry=" sys_setup.DefaultBillToCode = '" +purchaseDestination.getCode() +"'  ";
//                    }
//                }
                    
//                if(purchaseDestinationTemp.getDefaultShipToCode() == true){
//                    concat_qry2=" sys_setup.DefaultShipToCode = '" +purchaseDestination.getCode() +"' ";
//                } 
                 hbmSession.hSession.createSQLQuery(""
                         + "UPDATE sys_setup "
                         + " SET "
                         + concat_qry 
                         + concat_qry2
                         + " WHERE code = '"+code1apalahbebas+"'").executeUpdate();
//            }
    
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    purchaseDestination.getCode(), ""));

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
            hbmSession.hSession.createQuery("DELETE FROM " + PurchaseDestinationField.BEAN_NAME + " WHERE " + PurchaseDestinationField.CODE + " = :prmCode")
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

        
    public PurchaseDestinationTemp min() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_purchase_destination.code, "
                    + "mst_purchase_destination.Name "
                    + "FROM mst_purchase_destination "
                    + "ORDER BY mst_purchase_destination.code "
                    + "LIMIT 0,1";
            PurchaseDestinationTemp purchaseDestinationTemp =(PurchaseDestinationTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
            .uniqueResult();   
            
            return purchaseDestinationTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public PurchaseDestinationTemp max() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_purchase_destination.code, "
                    + "mst_purchase_destination.Name "
                    + "FROM mst_purchase_destination "
                    + "ORDER BY mst_purchase_destination.code DESC "
                    + "LIMIT 0,1";
            PurchaseDestinationTemp purchaseDestinationTemp =(PurchaseDestinationTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(PurchaseDestinationTemp.class))
            .uniqueResult();   
            
            return purchaseDestinationTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
}
