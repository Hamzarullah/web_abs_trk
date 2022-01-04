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
    
    var search_rack_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_warehouse_code= '<%= request.getParameter("idwarehousecode") %>';    
    jQuery(document).ready(function(){  
        
        $("#dlgRack_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_rack_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Rack!");
                return;
            }

            var data_search_rack = $("#dlgSearch_rack_grid").jqGrid('getRowData', selectedRowId);

            if (search_rack_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"RackCode",opener.document).val(data_search_rack.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RackCode", data_search_rack.code);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RackName", data_search_rack.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_rack.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_rack.name);
                $("#"+id_document+"\\.defaultRackCode",opener.document).val(data_search_rack.code);
            }

            window.close();
        });


        $("#dlgRack_cancelButton").click(function(ev) { 
            data_search_rack = null;
            window.close();
        });
    
    
        $("#btn_dlg_RackSearch").click(function(ev) {
            $("#dlgSearch_rack_grid").jqGrid("setGridParam",{url:"master/rack-search?" + $("#frmRackSearch").serialize(), page:1});
            $("#dlgSearch_rack_grid").trigger("reloadGrid");
            ev.preventDefault();
                
//            if (id_document==="rackMutationCogsIn" || id_document==="adjustmentInItemDetail"){
//                $("#dlgSearch_rack_grid").jqGrid("setGridParam",{url:"master/rack-search-data-for-rkm?idWarehouseCode="+id_warehouse_code+"&"+ $("#frmRackSearch").serialize(), page:1});
//                $("#dlgSearch_rack_grid").trigger("reloadGrid");
//                ev.preventDefault();
//            }
//            else {
//                $("#dlgSearch_rack_grid").jqGrid("setGridParam",{url:"master/rack-search-data?" + $("#frmRackSearch").serialize(), page:1});
//                $("#dlgSearch_rack_grid").trigger("reloadGrid");
//                ev.preventDefault();
//            }
            
           
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlRackSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmRackSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="searchRack.code" name="searchRack.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="searchRack.name" name="searchRack.name" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_RackSearch" button="true">Search</sj:a></td>
                </tr>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_rack_grid"
                dataType="json"
                href="%{remoteurlRackSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listRack"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuRACK').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgRack_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgRack_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>