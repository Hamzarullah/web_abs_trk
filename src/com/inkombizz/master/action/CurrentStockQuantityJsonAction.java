
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.CurrentStockQuantityBLL;
import com.inkombizz.master.model.CurrentStockQuantity;
import com.inkombizz.master.model.CurrentStockQuantityTemp;
import com.inkombizz.utils.Globalize;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Workbook;

@Result (type="json")
public class CurrentStockQuantityJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CurrentStockQuantity currentStockQuantity;
    private CurrentStockQuantity searchCurrentStockQuantity = new CurrentStockQuantity();
    private CurrentStockQuantityTemp currentStockQuantityTemp;
    private List <CurrentStockQuantityTemp> listCurrentStockQuantityTemp;
    private List <CurrentStockQuantity> listCurrentStockQuantity;
    private String actionAuthority="";
    private String currentStockQuantitySearchBranchCode = "";
    private String currentStockQuantitySearchBranchName = "";
    private String currentStockQuantitySearchWarehouseCode = "";
    private String currentStockQuantitySearchWarehouseName = "";
    private String currentStockQuantitySearchItemCode = "";
    private String currentStockQuantitySearchItemName = "";
    private String currentStockQuantitySearchRackCode = "";
    private String currentStockQuantitySearchRackName = "";
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("current-stock-quantity-search")
    public String search() {
        try {
            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
            
            ListPaging <CurrentStockQuantityTemp> listPaging = currentStockQuantityBLL.searchData(currentStockQuantitySearchWarehouseCode,currentStockQuantitySearchWarehouseName,
                    currentStockQuantitySearchItemCode,currentStockQuantitySearchItemName,currentStockQuantitySearchRackCode,currentStockQuantitySearchRackName,paging);
            
            listCurrentStockQuantityTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("current-stock-quantity-data")
    public String populateData(){
        try {
            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
            ListPaging <CurrentStockQuantityTemp> listPaging = currentStockQuantityBLL.findData(currentStockQuantitySearchWarehouseCode,currentStockQuantitySearchWarehouseName,
                    currentStockQuantitySearchItemCode,currentStockQuantitySearchItemName,currentStockQuantitySearchRackCode,currentStockQuantitySearchRackName,paging);
            
            listCurrentStockQuantityTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
//    @Action("current-stock-quantity-data")
//    public String populateData() {
//        try {
//            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
//            ListPaging<CurrentStockQuantity> listPaging = currentStockQuantityBLL.get(paging);
//            listCurrentStockQuantity = listPaging.getList();
//            return SUCCESS;
//        }
//        catch(Exception ex) {         
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
	
    @Action("current-stock-quantity-get")
    public String populateDataForUpdate() {
        try {
            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
            this.currentStockQuantity = currentStockQuantityBLL.get(this.currentStockQuantity.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("current-stock-quantity-save")
//    public String save() {
//        try {
//            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
//            
//            if (!BaseSession.loadProgramSession().hasAuthority(CurrentStockQuantityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
//            }                
//            
//            if(currentStockQuantity.isActiveStatus() == false){
//                currentStockQuantity.setInActiveBy(BaseSession.loadProgramSession().getUserName());
//                currentStockQuantity.setInActiveDate(new Date());
//            }
//            currentStockQuantityBLL.save(this.currentStockQuantity);
//            
//            this.message = "SAVE DATA SUCCESS. \n Code : " + this.currentStockQuantity.getCode();
//            return SUCCESS;
//        }
//        catch(Exception ex) {           
//            this.error = true;
//            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
	
//    @Action("current-stock-quantity-update")
//    public String update() {
//        try {
//            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
//            
//            if (!BaseSession.loadProgramSession().hasAuthority(CurrentStockQuantityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
//            }
//            
//            if(currentStockQuantity.isActiveStatus() == false){
//                currentStockQuantity.setInActiveBy(BaseSession.loadProgramSession().getUserName());
//                currentStockQuantity.setInActiveDate(new Date());
//            }
//            currentStockQuantityBLL.update(this.currentStockQuantity);
//           
//            
//            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.currentStockQuantity.getCode();
//            return SUCCESS;
//        }
//        catch(Exception ex) {   
//            this.error = true;
//            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
//	
//    @Action("current-stock-quantity-delete")
//    public String delete() {
//        try {
//            CurrentStockQuantityBLL currentStockQuantityBLL = new CurrentStockQuantityBLL(hbmSession);
//            
//            if (!BaseSession.loadProgramSession().hasAuthority(CurrentStockQuantityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
//            }            
//            
//            currentStockQuantityBLL.delete(this.currentStockQuantity.getCode());
//            
//            this.message = "DELETE DATA SUCCESS. \n Code : " + this.currentStockQuantity.getCode();
//            return SUCCESS;
//        }
//        catch(Exception ex) {           
//            this.error = true;
//            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
	
    @Action("current-stock-quantity-get-min")
    public String populateDataSupplierMin() {
        try {
            CurrentStockQuantityBLL currentStockQuantityBLL=new CurrentStockQuantityBLL(hbmSession);
            this.currentStockQuantityTemp = currentStockQuantityBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("current-stock-quantity-get-max")
    public String populateDataSupplierMax() {
        try {
            CurrentStockQuantityBLL currentStockQuantityBLL=new CurrentStockQuantityBLL(hbmSession);
            this.currentStockQuantityTemp = currentStockQuantityBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("export-current-stock-quantity-print-out-xls")
    public String exportXLS() {
        try {
            
//            if (!BaseSession.loadProgramSession().hasAuthority(MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
//                return "redirect";
//            }
//            
//            SimpleDateFormat DATE_FORMAT_INA = new SimpleDateFormat("dd/MM/yyyy");
//            
//            Workbook wb = new HSSFWorkbook();
//            DataFormat format = wb.createDataFormat();
//            Sheet sheet = wb.createSheet("sheet 1");
//            
//            Font font = wb.createFont();
//            font.setFontName("Times New Roman");
//            font.setFontHeightInPoints((short)11);
//
//            Font fontHeader = wb.createFont();
//            fontHeader.setFontName("Times New Roman");
//            fontHeader.setFontHeightInPoints((short)11);
//            fontHeader.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
//
//            Font fontDetail = wb.createFont();
//            fontDetail.setFontName("Times New Roman");
//            fontDetail.setFontHeightInPoints((short)11);
//
//            CellStyle csHeader = wb.createCellStyle();
//            csHeader.setAlignment(csHeader.ALIGN_LEFT);
//            csHeader.setVerticalAlignment(csHeader.VERTICAL_CENTER);
//            csHeader.setFont(fontHeader);
//
//            CellStyle csNumeric = wb.createCellStyle();
//            csNumeric.setAlignment(csNumeric.ALIGN_RIGHT);
//            csNumeric.setVerticalAlignment(csNumeric.VERTICAL_CENTER);
//            csNumeric.setDataFormat(format.getFormat("#,##0.00"));
//            csNumeric.setFont(font);
//            
//            CellStyle csNumericDetail_Left = wb.createCellStyle();
//            csNumericDetail_Left.setWrapText(true);
//            csNumericDetail_Left.setAlignment(csNumericDetail_Left.ALIGN_RIGHT);
//            csNumericDetail_Left.setVerticalAlignment(csNumericDetail_Left.VERTICAL_CENTER);
//            csNumericDetail_Left.setBorderLeft(csNumericDetail_Left.BORDER_THIN);
//            csNumericDetail_Left.setFont(fontDetail);
//
//            CellStyle csIntegerDetail = wb.createCellStyle();
//            csIntegerDetail.setWrapText(true);
//            csIntegerDetail.setAlignment(csIntegerDetail.ALIGN_CENTER);
//            csIntegerDetail.setVerticalAlignment(csIntegerDetail.VERTICAL_CENTER);
//            csIntegerDetail.setFont(fontDetail);
//
//            CellStyle csIntegerDetail_Left = wb.createCellStyle();
//            csIntegerDetail_Left.setWrapText(true);
//            csIntegerDetail_Left.setAlignment(csIntegerDetail_Left.ALIGN_CENTER);
//            csIntegerDetail_Left.setVerticalAlignment(csIntegerDetail_Left.VERTICAL_CENTER);
//            csIntegerDetail_Left.setBorderLeft(csIntegerDetail_Left.BORDER_THIN);
//            csIntegerDetail_Left.setFont(fontDetail);
//
//            CellStyle csIntegerDetail_Left_Medium = wb.createCellStyle();
//            csIntegerDetail_Left_Medium.setWrapText(true);
//            csIntegerDetail_Left_Medium.setAlignment(csIntegerDetail_Left_Medium.ALIGN_CENTER);
//            csIntegerDetail_Left_Medium.setVerticalAlignment(csIntegerDetail_Left_Medium.VERTICAL_CENTER);
//            csIntegerDetail_Left_Medium.setBorderLeft(csIntegerDetail_Left_Medium.BORDER_MEDIUM);
//            csIntegerDetail_Left_Medium.setFont(fontDetail);
//
//            CellStyle csString = wb.createCellStyle();
//            csString.setWrapText(true);
//            csString.setAlignment(csString.ALIGN_LEFT);
//            csString.setVerticalAlignment(csString.VERTICAL_CENTER);
//            csString.setFont(font);
//
//            CellStyle csStringDetail_Left = wb.createCellStyle();
//            csStringDetail_Left.setWrapText(true);
//            csStringDetail_Left.setAlignment(csStringDetail_Left.ALIGN_LEFT);
//            csStringDetail_Left.setVerticalAlignment(csStringDetail_Left.VERTICAL_CENTER);
//            csStringDetail_Left.setBorderLeft(csStringDetail_Left.BORDER_THIN);
//            csStringDetail_Left.setFont(fontDetail);
//
//            CellStyle csStringDetail_Center_Left = wb.createCellStyle();
//            csStringDetail_Center_Left.setWrapText(true);
//            csStringDetail_Center_Left.setAlignment(csStringDetail_Center_Left.ALIGN_CENTER);
//            csStringDetail_Center_Left.setVerticalAlignment(csStringDetail_Center_Left.VERTICAL_CENTER);
//            csStringDetail_Center_Left.setFont(fontDetail);
//
//            CellStyle csStringDetail_Center_Left_Border_left = wb.createCellStyle();
//            csStringDetail_Center_Left_Border_left.setWrapText(true);
//            csStringDetail_Center_Left_Border_left.setAlignment(csStringDetail_Center_Left_Border_left.ALIGN_CENTER);
//            csStringDetail_Center_Left_Border_left.setVerticalAlignment(csStringDetail_Center_Left_Border_left.VERTICAL_CENTER);
//            csStringDetail_Center_Left_Border_left.setBorderLeft(csStringDetail_Center_Left_Border_left.BORDER_THIN);
//            csStringDetail_Center_Left_Border_left.setFont(fontDetail);
//
//            CellStyle csStringDetail_LeftRight = wb.createCellStyle();
//            csStringDetail_LeftRight.setAlignment(csStringDetail_LeftRight.ALIGN_LEFT);
//            csStringDetail_LeftRight.setVerticalAlignment(csStringDetail_LeftRight.VERTICAL_CENTER);
//            csStringDetail_LeftRight.setFont(fontDetail);
//
//            
//            String companyName = BaseSession.loadProgramSession().getSetup().getCompanyName();
//            
//            Row row;
//            Cell cell;	
//            
//            // HEADER
//            //row 1
//            row = sheet.createRow((short) 0); 
//            cell = row.createCell(Globalize.getCell("A"));
//            cell.setCellValue(companyName);	
//            cell.setCellStyle(csHeader);
//            
//            //row 2
//            row = sheet.createRow((short) 1); 
//            cell = row.createCell(Globalize.getCell("A"));
//            cell.setCellValue("SALES FORCE");	
//            cell.setCellStyle(csHeader);
//            
//            //row 3
//            row = sheet.createRow((short) 3); 
//            cell = row.createCell(Globalize.getCell("A"));
//            cell.setCellValue("PRODUCT TYPE");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("B"));
//            cell.setCellValue("VENDOR");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("C"));
//            cell.setCellValue("ITEM CODE");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("D"));
//            cell.setCellValue("BLOCK CODE");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("E"));
//            cell.setCellValue("ID");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("F"));
//            cell.setCellValue("PROD GROUP");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("G"));
//            cell.setCellValue("FINISH TYPE");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("H"));
//            cell.setCellValue("PRODUCT CATEGORY");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("I"));
//            cell.setCellValue("BLOCK2");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("J"));
//            cell.setCellValue("VOL(M2)");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("K"));
//            cell.setCellValue("CURRENCY");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("L"));
//            cell.setCellValue("LIST PRICE/M2");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("M"));
//            cell.setCellValue("PROMO/M2");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("N"));
//            cell.setCellValue("SLAB QUANTITY");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("O"));
//            cell.setCellValue("NET COGS IDR");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("P"));
//            cell.setCellValue("IN ARRIVAL DATE");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("Q"));
//            cell.setCellValue("WIDTH");	
//            cell.setCellStyle(csHeader);
//            
//            cell = row.createCell(Globalize.getCell("R"));
//            cell.setCellValue("LENGTH");	
//            cell.setCellStyle(csHeader);
//            
//            int defRow = 4;
//            int initRow = defRow;
//            
//            PreparedStatement Statement = null;
//            ResultSet rs = null;
//            
//            Connection conn = hbmSession.hSession.connection();
//
//            Statement = conn.prepareStatement(
//                  "SELECT "
//                + "	mst_item.ProductTypeCode, "
//                + "     mst_product_type.`Name` AS ProductTypeName, "
//                + "	mst_barcode_detail.Suppliercode, "
//                + "	mst_barcode_detail.Itemcode, "
//                + "	mst_barcode_detail.Blockno, "
//                + "	CONCAT(mst_barcode_detail.Suppliercode,mst_barcode_detail.Itemcode,mst_barcode_detail.Blockno)AS ConcatCode, "
//                + "     mst_item.Name AS ProductGroup, "
//                + "	mst_barcode_detail.Itemstatuscode, "
//                + "     mst_item_status.Name AS Itemstatusname, "
//                + "     '' AS ProductCategory, "
//                + "     '' AS Block2, "
//                + "	SUM(mst_barcode_detail.Volume) AS Volume, "
//                + "	mst_item.Currencycode, "
//                + "	mst_item.NormalPrice AS ListPrice, "
////                + "	SUM(mst_barcode_detail.Cogsidr)AS Cogsidr, "
//                + "	0 AS promo, "
//                + "	COUNT(mst_barcode_detail.Slabno) AS SlabQuantity, "
//                + "	SUM(mst_barcode_detail.Cogsidr) - 0 AS NetCogsIdr, "
//                + "	DATE(mst_barcode_detail.Indate)AS Indate, "
//                + "     SUM(mst_barcode_detail.Itemwidth) / COUNT(mst_barcode_detail.Slabno) AS  Itemwidth, "
//                + "     SUM(mst_barcode_detail.Itemlength) / COUNT(mst_barcode_detail.Slabno) AS  Itemlength "          
////                + "     (SUM(mst_barcode_detail.Itemwidth) * COUNT(mst_barcode_detail.Slabno)) / COUNT(mst_barcode_detail.Slabno) AS  Itemwidth, "
////                + "     (SUM(mst_barcode_detail.Itemlength) * COUNT(mst_barcode_detail.Slabno)) / COUNT(mst_barcode_detail.Slabno) AS  Itemlength "
////                + "	sum(mst_barcode_detail.SlabQuantity * mst_barcode_detail.Itemwidth) / sum(mst_barcode_detail.SlabQuantity) as  Itemwidth, "
////                + "	mst_barcode_detail.Itemlength "
//                + "FROM mst_barcode_detail "
//                + "INNER JOIN mst_item ON mst_barcode_detail.Itemcode=mst_item.Code "
//                + "INNER JOIN mst_product_type ON mst_item.ProductTypeCode=mst_product_type.Code "
//                + "INNER JOIN mst_item_status ON mst_barcode_detail.Itemstatuscode=mst_item_status.Code "
//                + "WHERE mst_barcode_detail.Outstatus=0 "
//                + "GROUP BY mst_item.ProductTypeCode,mst_barcode_detail.Suppliercode, "
//                + "	mst_barcode_detail.Itemcode,mst_barcode_detail.Blockno,mst_barcode_detail.Itemstatuscode, "
//                + "	mst_barcode_detail.Currencycode "
////                          + " ,mst_barcode_detail.Indate,mst_barcode_detail.Itemwidth,mst_barcode_detail.Itemlength"
//                );
//            
//            
//            rs = Statement.executeQuery();
//            
//            while(rs.next()) {
//                
//                
//                row = sheet.createRow(initRow);
//                cell = row.createCell(Globalize.getCell("A"));
//                cell.setCellValue(rs.getString("ProductTypeName"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//
//                cell = row.createCell(Globalize.getCell("B"));
//                cell.setCellValue(rs.getString("Suppliercode"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("C"));
//                cell.setCellValue(rs.getString("Itemcode"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("D"));
//                cell.setCellValue(rs.getString("Blockno"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("E"));
//                cell.setCellValue(rs.getString("ConcatCode"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("F"));
//                cell.setCellValue(rs.getString("ProductGroup"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("G"));
//                cell.setCellValue(rs.getString("Itemstatusname"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("H"));
//                cell.setCellValue(rs.getString("ProductCategory"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("I"));
//                cell.setCellValue(rs.getString("Block2"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//
//                cell = row.createCell(Globalize.getCell("J"));
//                cell.setCellValue(rs.getDouble("Volume"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("K"));
//                cell.setCellValue(rs.getString("Currencycode"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//
//                cell = row.createCell(Globalize.getCell("L"));
//                cell.setCellValue(rs.getDouble("ListPrice"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("M"));
//                cell.setCellValue(rs.getDouble("promo"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("N"));
//                cell.setCellValue(rs.getDouble("SlabQuantity"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("O"));
//                cell.setCellValue(rs.getDouble("NetCogsIdr"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("P"));
////                cell.setCellValue(rs.getString("Indate"));
//                cell.setCellValue(DATE_FORMAT_INA.format(rs.getDate("Indate")));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("Q"));
//                cell.setCellValue(rs.getDouble("Itemwidth"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("R"));
//                cell.setCellValue(rs.getDouble("Itemlength"));
//                cell.setCellStyle(csNumeric);
//                
//                initRow++;
//                
//            }
//
//            for (int j=0; j<19; j++){
//               sheet.autoSizeColumn(j);
//            }
//            
//            ByteArrayOutputStream baos = new ByteArrayOutputStream();
//            wb.write(baos);
//            baos.flush();
//            byte[] bte = baos.toByteArray();
//            
//            this.inputStream = new ByteArrayInputStream(bte,0,bte.length);
//            baos.close();
            
            
           return "XLS";
           
        }
        catch(Exception ex) {
            ex.printStackTrace();
            return "XLS";
        }

        
    }

    // <editor-fold defaultstate="collapsed" desc="SET N GET INCLUUDE">

        public HBMSession getHbmSession() {
            return hbmSession;
        }

        public void setHbmSession(HBMSession hbmSession) {
            this.hbmSession = hbmSession;
        }

        public CurrentStockQuantity getCurrentStockQuantity() {
            return currentStockQuantity;
        }

        public void setCurrentStockQuantity(CurrentStockQuantity currentStockQuantity) {
            this.currentStockQuantity = currentStockQuantity;
        }

        public CurrentStockQuantityTemp getCurrentStockQuantityTemp() {
            return currentStockQuantityTemp;
        }

        public void setCurrentStockQuantityTemp(CurrentStockQuantityTemp currentStockQuantityTemp) {
            this.currentStockQuantityTemp = currentStockQuantityTemp;
        }

        public List<CurrentStockQuantityTemp> getListCurrentStockQuantityTemp() {
            return listCurrentStockQuantityTemp;
        }

        public void setListCurrentStockQuantityTemp(List<CurrentStockQuantityTemp> listCurrentStockQuantityTemp) {
            this.listCurrentStockQuantityTemp = listCurrentStockQuantityTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public CurrentStockQuantity getSearchCurrentStockQuantity() {
            return searchCurrentStockQuantity;
        }

        public void setSearchCurrentStockQuantity(CurrentStockQuantity searchCurrentStockQuantity) {
            this.searchCurrentStockQuantity = searchCurrentStockQuantity;
        }

        public List<CurrentStockQuantity> getListCurrentStockQuantity() {
            return listCurrentStockQuantity;
        }

        public void setListCurrentStockQuantity(List<CurrentStockQuantity> listCurrentStockQuantity) {
            this.listCurrentStockQuantity = listCurrentStockQuantity;
        }

    // </editor-fold>    
    
    // <editor-fold defaultstate="collapsed" desc="Message Info">
        private boolean error = false;
        private String errorMessage = "";
        private String message = "";

        public boolean isError() {
            return error;
        }

        public void setError(boolean error) {
            this.error = error;
        }

        public String getErrorMessage() {
            return errorMessage;
        }

        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
        this.message = message;
    }
    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">

        Paging paging = new Paging();

        public Paging getPaging() {
            return paging;
        }

        public void setPaging(Paging paging) {
            this.paging = paging;
        }


        public Integer getRows() {
            return paging.getRows();
        }
        public void setRows(Integer rows) {
            paging.setRows(rows);
        }

        public Integer getPage() {
            return paging.getPage();
        }
        public void setPage(Integer page) {
            paging.setPage(page);
        }

        public Integer getTotal() {
            return paging.getTotal();
        }
        public void setTotal(Integer total) {
            paging.setTotal(total);
        }

        public Integer getRecords() {
            return paging.getRecords();
        }
        public void setRecords(Integer records) {
            paging.setRecords(records);

            if (paging.getRecords() > 0 && paging.getRows() > 0)
                paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
            else
                paging.setTotal(0);
        }

        public String getSord() {
            return paging.getSord();
        }
        public void setSord(String sord) {
            paging.setSord(sord);
        }

        public String getSidx() {
            return paging.getSidx();
        }
        public void setSidx(String sidx) {
            paging.setSidx(sidx);
        }

        public void setSearchField(String searchField) {
            paging.setSearchField(searchField);
        }
        public void setSearchString(String searchString) {
            paging.setSearchString(searchString);
        }
        public void setSearchOper(String searchOper) {
            paging.setSearchOper(searchOper);
        }

    // </editor-fold>

    public String getCurrentStockQuantitySearchBranchCode() {
        return currentStockQuantitySearchBranchCode;
    }

    public void setCurrentStockQuantitySearchBranchCode(String currentStockQuantitySearchBranchCode) {
        this.currentStockQuantitySearchBranchCode = currentStockQuantitySearchBranchCode;
    }

    public String getCurrentStockQuantitySearchBranchName() {
        return currentStockQuantitySearchBranchName;
    }

    public void setCurrentStockQuantitySearchBranchName(String currentStockQuantitySearchBranchName) {
        this.currentStockQuantitySearchBranchName = currentStockQuantitySearchBranchName;
    }

    public String getCurrentStockQuantitySearchWarehouseCode() {
        return currentStockQuantitySearchWarehouseCode;
    }

    public void setCurrentStockQuantitySearchWarehouseCode(String currentStockQuantitySearchWarehouseCode) {
        this.currentStockQuantitySearchWarehouseCode = currentStockQuantitySearchWarehouseCode;
    }

    public String getCurrentStockQuantitySearchWarehouseName() {
        return currentStockQuantitySearchWarehouseName;
    }

    public void setCurrentStockQuantitySearchWarehouseName(String currentStockQuantitySearchWarehouseName) {
        this.currentStockQuantitySearchWarehouseName = currentStockQuantitySearchWarehouseName;
    }

    public String getCurrentStockQuantitySearchItemCode() {
        return currentStockQuantitySearchItemCode;
    }

    public void setCurrentStockQuantitySearchItemCode(String currentStockQuantitySearchItemCode) {
        this.currentStockQuantitySearchItemCode = currentStockQuantitySearchItemCode;
    }

    public String getCurrentStockQuantitySearchItemName() {
        return currentStockQuantitySearchItemName;
    }

    public void setCurrentStockQuantitySearchItemName(String currentStockQuantitySearchItemName) {
        this.currentStockQuantitySearchItemName = currentStockQuantitySearchItemName;
    }

    public String getCurrentStockQuantitySearchRackCode() {
        return currentStockQuantitySearchRackCode;
    }

    public void setCurrentStockQuantitySearchRackCode(String currentStockQuantitySearchRackCode) {
        this.currentStockQuantitySearchRackCode = currentStockQuantitySearchRackCode;
    }

    public String getCurrentStockQuantitySearchRackName() {
        return currentStockQuantitySearchRackName;
    }

    public void setCurrentStockQuantitySearchRackName(String currentStockQuantitySearchRackName) {
        this.currentStockQuantitySearchRackName = currentStockQuantitySearchRackName;
    }
}
