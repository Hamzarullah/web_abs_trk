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
    
    var search_itemMaterialJnVendor_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_ivt='<%= request.getParameter("idivt") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    var id_vendorCode='<%= request.getParameter("vendorCode") %>';  
        
    jQuery(document).ready(function(){  
        
        $("#dlgItemMaterialJnVendor_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_itemMaterialJnVendor_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Item Material Vendor!");
                return;
            }
            
            goodsReceivedNoteItemDetail_lastRowId=rowLast;   
            
            var data_search_itemMaterialJnVendor = $("#dlgSearch_itemMaterialJnVendor_grid").jqGrid('getRowData', selectedRowId);
            
            if (search_itemMaterialJnVendor_type === "grid" ) {
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                var ids = jQuery("#dlgSearch_itemMaterialJnVendor_grid").jqGrid('getDataIDs');
                for(var i=0;i<ids.length;i++){
                        var exist = false;
                        var data = $("#dlgSearch_itemMaterialJnVendor_grid").jqGrid('getRowData',ids[i]);
                        if($("input:checkbox[id='jqg_dlgSearch_itemMaterialJnVendor_grid_"+ids[i]+"']").is(":checked")){
                            for(var j=0; j<idsOpener.length; j++){
                                var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                                if(id_document === 'goodsReceivedNote'){

                                }
                            }if(exist){
                                alert('Has been existing in Grid');
                                return;
                            }else{
                                if(id_document === 'goodsReceivedNote'){
                                    var defRow = {
                                        goodsReceivedNoteItemDetailDelete                         : "delete",
                                        goodsReceivedNoteItemDetailItemMaterialCode               : data.itemMaterialCode,
                                        goodsReceivedNoteItemDetailItemMaterialName               : data.itemMaterialName,
                                        goodsReceivedNoteItemDetailSerialStatus                   : data.itemMaterialSerialStatus
                                    };

                                    window.opener.addRowDataMultiSelectedItemGrn(goodsReceivedNoteItemDetail_lastRowId,defRow);
                                    goodsReceivedNoteItemDetail_lastRowId++;
                                }
                            }
                        }
                    }
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemMaterialJnVendor.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemMaterialJnVendor.name);
            }
            

            window.close();
        });


        $("#dlgItemMaterialJnVendor_cancelButton").click(function(ev) { 
            data_search_itemMaterialJnVendor = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemMaterialJnVendorSearch").click(function(ev) {
                $("#dlgSearch_itemMaterialJnVendor_grid").jqGrid("setGridParam",{url:"master/item-material-jn-vendor-data?" + $("#frmItemMaterialJnVendorSearch").serialize(), page:1});
                $("#dlgSearch_itemMaterialJnVendor_grid").trigger("reloadGrid");
            
        });

           $("#itemMaterialJnVendorSearchVendorCode").val(id_vendorCode);
        
     });
</script>
    
<body>
<s:url id="remoteurlItemMaterialJnVendorSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemMaterialJnVendorSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="itemMaterialJnVendorSearchCode" name="itemMaterialJnVendorSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr hidden="true">
                    <td align="right">Vendor</td>
                    <td><s:textfield id="itemMaterialJnVendorSearchVendorCode" name="itemMaterialJnVendorSearchVendorCode" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemMaterialJnVendorSearch" button="true">Search</sj:a></td>
                </tr>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_itemMaterialJnVendor_grid"
                dataType="json"
                href="%{remoteurlItemMaterialJnVendorSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemMaterialVendorDetail"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                multiselect="true"
                width="$('#tabmnuitemMaterialJnVendor').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Material Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Material Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Item Material Unit Of Measure Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialSerialStatus" index="itemMaterialSerialStatus" key="itemMaterialSerialStatus" title="Item Material Status" width="100" sortable="true"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemMaterialJnVendor_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemMaterialJnVendor_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>