package com.inkombizz.reports.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.model.CustomerSalesOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.io.InputStream;
import java.sql.Connection;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="sales/sales-order-unprice.jsp"),
    @Result(name="redirect", type="redirect", location="../../pages/noauthority.jsp"),
    @Result(name="JASPER_PDF", type="jasper", params={"location", "report/sales/sales-order-unprice-print-out.jasper", "connection", "sqlConn", "reportParameters", "reportParams", "format", "PDF", "documentName", "sales_order_unprice_print_out"})
})
public class SalesOrderUnpricePrintOutAction extends ActionSupport{
    
    private static final String MODULECODE = "002_SAL_SALES_ORDER_UNPRICE";
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerSalesOrder salesOrder=null;
    
    private Connection sqlConn;
    private InputStream inputStream ;
    Map<String, Object> reportParams;
    
        
    @Override
    public String execute() {
        try {
                        
            if (!BaseSession.loadProgramSession().hasAuthority(MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
                
                return "redirect";
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    private Map<String, Object> setReportParams() throws ParseException{
       
       reportParams = new HashMap<String, Object>();
       String Temp = BaseSession.loadProgramSession().getSetup().getCompanyName();
       String telp = BaseSession.loadProgramSession().getSetup().getHeadOfficePhone1();
       String address = BaseSession.loadProgramSession().getSetup().getHeadOfficeAddress(); 
        reportParams.put("prmCode",salesOrder.getCode());
        reportParams.put("prmBranchName",Temp);
        reportParams.put("prmBranchAddress",address);
        reportParams.put("prmBranchTelp",telp);  
     
        
        return reportParams;
    }
    
    @Action("sales-order-unprice-print-out-pdf")
    public String exportPDF() {
        try {
            
            if (!BaseSession.loadProgramSession().hasAuthority(MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
                return "redirect";
            }

            sqlConn = hbmSession.hSession.connection();
            
            reportParams = setReportParams();
            
            return "JASPER_PDF";
        }
        catch(Exception ex) {
            //do nothing dulu
            return "JASPER_PDF";
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerSalesOrder getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(CustomerSalesOrder salesOrder) {
        this.salesOrder = salesOrder;
    }

    public Connection getSqlConn() {
        return sqlConn;
    }

    public void setSqlConn(Connection sqlConn) {
        this.sqlConn = sqlConn;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public Map<String, Object> getReportParams() {
        return reportParams;
    }

    public void setReportParams(Map<String, Object> reportParams) {
        this.reportParams = reportParams;
    }

    
    
}

