package com.inkombizz.finance.dao;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.FinanceDocumentTemp;
//import com.inkombizz.inventory.model.GoodsReceivedNoteDepositDetailTemp;
import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

public class FinanceDocumentDAO {

    private HBMSession hbmSession;

    public FinanceDocumentDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(FinanceDocumentTemp financeDocument) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(financeDocument.getPeriodFirstDate());
            String dateLast = DATE_FORMAT.format(financeDocument.getPeriodLastDate());

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "CALL usp_finance_document_list(:prmFlag,:prmDocumentFinanceID,:prmBranchCode,:prmDocumentNo,:prmDocumentRefNo,:prmCustomerVendorCode,:prmCustomerVendorName,"
                    + ":prmCurrencyCode,:prmShipToCode,:prmShipToName,:prmBillToCode,:prmBillToName,:prmFirstDate,:prmLastDate,'-','-',0,0)"
            )
                    .setParameter("prmFlag", "COUNT")
                    .setParameter("prmDocumentFinanceID", financeDocument.getFinanceDocumentID())
                    .setParameter("prmBranchCode", "%" + financeDocument.getBranchCode() + "%")
                    .setParameter("prmDocumentNo", "%" + financeDocument.getDocumentNo() + "%")
                    .setParameter("prmDocumentRefNo", "%" + financeDocument.getDocumentRefNo() + "%")
                    .setParameter("prmCustomerVendorCode", "%" + financeDocument.getCustomerVendorCode() + "%")
                    .setParameter("prmCustomerVendorName", "%" + financeDocument.getCustomerVendorName() + "%")
                    .setParameter("prmCurrencyCode", "%" + financeDocument.getCurrencyCode() + "%")
                    .setParameter("prmShipToCode", "%" + financeDocument.getShipToCode() + "%")
                    .setParameter("prmShipToName", "%" + financeDocument.getShipToName() + "%")
                    .setParameter("prmBillToCode", "%" + financeDocument.getBillToCode() + "%")
                    .setParameter("prmBillToName", "%" + financeDocument.getBillToName() + "%")
                    .setParameter("prmFirstDate", dateFirst)
                    .setParameter("prmLastDate", dateLast)
                    .uniqueResult();
            return temp.intValue();

        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public int countDataDeposit(String code, Date firstDate, Date lastDate) {
        try {
            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                    + "COUNT(*) "
                    + "FROM "
                    + "( "
                    + "SELECT fin_cash_payment_deposit.`Code`,fin_cash_payment_deposit.`TransactionDate`,fin_cash_payment_deposit.`GrandTotalAmount` FROM `fin_cash_payment_deposit` "
                    + "UNION ALL "
                    + "SELECT fin_bank_payment_deposit.`Code`,fin_bank_payment_deposit.`TransactionDate`,fin_bank_payment_deposit.`GrandTotalAmount` FROM `fin_bank_payment_deposit` "
                    + "UNION ALL "
                    + "SELECT fin_cash_received_deposit.`Code`,fin_cash_received_deposit.`TransactionDate`,fin_cash_received_deposit.`GrandTotalAmount` FROM `fin_cash_received_deposit` "
                    + "UNION ALL "
                    + "SELECT `fin_bank_received_deposit`.`Code`,fin_bank_received_deposit.`TransactionDate`,fin_bank_received_deposit.`GrandTotalAmount` FROM `fin_bank_received_deposit` "
                    + ")AS data_deposit "
                    + "WHERE data_deposit.code LIKE :prmCode "
                    + "AND DATE(data_deposit.TransactionDate) BETWEEN DATE(:prmFirstDate) AND DATE(:prmLastDate)")
                    .setParameter("prmCode", "%" + code + "%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .uniqueResult();
            return temp.intValue();

        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public int countDataDepositPayment(String code, Date firstDate, Date lastDate) {
        try {
            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(" "
                    + "SELECT COUNT(*) FROM ( "
                    + "SELECT "
                    + "'VDP-BKK' AS DocumentType, "
                    + "fin_cash_payment_deposit.Code, "
                    + "fin_cash_payment_deposit.TransactionDate, "
                    + "fin_cash_payment_deposit.GrandTotalAmount, "
                    + "fin_cash_payment_deposit.UsedAmount, "
                    + "(fin_cash_payment_deposit.GrandTotalAmount - fin_cash_payment_deposit.UsedAmount) AS AppliedAmount "
                    + "FROM fin_cash_payment_deposit "
                    + "UNION ALL "
                    + "SELECT "
                    + "'VDP-BBK' AS DocumentType, "
                    + "fin_bank_payment_deposit.Code, "
                    + "fin_bank_payment_deposit.TransactionDate, "
                    + "fin_bank_payment_deposit.GrandTotalAmount, "
                    + "fin_bank_payment_deposit.UsedAmount, "
                    + "(fin_bank_payment_deposit.GrandTotalAmount - fin_bank_payment_deposit.UsedAmount) AS AppliedAmount "
                    + "FROM fin_bank_payment_deposit "
                    + ")AS data_deposit "
                    + "WHERE data_deposit.code LIKE :prmCode "
                    + "AND DATE(data_deposit.TransactionDate) BETWEEN DATE(:prmFirstDate) AND DATE(:prmLastDate)"
                    + "AND data_deposit.appliedAmount > 0 ")
                    .setParameter("prmCode", "%" + code + "%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .uniqueResult();
            return temp.intValue();

        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public List<FinanceDocumentTemp> findData(FinanceDocumentTemp financeDocument, int from, int to) {
        try {

            List<FinanceDocumentTemp> list = (List<FinanceDocumentTemp>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_finance_document_list(:prmFlag,:prmDocumentFinanceID,:prmBranchCode,:prmDocumentNo,:prmDocumentRefNo,:prmCustomerVendorCode,:prmCustomerVendorName,"
                    + ":prmCurrencyCode,:prmShipToCode,:prmShipToName,:prmBillToCode,:prmBillToName,:prmFirstDate,:prmLastDate,:prmSortBy,:prmOrderBy,:prmLimitFrom,:prmLimitUpTo)"
            )
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("documentType", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .addScalar("documentRefNo", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("dueDate", Hibernate.TIMESTAMP)
                    .addScalar("shipToCode", Hibernate.STRING)
                    .addScalar("shipToName", Hibernate.STRING)
                    .addScalar("billToCode", Hibernate.STRING)
                    .addScalar("billToName", Hibernate.STRING)
                    .addScalar("customerVendorCode", Hibernate.STRING)
                    .addScalar("customerVendorName", Hibernate.STRING)
                    .addScalar("vendorInvoiceNo", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("chartOfAccountCode", Hibernate.STRING)
                    .addScalar("chartOfAccountName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("GrandTotalAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("PaidAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("Balance", Hibernate.BIG_DECIMAL)
                    .addScalar("debit", Hibernate.BIG_DECIMAL)
                    .addScalar("credit", Hibernate.BIG_DECIMAL)
                    .setParameter("prmFlag", "LISTS")
                    .setParameter("prmDocumentFinanceID", financeDocument.getFinanceDocumentID())
                    .setParameter("prmBranchCode", "%" + financeDocument.getBranchCode() + "%")
                    .setParameter("prmDocumentNo", "%" + financeDocument.getDocumentNo() + "%")
                    .setParameter("prmDocumentRefNo", "%" + financeDocument.getDocumentRefNo() + "%")
                    .setParameter("prmCustomerVendorCode", "%" + financeDocument.getCustomerVendorCode() + "%")
                    .setParameter("prmCustomerVendorName", "%" + financeDocument.getCustomerVendorName() + "%")
                    .setParameter("prmCurrencyCode", "%" + financeDocument.getCurrencyCode() + "%")
                    .setParameter("prmShipToCode", "%" + financeDocument.getShipToCode() + "%")
                    .setParameter("prmShipToName", "%" + financeDocument.getShipToName() + "%")
                    .setParameter("prmBillToCode", "%" + financeDocument.getBillToCode() + "%")
                    .setParameter("prmBillToName", "%" + financeDocument.getBillToName() + "%")
                    .setParameter("prmFirstDate", financeDocument.getPeriodFirstDate())
                    .setParameter("prmLastDate", financeDocument.getPeriodLastDate())
                    .setParameter("prmSortBy", financeDocument.getSortByFinanceDocument())
                    .setParameter("prmOrderBy", financeDocument.getOrderByFinanceDocument())
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", to)
                    .setResultTransformer(Transformers.aliasToBean(FinanceDocumentTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

    public void updatePaidAount(String documentType, BigDecimal amount, String documentNo, String headerCode) {
        hbmSession.hSession.beginTransaction();

        if (documentType.equals("CCN")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_customer_credit_note "
                    + "SET  "
                    + "	fin_customer_credit_note.PaidAmount = (fin_customer_credit_note.PaidAmount + :prmAmount), "
                    + "	fin_customer_credit_note.SettlementDocumentNo = "
                    + "	CASE WHEN fin_customer_credit_note.`GrandTotalAmount`=fin_customer_credit_note.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_customer_credit_note.SettlementDate = CASE WHEN fin_customer_credit_note.`GrandTotalAmount`=fin_customer_credit_note.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_customer_credit_note.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
        } else if (documentType.equals("CDN")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_customer_debit_note "
                    + "SET  "
                    + "	fin_customer_debit_note.PaidAmount = (fin_customer_debit_note.PaidAmount + :prmAmount), "
                    + "	fin_customer_debit_note.SettlementDocumentNo = "
                    + "	CASE WHEN fin_customer_debit_note.`GrandTotalAmount`=fin_customer_debit_note.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_customer_debit_note.SettlementDate = CASE WHEN fin_customer_debit_note.`GrandTotalAmount`=fin_customer_debit_note.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_customer_debit_note.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
        } else if (documentType.equals("CDP-BBM")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_bank_received_deposit "
                    + "SET  "
                    + "	fin_bank_received_deposit.PaidAmount = (fin_bank_received_deposit.PaidAmount + :prmAmount), "
                    + "	fin_bank_received_deposit.SettlementDocumentNo = "
                    + "	CASE WHEN fin_bank_received_deposit.`GrandTotalAmount`=fin_bank_received_deposit.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_bank_received_deposit.SettlementDate = CASE WHEN fin_bank_received_deposit.`GrandTotalAmount`=fin_bank_received_deposit.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_bank_received_deposit.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
        } else if (documentType.equals("CDP-BKM")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_cash_received_deposit "
                    + "SET  "
                    + "	fin_cash_received_deposit.PaidAmount = (fin_cash_received_deposit.PaidAmount + :prmAmount), "
                    + "	fin_cash_received_deposit.SettlementDocumentNo = "
                    + "	CASE WHEN fin_cash_received_deposit.`GrandTotalAmount`=fin_cash_received_deposit.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_cash_received_deposit.SettlementDate = CASE WHEN fin_cash_received_deposit.`GrandTotalAmount`=fin_cash_received_deposit.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_cash_received_deposit.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();

        } else if (documentType.equals("CDP-P")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_customer_down_payment_paid "
                    + "SET  "
                    + "	fin_customer_down_payment_paid.PaidAmount = (fin_customer_down_payment_paid.PaidAmount + :prmAmount), "
                    + "	fin_customer_down_payment_paid.SettlementDocumentNo = "
                    + "	CASE WHEN fin_customer_down_payment_paid.GrandTotalAmount =fin_customer_down_payment_paid.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_customer_down_payment_paid.SettlementDate = CASE WHEN fin_customer_down_payment_paid.GrandTotalAmount=fin_customer_down_payment_paid.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_customer_down_payment_paid.Code = :prmCode"
            )
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();

        } else if (documentType.equals("CDP-U")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_customer_down_payment_used "
                    + " SET fin_customer_down_payment_used.UsedAmount = (fin_customer_down_payment_used.UsedAmount+:prmAmount) "
                    + " WHERE fin_customer_down_payment_used.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();

        } else if (documentType.equals("VCN")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_vendor_credit_note "
                    + "SET  "
                    + "	fin_vendor_credit_note.PaidAmount = (fin_vendor_credit_note.PaidAmount + :prmAmount), "
                    + "	fin_vendor_credit_note.SettlementDocumentNo = "
                    + "	CASE WHEN fin_vendor_credit_note.`GrandTotalAmount`=fin_vendor_credit_note.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_vendor_credit_note.SettlementDate = CASE WHEN fin_vendor_credit_note.`GrandTotalAmount`=fin_vendor_credit_note.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_vendor_credit_note.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
            
        } else if (documentType.equals("VDN")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_vendor_debit_note "
                    + "SET  "
                    + "	fin_vendor_debit_note.PaidAmount = (fin_vendor_debit_note.PaidAmount + :prmAmount), "
                    + "	fin_vendor_debit_note.SettlementDocumentNo = "
                    + "	CASE WHEN fin_vendor_debit_note.`GrandTotalAmount`=fin_vendor_debit_note.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_vendor_debit_note.SettlementDate = CASE WHEN fin_vendor_debit_note.`GrandTotalAmount`=fin_vendor_debit_note.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_vendor_debit_note.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
            
        } else if (documentType.equals("VDP-BBK")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_bank_payment_deposit "
                    + "SET  "
                    + "	fin_bank_payment_deposit.PaidAmount = (fin_bank_payment_deposit.PaidAmount + :prmAmount), "
                    + "	fin_bank_payment_deposit.SettlementDocumentNo = "
                    + "	CASE WHEN fin_bank_payment_deposit.`GrandTotalAmount`=fin_bank_payment_deposit.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_bank_payment_deposit.SettlementDate = CASE WHEN fin_bank_payment_deposit.`GrandTotalAmount`=fin_bank_payment_deposit.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_bank_payment_deposit.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
            
        } else if (documentType.equals("VDP-BKK")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_cash_payment_deposit "
                    + "SET  "
                    + "	fin_cash_payment_deposit.PaidAmount = (fin_cash_payment_deposit.PaidAmount + :prmAmount), "
                    + "	fin_cash_payment_deposit.SettlementDocumentNo = "
                    + "	CASE WHEN fin_cash_payment_deposit.`GrandTotalAmount`=fin_cash_payment_deposit.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_cash_payment_deposit.SettlementDate = CASE WHEN fin_cash_payment_deposit.`GrandTotalAmount`=fin_cash_payment_deposit.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_cash_payment_deposit.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();
            
        } else if (documentType.equals("VDP-P")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_vendor_down_payment_paid "
                    + "SET  "
                    + "	fin_vendor_down_payment_paid.PaidAmount = (fin_vendor_down_payment_paid.PaidAmount + :prmAmount), "
                    + "	fin_vendor_down_payment_paid.SettlementDocumentNo = "
                    + "	CASE WHEN fin_vendor_down_payment_paid.GrandTotalAmount =fin_vendor_down_payment_paid.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_vendor_down_payment_paid.SettlementDate = CASE WHEN fin_vendor_down_payment_paid.GrandTotalAmount = fin_vendor_down_payment_paid.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_vendor_down_payment_paid.Code = :prmCode"
            )
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();

        } else if (documentType.equals("VDP-U")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_vendor_down_payment_used "
                    + " SET fin_vendor_down_payment_used.UsedAmount = (fin_vendor_down_payment_used.UsedAmount+:prmAmount) "
                    + " WHERE fin_vendor_down_payment_used.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();
            
        } else if (documentType.equals("VIN")) {
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_vendor_invoice "
                    + "SET  "
                    + "	fin_vendor_invoice.PaidAmount = (fin_vendor_invoice.PaidAmount + :prmAmount), "
                    + "	fin_vendor_invoice.SettlementDocumentNo = "
                    + "	CASE WHEN fin_vendor_invoice.`GrandTotalAmount`=fin_vendor_invoice.PaidAmount THEN "
                    + "		:prmDocNo "
                    + "	ELSE "
                    + "		null "
                    + "	END,  "
                    + "	fin_vendor_invoice.SettlementDate = CASE WHEN fin_vendor_invoice.`GrandTotalAmount`=fin_vendor_invoice.PaidAmount THEN "
                    + "		:prmDocDate "
                    + "	ELSE "
                    + "		'1900-01-01' "
                    + "	END  "
                    + "WHERE fin_vendor_invoice.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmDocNo", headerCode)
                    .setParameter("prmDocDate", DateUtils.toString(new Date(), "yyyy-MM-dd"))
                    .executeUpdate();

        }

    }

    public void emptyPaidAount(String documentType, String documentNo, BigDecimal amount) {
        hbmSession.hSession.beginTransaction();

        if (documentType.equals("VIN-PST")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_vendor_invoice_posting "
                    + " SET fin_vendor_invoice_posting.PaidAmount = (fin_vendor_invoice_posting.PaidAmount-:prmAmount) , "
                    + " fin_vendor_invoice_posting.SettlementDocumentNo = '', "
                    + " fin_vendor_invoice_posting.SettlementDate = '1900-01-01' "
                    + " WHERE fin_vendor_invoice_posting.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();

        } else if (documentType.equals("VDP-BKK")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_cash_payment_deposit "
                    + " SET fin_cash_payment_deposit.UsedAmount = (fin_cash_payment_deposit.UsedAmount-:prmAmount), "
                    + " fin_cash_payment_deposit.SettlementDocumentNo = '', "
                    + " fin_cash_payment_deposit.SettlementDate = '1900-01-01' "
                    + " WHERE fin_cash_payment_deposit.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();
        } else if (documentType.equals("VDP-BBK")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_bank_payment_deposit "
                    + " SET fin_bank_payment_deposit.UsedAmount = (fin_bank_payment_deposit.UsedAmount-:prmAmount), "
                    + " fin_bank_payment_deposit.SettlementDocumentNo = '', "
                    + " fin_bank_payment_deposit.SettlementDate = '1900-01-01' "
                    + " WHERE fin_bank_payment_deposit.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();
        } else if (documentType.equals("CDP-U")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_customer_down_payment_used "
                    + " SET fin_customer_down_payment_used.UsedAmount = (fin_customer_down_payment_used.UsedAmount-:prmAmount) "
                    + " WHERE fin_customer_down_payment_used.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();
        } else if (documentType.equals("CDP-P")) {
            hbmSession.hSession.createSQLQuery("UPDATE fin_customer_down_payment_paid "
                    + " SET fin_customer_down_payment_paid.PaidAmount = (fin_customer_down_payment_paid.PaidAmount-:prmAmount) "
                    + " WHERE fin_customer_down_payment_paid.Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .executeUpdate();
        }
    }

    public FinanceDocumentTemp cekPaidAount(String documentType, String documentNo, BigDecimal amount) {
        FinanceDocumentTemp financeDocumentTemp = null;

        if (documentType.equals("INV")) {

            BigDecimal temp = (BigDecimal) hbmSession.hSession.createSQLQuery(""
                    + "SELECT (GrandTotalAmount-(PaidAMount+:prmAmount)) as balancepaid sal_invoice "
                    + " WHERE Code = :prmCode")
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmAmount", amount)
                    .uniqueResult();
            if (temp.intValue() < 0) {
                financeDocumentTemp = new FinanceDocumentTemp();
                financeDocumentTemp.setDocumentNo(documentNo);
                return financeDocumentTemp;
            }

        } else if (documentType.equals("CDP-BKM")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_cash_receiving_downpayment "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CDP-BBM")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_bank_receiving_downpayment "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("SDP-BKK")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_cash_payment_deposit "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("SDP-BBK")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_bank_payment_deposit "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CCN")) {
//            hbmSession.hSession.createSQLQuery("UPDATE sal_customer_credit_note "
//                    + " SET PaidAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '1900-01-01', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CDN")) {
//            hbmSession.hSession.createSQLQuery("UPDATE sal_customer_debit_note "
//                    + " SET PaidAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '1900-01-01', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("SCN")) {
            BigDecimal temp = (BigDecimal) hbmSession.hSession.createSQLQuery(""
                    + " SELECT (GrandTotalAmount-(PaidAMount+:prmAmount)) as balancepaid FROM pur_supplier_credit_note "
                    + " WHERE Code = :prmCode")
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .uniqueResult();
            if (temp.intValue() < 0) {
                financeDocumentTemp = new FinanceDocumentTemp();
                financeDocumentTemp.setDocumentNo(documentNo);
                return financeDocumentTemp;
            }
        } else if (documentType.equals("SDN")) {
//            hbmSession.hSession.createSQLQuery("UPDATE pur_supplier_debit_note "
//                    + " SET PaidAMount = :prmAmount, "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CCN-SRT")) {

        } else if (documentType.equals("VIN")) {
        } else if (documentType.equals("PRT")) {
        }

        return financeDocumentTemp;
    }

    public FinanceDocumentTemp cekPaidAmountUpdate(String documentType, String documentNo, BigDecimal amount, BigDecimal amountOld) {
        FinanceDocumentTemp financeDocumentTemp = null;

        if (documentType.equals("INV")) {

            BigDecimal temp = (BigDecimal) hbmSession.hSession.createSQLQuery(""
                    + "SELECT (GrandTotalAmount -((PaidAMount-:prmAmountOld)+:prmAmount)) as balancepaid sal_invoice "
                    + " WHERE Code = :prmCode")
                    .setParameter("prmCode", documentNo)
                    .setParameter("prmAmountOld", amountOld)
                    .setParameter("prmAmount", amount)
                    .uniqueResult();
            if (temp.intValue() < 0) {
                financeDocumentTemp = new FinanceDocumentTemp();
                financeDocumentTemp.setDocumentNo(documentNo);
                return financeDocumentTemp;
            }

        } else if (documentType.equals("CDP-BKM")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_cash_receiving_downpayment "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CDP-BBM")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_bank_receiving_downpayment "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("SDP-BKK")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_cash_payment_deposit "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("SDP-BBK")) {
//            hbmSession.hSession.createSQLQuery("UPDATE fin_bank_payment_deposit "
//                    + " SET UsedAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CCN")) {
//            hbmSession.hSession.createSQLQuery("UPDATE sal_customer_credit_note "
//                    + " SET PaidAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '1900-01-01', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CDN")) {
//            hbmSession.hSession.createSQLQuery("UPDATE sal_customer_debit_note "
//                    + " SET PaidAMount = (PaidAMount-:prmAmount), "
//                    + " SETTLEMENTDOCUMENTNO = '1900-01-01', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("SCN")) {
            BigDecimal temp = (BigDecimal) hbmSession.hSession.createSQLQuery(""
                    + " SELECT (GrandTotalAmount -((PaidAMount-:prmAmountOld)+:prmAmount)) as balancepaid FROM pur_supplier_credit_note "
                    + " WHERE Code = :prmCode")
                    .setParameter("prmAmountOld", amountOld)
                    .setParameter("prmAmount", amount)
                    .setParameter("prmCode", documentNo)
                    .uniqueResult();
            if (temp.intValue() < 0) {
                financeDocumentTemp = new FinanceDocumentTemp();
                financeDocumentTemp.setDocumentNo(documentNo);
                return financeDocumentTemp;
            }
        } else if (documentType.equals("SDN")) {
//            hbmSession.hSession.createSQLQuery("UPDATE pur_supplier_debit_note "
//                    + " SET PaidAMount = :prmAmount, "
//                    + " SETTLEMENTDOCUMENTNO = '', "
//                    + " SETTLEMENTDATE = '1900-01-01' "
//                    + " WHERE Code = :prmCode")
//                    .setParameter("prmAmount", amount)
//                    .setParameter("prmCode", documentNo)
//                    .executeUpdate();
        } else if (documentType.equals("CCN-SRT")) {

        } else if (documentType.equals("VIN")) {
        } else if (documentType.equals("PRT")) {
        }

        return financeDocumentTemp;
    }

    public List<FinanceDocumentTemp> findDataFinanceExisting(String documentNo) {
        try {

            List<FinanceDocumentTemp> list = (List<FinanceDocumentTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "DataDocument.headerCode, "
                    + "DataDocument.DocumentNo "
                    + "FROM("
                    + "SELECT "
                    + "fin_cash_payment_detail.headerCode, "
                    + "fin_cash_payment_detail.DocumentNo "
                    + "FROM fin_cash_payment_detail "
                    + "UNION ALL "
                    + "SELECT "
                    + "fin_bank_payment_detail.headerCode, "
                    + "fin_bank_payment_detail.DocumentNo "
                    + "FROM fin_bank_payment_detail "
                    + "UNION ALL "
                    + "SELECT "
                    + "fin_cash_received_detail.headerCode, "
                    + "fin_cash_received_detail.DocumentNo "
                    + "FROM fin_cash_received_detail "
                    + "UNION ALL "
                    + "SELECT "
                    + "fin_bank_received_detail.headerCode, "
                    + "fin_bank_received_detail.DocumentNo "
                    + "FROM fin_bank_received_detail "
                    + "UNION ALL "
                    + "SELECT "
                    + "fin_general_journal_detail.headerCode, "
                    + "fin_general_journal_detail.DocumentNo "
                    + "FROM fin_general_journal_detail "
                    + ")AS DataDocument "
                    + "WHERE DataDocument.DocumentNo='" + documentNo + "'")
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(FinanceDocumentTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

    public List<FinanceDocumentTemp> findDataPaymentRequestExisting(String documentNo) {
        try {

            List<FinanceDocumentTemp> list = (List<FinanceDocumentTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_payment_request_detail.HeaderCode, "
                    + "fin_payment_request_detail.DocumentNo "
                    + "FROM fin_payment_request_detail "
                    + "WHERE fin_payment_request_detail.DocumentNo='" + documentNo + "'")
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(FinanceDocumentTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

    public List<FinanceDocumentTemp> findDataPaymentRequestExistingBankPayment(String paymentRequestNo) {
        try {

            List<FinanceDocumentTemp> list = (List<FinanceDocumentTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_bank_payment.Code AS headerCode "
                    + "FROM fin_bank_payment "
                    + "WHERE fin_bank_payment.PaymentRequestNo='" + paymentRequestNo + "'")
                    .addScalar("headerCode", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(FinanceDocumentTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

}
