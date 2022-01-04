/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.reports.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.Globalize;
import com.opensymphony.xwork2.ActionSupport;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author ikb
 */

@Results({
    @Result(name="success", location="sales/sales-quotation.jsp"),
    @Result(name="redirect", type="redirect", location="../../pages/noauthority.jsp"),
//    @Result(name="JASPER_PDF", type="jasper", params={"location", "report/master/price-list-print-out.jasper", "connection", "sqlConn", "reportParameters", "reportParams", "format", "PDF", "documentName", "price-list_print_out"}),
    @Result(name="XLSX", type="stream", params={"contentDisposition", "attachment;filename=Import_Valve_Ball.xlsx"})
})

public class SalesQuotationPrintOutAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private static final String MODULECODE = "002_SAL_SALES_QUOTATION";
    private InputStream inputStream ;
    
//    @Override
    @Action("sales-quotation-download-excel")
    public String excelDownload() throws Exception{
        
        if (!BaseSession.loadProgramSession().hasAuthority(MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
                return "redirect";
            }
         
           
            Workbook wb = new XSSFWorkbook();
            DataFormat format = wb.createDataFormat();
            Sheet sheet = wb.createSheet("sheet 1");
            
            Font font = wb.createFont();
            font.setFontName("Times New Roman");
            font.setFontHeightInPoints((short)11);

            Font fontHeader = wb.createFont();
            fontHeader.setFontName("Times New Roman");
            fontHeader.setFontHeightInPoints((short)11);
            fontHeader.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

            Font fontDetail = wb.createFont();
            fontDetail.setFontName("Times New Roman");
            fontDetail.setFontHeightInPoints((short)11);

            CellStyle csHeader = wb.createCellStyle();
            csHeader.setAlignment(csHeader.ALIGN_LEFT);
            csHeader.setVerticalAlignment(csHeader.VERTICAL_CENTER);
            csHeader.setFont(fontHeader);

            CellStyle csNumeric = wb.createCellStyle();
            csNumeric.setAlignment(csNumeric.ALIGN_RIGHT);
            csNumeric.setVerticalAlignment(csNumeric.VERTICAL_CENTER);
            csNumeric.setDataFormat(format.getFormat("#,##0.00"));
            csNumeric.setFont(font);
            
            CellStyle csNumericDetail_Left = wb.createCellStyle();
            csNumericDetail_Left.setWrapText(true);
            csNumericDetail_Left.setAlignment(csNumericDetail_Left.ALIGN_RIGHT);
            csNumericDetail_Left.setVerticalAlignment(csNumericDetail_Left.VERTICAL_CENTER);
            csNumericDetail_Left.setBorderLeft(csNumericDetail_Left.BORDER_THIN);
            csNumericDetail_Left.setFont(fontDetail);

            CellStyle csIntegerDetail = wb.createCellStyle();
            csIntegerDetail.setWrapText(true);
            csIntegerDetail.setAlignment(csIntegerDetail.ALIGN_CENTER);
            csIntegerDetail.setVerticalAlignment(csIntegerDetail.VERTICAL_CENTER);
            csIntegerDetail.setFont(fontDetail);

            CellStyle csIntegerDetail_Left = wb.createCellStyle();
            csIntegerDetail_Left.setWrapText(true);
            csIntegerDetail_Left.setAlignment(csIntegerDetail_Left.ALIGN_CENTER);
            csIntegerDetail_Left.setVerticalAlignment(csIntegerDetail_Left.VERTICAL_CENTER);
            csIntegerDetail_Left.setBorderLeft(csIntegerDetail_Left.BORDER_THIN);
            csIntegerDetail_Left.setFont(fontDetail);

            CellStyle csIntegerDetail_Left_Medium = wb.createCellStyle();
            csIntegerDetail_Left_Medium.setWrapText(true);
            csIntegerDetail_Left_Medium.setAlignment(csIntegerDetail_Left_Medium.ALIGN_CENTER);
            csIntegerDetail_Left_Medium.setVerticalAlignment(csIntegerDetail_Left_Medium.VERTICAL_CENTER);
            csIntegerDetail_Left_Medium.setBorderLeft(csIntegerDetail_Left_Medium.BORDER_MEDIUM);
            csIntegerDetail_Left_Medium.setFont(fontDetail);

            CellStyle csString = wb.createCellStyle();
            csString.setWrapText(true);
            csString.setAlignment(csString.ALIGN_LEFT);
            csString.setVerticalAlignment(csString.VERTICAL_CENTER);
            csString.setFont(font);

            CellStyle csStringDetail_Left = wb.createCellStyle();
            csStringDetail_Left.setWrapText(true);
            csStringDetail_Left.setAlignment(csStringDetail_Left.ALIGN_LEFT);
            csStringDetail_Left.setVerticalAlignment(csStringDetail_Left.VERTICAL_CENTER);
            csStringDetail_Left.setBorderLeft(csStringDetail_Left.BORDER_THIN);
            csStringDetail_Left.setFont(fontDetail);

            CellStyle csStringDetail_Center_Left = wb.createCellStyle();
            csStringDetail_Center_Left.setWrapText(true);
            csStringDetail_Center_Left.setAlignment(csStringDetail_Center_Left.ALIGN_CENTER);
            csStringDetail_Center_Left.setVerticalAlignment(csStringDetail_Center_Left.VERTICAL_CENTER);
            csStringDetail_Center_Left.setFont(fontDetail);

            CellStyle csStringDetail_Center_Left_Border_left = wb.createCellStyle();
            csStringDetail_Center_Left_Border_left.setWrapText(true);
            csStringDetail_Center_Left_Border_left.setAlignment(csStringDetail_Center_Left_Border_left.ALIGN_CENTER);
            csStringDetail_Center_Left_Border_left.setVerticalAlignment(csStringDetail_Center_Left_Border_left.VERTICAL_CENTER);
            csStringDetail_Center_Left_Border_left.setBorderLeft(csStringDetail_Center_Left_Border_left.BORDER_THIN);
            csStringDetail_Center_Left_Border_left.setFont(fontDetail);

            CellStyle csStringDetail_LeftRight = wb.createCellStyle();
            csStringDetail_LeftRight.setAlignment(csStringDetail_LeftRight.ALIGN_LEFT);
            csStringDetail_LeftRight.setVerticalAlignment(csStringDetail_LeftRight.VERTICAL_CENTER);
            csStringDetail_LeftRight.setFont(fontDetail);
            
            Row row;
            Cell cell;	
            
            row = sheet.createRow((short) 0);
            cell = row.createCell(Globalize.getCell("A"));
            cell.setCellValue("Valve Type Code");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("B"));
            cell.setCellValue("Valve Tag");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("C"));
            cell.setCellValue("Data Sheet");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("D"));
            cell.setCellValue("Description");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("E"));
            cell.setCellValue("Body Construction");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("F"));
            cell.setCellValue("Type Design");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("G"));
            cell.setCellValue("Seat Design");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("H"));
            cell.setCellValue("Size");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("I"));
            cell.setCellValue("Rating");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("J"));
            cell.setCellValue("Bore");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("K"));
            cell.setCellValue("End Con");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("L"));
            cell.setCellValue("Body");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("M"));
            cell.setCellValue("Ball");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("N"));
            cell.setCellValue("Seat");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("O"));
            cell.setCellValue("Seat Insert");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("P"));
            cell.setCellValue("Stem");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("Q"));
            cell.setCellValue("Seal");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("R"));
            cell.setCellValue("Bolt");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("S"));
            cell.setCellValue("Operator");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("T"));
            cell.setCellValue("Note");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("U"));
            cell.setCellValue("Quantity");
            cell.setCellStyle(csHeader);
            
            cell = row.createCell(Globalize.getCell("V"));
            cell.setCellValue("Unit Price");
            cell.setCellStyle(csHeader);
            
            row = sheet.createRow((short) 1);
            cell = row.createCell(Globalize.getCell("A"));
            cell.setCellValue("BALL");
            
            for (int i=1; i<=5; i++){
                sheet.autoSizeColumn(i);
            }
            
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            wb.write(baos);
            baos.flush();
            byte[] bte = baos.toByteArray();
            
            this.inputStream = new ByteArrayInputStream(bte,0,bte.length);
            baos.close();
            
           return "XLSX";
    }


    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }
    
    
}
