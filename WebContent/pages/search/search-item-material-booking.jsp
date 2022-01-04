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
    
    var search_itemMaterial_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    var warehouseCode= '<%= request.getParameter("warehouseCode") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgItemMaterial_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_itemMaterial_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ItemMaterial!");
                return;
            }
            imrMaterialBookedRowId=rowLast;
            imrItemMaterialRequestRowId=rowLast;

            var data_search_itemMaterial = $("#dlgSearch_itemMaterial_grid").jqGrid('getRowData', selectedRowId);
            
            var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
            var ids = jQuery("#dlgSearch_itemMaterial_grid").jqGrid('getDataIDs');
            for(var i=0;i<ids.length;i++){
                    var exist = false;
                    var data = $("#dlgSearch_itemMaterial_grid").jqGrid('getRowData',ids[i]);
                    if($("input:checkbox[id='jqg_dlgSearch_itemMaterial_grid_"+ids[i]+"']").is(":checked")){
                        for(var j=0; j<idsOpener.length; j++){
                            var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            if(id_document === 'imrItemMaterialRequestBooked'){
                                if(data.code === dataExist.itemMaterialRequestBookedCode){
                                    exist = true;
                                }
                            }
                        }if(exist){
                            alert('Has been existing in Grid');
                            return;
                        }else{
                            if(id_document === 'imrItemMaterialRequestBooked'){
                                let defRow = {
                                    imrItemMaterialRequestBookedDelete                 : "delete",
                                    imrItemMaterialRequestBookedCode                   : data.code,
                                    imrItemMaterialRequestBookedName                   : data.name,
                                    imrItemMaterialRequestBookedOnHandStock            : data.onHandStock,
                                    imrItemMaterialRequestBookedQuantity               : data.bookingQuantity,
                                    imrItemMaterialRequestBookedUnitOfMeasureCode      : data.unitOfMeasureCode,
                                    imrItemMaterialRequestBookedUnitOfMeasureName      : data.unitOfMeasureName

                                };
                                
                                imrMaterialBookedRowId++;
                                window.opener.addRowDataMultiSelectedImrBooked(imrMaterialBookedRowId,defRow);
                                
                            }

                        }
                    }
                }
            window.close();
        });


        $("#dlgItemMaterial_cancelButton").click(function(ev) { 
            data_search_itemMaterial = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemMaterialSearch").click(function(ev) {
            $("#dlgSearch_itemMaterial_grid").jqGrid("setGridParam",{url:"master/item-material-booked-search?" + $("#frmItemMaterialSearch").serialize(), page:1});
            $("#dlgSearch_itemMaterial_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#warehouseCode").val(warehouseCode);
        
     });
    
</script>
    
<body>
<s:url id="remoteurlItemMaterialSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemMaterialSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="itemMaterial.code" name="itemMaterial.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="itemMaterial.name" name="itemMaterial.name" size="50"></s:textfield></td>
                    <td><s:textfield id="warehouseCode" name="warehouseCode" size="50" style="display:none"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemMaterialSearch" button="true">Search</sj:a></td>
                </tr>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_itemMaterial_grid"
                dataType="json"
                href="%{remoteurlItemMaterialSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemMaterialTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                multiselect = "true"
                width="$('#tabmnuitemMaterial').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="unitOfMeasureCode" index="unitOfMeasureCode" title="Unit Of Measure Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="unitOfMeasureName" index="unitOfMeasureName" title="Unit Of Measure Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="onHandStock" index="onHandStock" key="onHandStock" title="On Hand Stock" 
                    width="150" align="right"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
                <sjg:gridColumn
                    name="bookingQuantity" index="bookingQuantity" title="Booked Quantity" width="150" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemMaterial_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemMaterial_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>	