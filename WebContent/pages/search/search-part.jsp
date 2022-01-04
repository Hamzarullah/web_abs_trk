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
      
    var search_part_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgPart_okButton").click(function(ev) { 
//            selectedRowId = $("#dlgSearch_part_grid").jqGrid("getGridParam","selrow");
//
//            if(selectedRowId === null){
//                alert("Please Select Row Part!");
//                return;
//            }
//                
//            var data_search_part = $("#dlgSearch_part_grid").jqGrid('getRowData', selectedRowId);
//
//            if (search_part_type === "grid" ) {
//                
//                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
//                $("#"+selectedRowID+"_"+id_document+"PartCode",opener.document).val(data_search_part.code);
//                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"PartName", data_search_part.name);           
//            }
//            else {
//                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_part.code);
//                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_part.name);
//                
//            }
//
//            window.close();

            billOfMaterialTemplateItemDetailLastRowId=rowLast;
            billOfMaterialDetailLastRowId=rowLast;
            
            if (search_part_type === "grid" ) {
                var ids = jQuery("#dlgSearch_part_grid").jqGrid('getDataIDs');
                var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                for(var i=0;i<ids.length;i++){
                    var exist = false;
                    var data = $("#dlgSearch_part_grid").jqGrid('getRowData',ids[i]);
                    if($("input:checkbox[id='jqg_dlgSearch_part_grid_"+ids[i]+"']").is(":checked")){
                        for(var j=0; j<idsOpener.length; j++){
                            var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            if(data.code === dataExist.billOfMaterialTemplateDetailPartCode){
                                exist = true;
                            }
                        }
                        if(exist){
                            alert("data was in grid");
                            return;
                        }else{
                            if(id_document === 'billOfMaterialTemplateDetail'){
                                var defRow = {
                                    billOfMaterialTemplateDetailDelete              :"delete",
                                    billOfMaterialTemplateDetailPartCode            : data.code,
                                    billOfMaterialTemplateDetailPartName            : data.name
                                };

                                window.opener.addRowDataMultiSelected(billOfMaterialTemplateItemDetailLastRowId,defRow);
                                billOfMaterialTemplateItemDetailLastRowId++;
                            }
                            else if(id_document === 'billOfMaterialDetail'){
                                
                                var defRow = {
                                    billOfMaterialDetailDelete   :"delete",
                                    billOfMaterialDetailPartCode : data.code,
                                    billOfMaterialDetailPartName : data.name
                                };
                                
                                billOfMaterialDetailLastRowId++;
                                window.opener.addRowDataMultiSelectedBom(billOfMaterialDetailLastRowId,defRow);
                                
                            }
                        }
                    }
                    
                }
                window.close();
            }
        });

        $("#dlgPart_cancelButton").click(function(ev) { 
            data_search_part = null;
            window.close();
        });
    
        $("#btn_dlg_PartSearch").click(function(ev) {
            $("#dlgSearch_part_grid").jqGrid("setGridParam",{url:"master/part-data?" + $("#frmPartSearch").serialize(), page:1});
            $("#dlgSearch_part_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     });
    
</script>
<ball>
<s:url id="remoteurlPartSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmPartSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="partSearchCode" name="partSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="partSearchName" name="partSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_PartSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_part_grid"
            dataType="json"
            href="%{remoteurlPartSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listPartTemp"
            rowList="10,20,30"
            rowNum="10"
            multiselect = "true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupart').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />       
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgPart_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgPart_cancelButton" button="true">Cancel</sj:a>
</ball>
</html>