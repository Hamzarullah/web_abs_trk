<%-- 
    Document   : search-salesQuotation
    Created on : Aug 23, 2019, 9:59:08 AM
    Author     : jsone
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow: scroll;
        }
    </style>
    
    
<script type = "text/javascript">
       
    var search_salesQuotation= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';  
    var id_salesQuo_code = '<%= request.getParameter("idsalesquotationcode") %>';
    
    
    jQuery(document).ready(function(){  
        
        $('#salesQuotationDetailTemp\\.item').val(id_salesQuo_code);
        $('#salesQuotationDetailTemp\\.item').attr("readonly",true);
        
        $("#dlgSalesQuotation_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_salesQuotationDetail_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }

            var data_search_salesQuotationDetail = $("#dlgSearch_salesQuotationDetail_grid").jqGrid('getRowData', selectedRowId);

            if (search_salesQuotation === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                }
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemCode", data_search_salesQuotationDetail.item);         
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ValveType", data_search_salesQuotationDetail.valveTag); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"DataSheet", data_search_salesQuotationDetail.dataSheet);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Description", data_search_salesQuotationDetail.description);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Type", data_search_salesQuotationDetail.type);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Size", data_search_salesQuotationDetail.size);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Rating", data_search_salesQuotationDetail.rating);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EndCon", data_search_salesQuotationDetail.endCon);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Body", data_search_salesQuotationDetail.body);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Seat", data_search_salesQuotationDetail.seat);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Stem", data_search_salesQuotationDetail.stem);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SeatInsert", data_search_salesQuotationDetail.seatInsert);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Seal", data_search_salesQuotationDetail.seal);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Bolting", data_search_salesQuotationDetail.bolting);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Ball", data_search_salesQuotationDetail.ball);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SeatDesign", data_search_salesQuotationDetail.seatDesign);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Oper", data_search_salesQuotationDetail.oper);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Note", data_search_salesQuotationDetail.note);
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_salesQuotationDetail.code);
            }
            
            window.close();
        });

        $("#dlgSalesQuotation_cancelButton").click(function(ev) { 
            data_search_salesQuotationDetail = null;
            window.close();
        });
    
        $("#btn_dlg_SalesQuotationSearch").click(function(ev) {
            $("#salesQuotationSearchDetailCodeConcat").val(id_salesQuo_code);
            $("#dlgSearch_salesQuotationDetail_grid").jqGrid("setGridParam",{url:"sales/sales-quotation-detail-getgroupby-data?" + $("#frmSalesQuotationSearch").serialize(), page:1});
            $("#dlgSearch_salesQuotationDetail_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
    });
    
    function alertMsg(txt_message){
        var dynamicDialog= $(
        '<div id="conformBoxError">'+
            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
            '</span>' +
        '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            resizable: false,
            closeText: "hide",
            buttons : 
            [{
                text : "OK",
                click : function() {
                    $(this).dialog("close");
                }
            }]
        });
    }
    
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmSalesQuotationSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="salesQuotationDetailTemp.item" name="salesQuotationDetailTemp.item" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td><s:textfield id="salesQuotationSearchDetailCodeConcat" name="salesQuotationSearchDetailCodeConcat" size="50" cssStyle="display:none"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Item</td>
                <td><s:textfield id="salesQuotationDetailTemp.item" name="salesQuotationTemp.item" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_SalesQuotationSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_salesQuotationDetail_grid"
            dataType="json"
            href="%{remoteurlSalesQuotationSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listSalesQuotationDetailTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuSalesQuotation').width()"
        >
            <sjg:gridColumn
                name="item" index="item" key="item" title="Item" width="120" sortable="true"
            />
            <sjg:gridColumn
                name="valveTag" index="valveTag" key="valveTag" title="Valve Tag" width="150" search="false" 
            />
            <sjg:gridColumn
                name="dataSheet" index="dataSheet" key="dataSheet" title="Data Sheet" width="150" search="false" 
            />
            <sjg:gridColumn
                name="description" index="description" key="description" title="Description" width="150" search="false" 
            />

        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgSalesQuotation_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgSalesQuotation_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


