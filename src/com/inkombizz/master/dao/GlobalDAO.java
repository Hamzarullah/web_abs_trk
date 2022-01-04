
package com.inkombizz.master.dao;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Global;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;


public class GlobalDAO {
    
    private HBMSession hbmSession;

    public GlobalDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List<Global> usedBranch(String code){
        try {
            
            /// msh males benerin
            List<Global> lstGlobal = (List<Global>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "city_used.CityCode AS Code, "
                + "city_used.Code AS UsedCode, "
                + "city_used.UsedName "
                + "FROM( "
                + "SELECT mst_branch.Code,mst_branch.CityCode,'Branch' AS usedName FROM mst_branch UNION ALL "
                + "SELECT mst_commission_receiver.Code,mst_commission_receiver.CityCode,'Commission Receiver' AS usedName FROM mst_commission_receiver UNION ALL "
                + "SELECT mst_company.Code,mst_company.CityCode,'Company' AS usedName FROM mst_company UNION ALL "
                + "SELECT mst_customer.Code,mst_customer.CityCode,'Customer' AS usedName FROM mst_customer UNION ALL "
                + "SELECT mst_goods_invoice_destination.Code,mst_goods_invoice_destination.CityCode,'Goods Invoice Destination' AS usedName FROM mst_goods_invoice_destination UNION ALL "
                + "SELECT mst_employee.Code,mst_employee.CityCode,'Employee' AS usedName FROM mst_employee UNION ALL "
                + "SELECT mst_supplier.Code,mst_supplier.CityCode,'Supplier' AS usedName FROM mst_supplier UNION ALL "
                + "SELECT mst_supplier.Code,mst_supplier.NPWPCityCode AS CityCode,'Supplier' AS usedName FROM mst_supplier "
                + ")AS city_used "
                + "WHERE city_used.cityCode='"+code+"' "
                + "LIMIT 0,1")

                .addScalar("code", Hibernate.STRING)
                .addScalar("usedCode", Hibernate.STRING)
                .addScalar("usedName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(Global.class))
                .list(); 

                return lstGlobal;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Global> usedCity(String code){
        try {
            List<Global> lstGlobal = (List<Global>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "city_used.CityCode AS Code, "
                + "city_used.Code AS UsedCode, "
                + "city_used.UsedName "
                + "FROM( "
                + "SELECT mst_branch.Code,mst_branch.CityCode,'Branch' AS usedName FROM mst_branch UNION ALL "
                + "SELECT mst_commission_receiver.Code,mst_commission_receiver.CityCode,'Commission Receiver' AS usedName FROM mst_commission_receiver UNION ALL "
                + "SELECT mst_company.Code,mst_company.CityCode,'Company' AS usedName FROM mst_company UNION ALL "
                + "SELECT mst_customer.Code,mst_customer.CityCode,'Customer' AS usedName FROM mst_customer UNION ALL "
                + "SELECT mst_goods_invoice_destination.Code,mst_goods_invoice_destination.CityCode,'Goods Invoice Destination' AS usedName FROM mst_goods_invoice_destination UNION ALL "
                + "SELECT mst_employee.Code,mst_employee.CityCode,'Employee' AS usedName FROM mst_employee UNION ALL "
                + "SELECT mst_supplier.Code,mst_supplier.CityCode,'Supplier' AS usedName FROM mst_supplier UNION ALL "
                + "SELECT mst_supplier.Code,mst_supplier.NPWPCityCode AS CityCode,'Supplier' AS usedName FROM mst_supplier "
                + ")AS city_used "
                + "WHERE city_used.cityCode='"+code+"' "
                + "LIMIT 0,1")

                .addScalar("code", Hibernate.STRING)
                .addScalar("usedCode", Hibernate.STRING)
                .addScalar("usedName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(Global.class))
                .list(); 

                return lstGlobal;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Global> usedSalesman(String code){
        try {
            List<Global> lstGlobal = (List<Global>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "city_used.SalemanCode AS Code, "
                + "city_used.Code AS UsedCode, "
                + "city_used.UsedName "
                + "FROM( "
                + "SELECT sal_sales_order_item.Code,sal_sales_order_item.SalesmanCode,'Sales_Order_Item' AS usedName FROM sal_sales_order_item  "
                + ")AS salesman_used "
                + "WHERE salesman_used.SalesmanCode= :prmCode "
                + "LIMIT 0,1")

                .addScalar("code", Hibernate.STRING)
                .addScalar("usedCode", Hibernate.STRING)
                .addScalar("usedName", Hibernate.STRING)
                .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(Global.class))
                .list(); 

                return lstGlobal;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Global> usedCountry(String code){
        try {
            List<Global> lstGlobal = (List<Global>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "country_used.CountryCode AS Code, "
                + "country_used.Code AS UsedCode, "
                + "country_used.usedName "
                + "FROM ( "
                + "SELECT mst_province.Code,mst_province.CountryCode,'Province' AS usedName FROM mst_province UNION ALL "
                + "SELECT mst_supplier.Code,mst_supplier.CountryCode,'Supplier' AS usedName FROM mst_supplier UNION ALL "
                + "SELECT mst_supplier.Code,mst_supplier.NPWPCountryCode AS CountryCode,'Supplier' AS usedName FROM mst_supplier "
                + ")AS country_used "
                + "WHERE country_used.CountryCode='"+code+"' "
                + "LIMIT 0,1")

                .addScalar("code", Hibernate.STRING)
                .addScalar("usedCode", Hibernate.STRING)
                .addScalar("usedName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(Global.class))
                .list(); 

                return lstGlobal;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Global> usedCurrency(String code){
        try {
            List<Global> lstGlobal = (List<Global>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "currency_used.CurrencyCode AS Code, "
                + "currency_used.Code AS UsedCode, "
                + "currency_used.usedName "
                + "FROM ( "
                + "SELECT mst_chart_of_account.Code,mst_chart_of_account.CurrencyCode,'Chart Of Account [COA]' AS usedName FROM mst_chart_of_account "
                + ")AS currency_used "
                + "WHERE currency_used.CurrencyCode='"+code+"' "
                + "LIMIT 0,1")

                .addScalar("code", Hibernate.STRING)
                .addScalar("usedCode", Hibernate.STRING)
                .addScalar("usedName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(Global.class))
                .list(); 

                return lstGlobal;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    //COA
    
    //UOM -> ITEM
    
    //ITEM TYPE -> ITEM
    
    //Payment Term -> Supplier
    
    //Supplier -> Supplier Bank Account
}
