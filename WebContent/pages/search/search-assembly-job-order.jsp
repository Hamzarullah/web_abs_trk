<%-- 
    Document   : search-assembly-job-order
    Created on : Dec 10, 2019, 9:44:52 PM
    Author     : Rayis
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

    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
    </style>
    
    <script type = "text/javascript">

        var search_assemblyJobOrder_type= '<%= request.getParameter("type") %>';
        var id_document = '<%= request.getParameter("iddoc") %>';
        var id_subdoc = '<%= request.getParameter("idsubdoc") %>';
        var id_firstdate = '<%= request.getParameter("firstdate") %>';
        var id_lastdate = '<%= request.getParameter("lastdate") %>';
        
        jQuery(document).ready(function(){  
            $("#assemblyJobOrderSearchFirstDate").val(id_firstdate);
            $("#assemblyJobOrderSearchLastDate").val(id_lastdate);
            
            $("#dlgAssemblyJobOrder_okButton").click(function(ev) { 
                selectedRowId = $("#dlgSearch_assemblyJobOrder_grid").jqGrid("getGridParam","selrow");

                if(selectedRowId === null){
                    alert("Please Select Row AssemblyJobOrder");
                    return;
                }

                var data_search_assemblyJobOrder = $("#dlgSearch_assemblyJobOrder_grid").jqGrid('getRowData', selectedRowId);
                    
                if (search_assemblyJobOrder_type === "grid" ) {
                    var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                    $("#"+selectedRowID+"_"+id_document+"AssemblyJobOrderCode",opener.document).val(data_search_assemblyJobOrder.code);
                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"AssemblyJobOrderFinishGoodsQuantity", data_search_assemblyJobOrder.finishGoodsQuantity);           
                }else{
                    $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_assemblyJobOrder.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.code",opener.document).val(data_search_assemblyJobOrder.branchCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.name",opener.document).val(data_search_assemblyJobOrder.branchName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.finishGoods\\.code",opener.document).val(data_search_assemblyJobOrder.finishGoodsCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.finishGoods\\.name",opener.document).val(data_search_assemblyJobOrder.finishGoodsName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.billOfMaterial\\.code",opener.document).val(data_search_assemblyJobOrder.billOfMaterialCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.billOfMaterial\\.name",opener.document).val(data_search_assemblyJobOrder.billOfMaterialName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.finishGoodsQuantity",opener.document).val(data_search_assemblyJobOrder.finishGoodsQuantity);
                }
                                
                window.close();
               
            });

            $("#dlgAssemblyJobOrder_cancelButton").click(function(ev) { 
                data_search_assemblyJobOrder = null;
                window.close();
            });

            $("#btn_dlg_AssemblyJobOrderSearch").click(function(ev) {
                
                formatDateASMJobOrder();
                $("#dlgSearch_assemblyJobOrder_grid").jqGrid("setGridParam",{url:"inventory/assembly-job-order-search-data?" + $("#frmAssemblyJobOrderSearch").serialize(), page:1});
                $("#dlgSearch_assemblyJobOrder_grid").trigger("reloadGrid");
                formatDateASMJobOrder();
        
                ev.preventDefault();
            });
         });

         function formatDateASMJobOrder(){
            var firstDate=$("#assemblyJobOrderSearchFirstDate").val();
            var firstDateValues= firstDate.split('/');
            var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
            $("#assemblyJobOrderSearchFirstDate").val(firstDateValue);

            var lastDate=$("#assemblyJobOrderSearchLastDate").val();
            var lastDateValues= lastDate.split('/');
            var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
            $("#assemblyJobOrderSearchLastDate").val(lastDateValue);
        }
    </script>
<body>
    <s:url id="remoteurlAssemblyJobOrderSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmAssemblyJobOrderSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period * </B></td>
                <td>
                    <sj:datepicker id="assemblyJobOrderSearchFirstDate" name="assemblyJobOrderSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="assemblyJobOrderSearchLastDate" name="assemblyJobOrderSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td>
                    <s:textfield id="assemblyJobOrderSearchCode" name="assemblyJobOrderSearchCode" placeHolder=" Assembly Job Order No" size="30"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><b>Finish Goods</b></td>
                <td>
                    <s:textfield id="assemblyJobOrderSearchFinishGoodsCode" name="assemblyJobOrderSearchFinishGoodsCode" placeHolder=" Code" size="15"></s:textfield>
                    <s:textfield id="assemblyJobOrderSearchFinishGoodsName" name="assemblyJobOrderSearchFinishGoodsName" placeHolder=" Name" size="30"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">RefNo</td>
                <td>
                    <s:textfield id="assemblyJobOrderSearchRefNo" name="assemblyJobOrderSearchRefNo" placeHolder=" RefNo" size="30"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Remark</td>
                <td>
                    <s:textfield id="assemblyJobOrderSearchRemark" name="assemblyJobOrderSearchRemark" placeHolder=" Remark" size="30"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_AssemblyJobOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>

    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_assemblyJobOrder_grid"
            dataType="json"
            href="%{remoteurlAssemblyJobOrderSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listAssemblyJobOrder"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuassemblyJobOrder').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch" width="50" sortable="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch" width="50" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsCode" index="finishGoodsCode" key="finishGoodsCode" title="Finish Goods Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsName" index="finishGoodsName" key="finishGoodsName" title="Finish Goods Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="billOfMaterialCode" index="billOfMaterialCode" key="billOfMaterialCode" title="BOM Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="billOfMaterialName" index="billOfMaterialName" key="billOfMaterialName" title="BOM Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsQuantity" index="finishGoodsQuantity" key="finishGoodsQuantity" title="Quantity" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsQuantityProcess" index="finishGoodsQuantityProcess" key="finishGoodsQuantityProcess" title="Quantity Process" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
            />
        </sjg:grid >

    </div>
    <br class="spacer"/>
    <sj:a href="#" id="dlgAssemblyJobOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgAssemblyJobOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>