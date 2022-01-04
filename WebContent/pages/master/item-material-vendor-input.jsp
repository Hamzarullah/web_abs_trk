
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">

    var itemMaterialVendorDetailLastSel = -1, itemMaterialVendorDetailLastRowId = 0, itemMaterialVendorDetail_selectedLastSel = -1;
    var itemMaterialVendorDetailExistingLastSel = -1, itemMaterialVendorDetailExistingLastRowId = 0, itemMaterialVendorDetailExisting_selectedLastSel = -1;

    function reloadGridItemMaterialVendor() {
        $("#itemMaterialVendor_grid").trigger("reloadGrid");
    };


    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        
        $('#itemMaterialVendor\\.cogsIDR').val(formatNumber(parseFloat($('#itemMaterialVendor\\.cogsIDR').val()),2));
        $('#itemMaterialVendor\\.partConversion').val(formatNumber(parseFloat($('#itemMaterialVendor\\.partConversion').val()),2));
        $('#itemMaterialVendor\\.tolerance').val(formatNumber(parseFloat($('#itemMaterialVendor\\.tolerance').val()),2));
        $('#itemMaterialVendor\\.conversion').val(formatNumber(parseFloat($('#itemMaterialVendor\\.conversion').val()),2));

        $('#itemMaterialVendor\\.code').keyup(function () {
            this.value = this.value.toUpperCase();
        });
        
        $("#itemMaterialVendor\\.partConversion").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgPartConversion").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterialVendor\\.partConversion").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterialJnVendor(value);
            });
           
        });
        
        $("#itemMaterialVendor\\.partConversion").change(function(e){
            var minStock=$("#itemMaterialVendor\\.partConversion").val();
            
            if(minStock==="" || parseFloat(minStock)===0){
               $("#itemMaterialVendor\\.partConversion").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#itemMaterialVendor\\.tolerance").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTolerance").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterialVendor\\.tolerance").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterialJnVendor(value);
            });
           
        });
        
        $("#itemMaterialVendor\\.tolerance").change(function(e){
            var minStock=$("#itemMaterialVendor\\.tolerance").val();
            
            if(minStock==="" || parseFloat(minStock)===0){
               $("#itemMaterialVendor\\.tolerance").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#itemMaterialVendor\\.conversion").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgConversion").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterialVendor\\.conversion").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterialJnVendor(value);
            });
           
        });
        
        $("#itemMaterialVendor\\.conversion").change(function(e){
            var minStock=$("#itemMaterialVendor\\.conversion").val();
            
            if(minStock==="" || parseFloat(minStock)===0){
               $("#itemMaterialVendor\\.conversion").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#itemMaterialVendor\\.minStock").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgMinStock").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterialVendor\\.minStock").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterialJnVendor(value);
            });
           
        });
        
        $("#itemMaterialVendor\\.minStock").change(function(e){
            var minStock=$("#itemMaterialVendor\\.minStock").val();
            
            if(minStock==="" || parseFloat(minStock)===0){
               $("#itemMaterialVendor\\.minStock").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#itemMaterialVendor\\.maxStock").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgMaxStock").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterialVendor\\.maxStock").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterialJnVendor(value);
            });
        });
        
        $("#itemMaterialVendor\\.maxStock").change(function(e){
            var maxStock=$("#itemMaterialVendor\\.maxStock").val();
            
            if(maxStock==="" || parseFloat(maxStock)===0){
               $("#itemMaterialVendor\\.maxStock").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });

        if ($("#itemMaterialVendor\\.batchStatus").val() === "true") {
            $("#itemMaterialVendorBatchStatusRadYes").prop('checked', true);
        } else {
            $("#itemMaterialVendorBatchStatusRadNo").prop('checked', true);
        }
        
        if ($("#itemMaterialVendor\\.serialNoStatus").val() === "true") {
            $("#itemMaterialVendorSerialNoStatusRadYes").prop('checked', true);
        } else {
            $("#itemMaterialVendorSerialNoStatusRadNo").prop('checked', true);
        }

        if ($("#itemMaterialVendor\\.conversionStatus").val() === "true") {
            $("#itemMaterialVendorConversionStatusRadYes").prop('checked', true);
        } else {
            $("#itemMaterialVendorConversionStatusRadNo").prop('checked', true);
        }

        if ($("#itemMaterialVendor\\.inventoryType").val() === "INVENTORY") {
            $("#itemMaterialVendorRadInventoryTypeINVENTORY").prop('checked', true);
        } else {
            $("#itemMaterialVendorRadInventoryTypeNON_INVENTORY").prop('checked', true);
        }
        if ($("#itemMaterialVendor\\.activeStatus").val() === "true") {
            $("#itemMaterialVendorActiveStatusRadActive").prop('checked', true);
        } else {
            $("#itemMaterialVendorActiveStatusRadInActive").prop('checked', true);
        }

        loadDataItemMaterialVendorDetailExisting();

        $('#btnItemMaterialVendorSave').click(function (ev) {

//            Search Vendor
            if (itemMaterialVendorDetailLastSel !== -1) {
                $('#itemMaterialVendorDetailInput_grid').jqGrid("saveRow", itemMaterialVendorDetailLastSel);
            }
            var listItemMaterialVendorDetail = new Array();
            var ids = jQuery("#itemMaterialVendorDetailInput_grid").jqGrid('getDataIDs');

            if (ids.length === 0) {
                alertMessage("Data Detail Can't Empty!");
                return;
            }
            for (var i = 0; i < ids.length; i++) {
                var data = $("#itemMaterialVendorDetailInput_grid").jqGrid('getRowData', ids[i]);

                if (data.itemMaterialVendorDetailVendorCode === "") {
                    alertMessage("Item Detail Can't Empty! ");
                    return;
                }

                var itemMaterialVendorDetail = {
                    vendor: {code: data.itemMaterialVendorDetailVendorCode},
                    itemMaterial: {code: $("#itemMaterialVendor\\.code").val()}
                };
                listItemMaterialVendorDetail[i] = itemMaterialVendorDetail;
            }

//            formatDateIMV();
//        if ($("#itemMaterialVendorUpdateMode").val() === "true") {
//            var url = "purchasing/item-material-vendor-update";
//        } else {
            var url = "master/item-material-vendor-save";
//        }
//            var params = $("#frmItemMaterialVendorInput").serialize();
            var params = "&listItemMaterialVendorDetailJSON=" + $.toJSON(listItemMaterialVendorDetail);
            showLoading();
            $.post(url, params, function (data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var dynamicDialog = $('<div id="conformBox">' +
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                        '</span>' + data.message + '<br/>Do You Want Input Other Transaction?</div>');

                dynamicDialog.dialog({
                    title: "Confirmation:",
                    closeOnEscape: false,
                    modal: true,
                    width: 400,
                    resizable: false,
                    buttons:
                            [{
                                    text: "Yes",
                                    click: function () {
                                        $(this).dialog("close");
                                        var url = "master/item-material-vendor-input";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuITEM_MATERIAL");
                                    }
                                },
                                {
                                    text: "No",
                                    click: function () {
                                        $(this).dialog("close");
                                        var url = "master/item-material";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuITEM_MATERIAL");

                                    }
                                }]
                });
            });
            ev.preventDefault();
        });

        $('#btnItemMaterialVendorCancel').click(function (ev) {
            var url = "master/item-material";
            var params = "";
            pageLoad(url, params, "#tabmnuITEM_MATERIAL");
        });

    });
    function loadDataItemMaterialVendorDetailExisting() {
            
            var url = "master/item-material-vendor-detail-exisitng";
            var params = "itemMaterialVendor.code=" + $("#itemMaterialVendor\\.code").val();
            $.getJSON(url, params, function (data) {
                itemMaterialVendorDetailExistingLastRowId = 0;
                
                for (var i = 0; i < data.listItemMaterialVendorDetailExisting.length; i++) {
                    itemMaterialVendorDetailExistingLastRowId++;
                    $("#itemMaterialVendorDetailExistingInput_grid").jqGrid("addRowData", itemMaterialVendorDetailExistingLastRowId, data.listItemMaterialVendorDetailExisting[i]);
                    $("#itemMaterialVendorDetailExistingInput_grid").jqGrid('setRowData', itemMaterialVendorDetailExistingLastRowId, {
                        itemMaterialVendorDetailExistingVendorCode: data.listItemMaterialVendorDetailExisting[i].vendorCode,
                        itemMaterialVendorDetailExistingVendorName: data.listItemMaterialVendorDetailExisting[i].vendorName,
                        itemMaterialVendorDetailExistingVendorAddress: data.listItemMaterialVendorDetailExisting[i].vendorAddress
                    });
                }

//                setHeightGridPR();
            });
        }
        
    function numberWithCommasItemMaterialJnVendor(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }

</script>

<s:url id="remoteurlItemMaterialVendor" action="" />
<s:url id="remoteurlItemMaterialVendorDetailInput" action="" />
<b>ITEM MATERIAL VENDOR</b>
<hr>
<br class="spacer"/>

<div id="itemMaterialVendorInput" class="content ui-widget">
    <s:form id="frmItemMaterialVendorInput">
        <table>
            <tr>
                <td>
                    <table cellpadding="2" cellspacing="2">
                        <tr>
                            <td align="right"><B>Code *</B></td>
                            <td><s:textfield id="itemMaterialVendor.code" name="itemMaterialVendor.code" size="25" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: left;" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Name *</B></td>
                                <td><s:textfield id="itemMaterialVendor.name" name="itemMaterialVendor.name" size="50" title="*" required="true" cssClass="required" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Sub Category *</B></td>
                                <td>

                                <s:textfield id="itemMaterialVendor.itemSubCategory.code" name="itemMaterialVendor.itemSubCategory.code" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield>

                                <s:textfield id="itemMaterialVendor.itemSubCategory.name" name="itemMaterialVendor.itemSubCategory.name" size="25" readonly="true"></s:textfield> 

                                </td>
                            </tr>

                            <tr>
                                <td align="right">Item Category</td>
                                <td colspan="2">
                                <s:textfield id="itemMaterialVendor.itemSubCategory.itemCategory.code" name="itemMaterialVendor.itemSubCategory.itemCategory.code" readonly="true" size="15"></s:textfield>
                                <s:textfield id="itemMaterialVendor.itemSubCategory.itemCategory.name" name="itemMaterialVendor.itemSubCategory.itemCategory.name" readonly="true" size="25"></s:textfield> 
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Division</td>
                                <td colspan="2">
                                <s:textfield id="itemMaterialVendor.itemSubCategory.itemCategory.itemDivision.code" name="itemMaterialVendor.itemSubCategory.itemCategory.itemDivision.code" readonly="true" size="15"></s:textfield>
                                <s:textfield id="itemMaterialVendor.itemSubCategory.itemCategory.itemDivision.name" name="itemMaterialVendor.itemSubCategory.itemCategory.itemDivision.name" readonly="true" size="25"></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>UOM *</B></td>
                                <td>
                                <s:textfield id="itemMaterialVendor.unitOfMeasure.code" name="itemMaterialVendor.unitOfMeasure.code" title=" " required="true" cssClass="required" size="20" readonly="true"></s:textfield>

                                <s:textfield id="itemMaterialVendor.unitOfMeasure.name" name="itemMaterialVendor.unitOfMeasure.name" size="25" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Brand *</B></td>
                                <td>

                                <s:textfield id="itemMaterialVendor.itemBrand.code" name="itemMaterialVendor.itemBrand.code" title=" " required="true" cssClass="required" size="20" readonly="true"></s:textfield>
                                <s:textfield id="itemMaterialVendor.itemBrand.name" name="itemMaterialVendor.itemBrand.name" size="25" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Part Conversion</td>
                                <td><s:textfield id="itemMaterialVendor.partConversion" name="itemMaterialVendor.partConversion" size="20" cssStyle="text-align:right" 
                                         formatter="number" formatoptions= "{ thousandsSeparator:','}" readonly="true" disabled="true"></s:textfield></td> 
                            </tr>
                            <tr>
                                <td align="right">Tolerance</td>
                                <td><s:textfield id="itemMaterialVendor.tolerance" name="itemMaterialVendor.tolerance" size="20" cssStyle="text-align:right" 
                                        formatter="number" formatoptions= "{ thousandsSeparator:','}" readonly="true" disabled="true"></s:textfield></td> 
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>Batch Status *</B>
                                <s:textfield id="itemMaterialVendor.batchStatus" name="itemMaterialVendor.batchStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="itemMaterialVendorBatchStatusRad" name="itemMaterialVendorBatchStatusRad" list="{'Yes','No'}" disabled="true"></s:radio></td> 
                            </tr>     
                            <tr>
                                <td align="right"><B>Conversion Status *</B>
                                <s:textfield id="itemMaterialVendor.conversionStatus" name="itemMaterialVendor.conversionStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="itemMaterialVendorConversionStatusRad" name="itemMaterialVendorConversionStatusRad" list="{'Yes','No'}" disabled="true"></s:radio></td> 
                            </tr>     
                            <tr>
                                <td align="right"><B>Serial Non Status *</B>
                                <s:textfield id="itemMaterialVendor.serialNoStatus" name="itemMaterialVendor.serialNoStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="itemMaterialVendorSerialNoStatusRad" name="itemMaterialVendorSerialNoStatusRad" list="{'Yes','No'}" disabled="true"></s:radio></td> 
                            </tr>     
                            <tr>
                                <td align="right">Conversion</td>
                                <td><s:textfield id="itemMaterialVendor.conversion" name="itemMaterialVendor.conversion" size="20" cssStyle="text-align:right" 
                                        formatter="number" formatoptions= "{ thousandsSeparator:','}" readonly="true" disabled="true"></s:textfield></td> 
                            </tr>
                            <tr>
                                <td align="right"><B>Inventory Type *</B>
                                <s:textfield id="itemMaterialVendor.inventoryType" name="itemMaterialVendor.inventoryType" readonly="false" size="20" value = "INVENTORY" style="display:none"></s:textfield></td>
                            <td><s:radio id="itemMaterialVendorRadInventoryType" name="itemMaterialVendorRadInventoryType" list="{'INVENTORY','NON_INVENTORY'}" disabled="true"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right">Min Stock</td>
                                <td><s:textfield id="itemMaterialVendor.minStock" name="itemMaterialVendor.minStock" size="20" cssStyle="text-align:right" 
                                         formatter="number" formatoptions= "{ thousandsSeparator:','}" readonly="true" disabled="true"></s:textfield></td>   
                            </tr>
                            <tr>
                                <td align="right">Max Stock</td>
                                <td><s:textfield id="itemMaterialVendor.maxStock" name="itemMaterialVendor.maxStock" size="20" cssStyle="text-align:right" 
                                         formatter="number" formatoptions= "{ thousandsSeparator:','}" readonly="true" disabled="true"></s:textfield></td> 
                            </tr>
                            <tr>
                                <td align="right">COGS IDR</td>
                                <td><s:textfield id="itemMaterialVendor.cogsIDR" name="itemMaterialVendor.cogsIDR" readonly="true" size="20" cssStyle="text-align:right" 
                                         formatter="number" formatoptions= "{ thousandsSeparator:','}" disabled="true" ></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Active Status *</B>
                                <s:textfield id="itemMaterialVendor.activeStatus" name="itemMaterialVendor.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="itemMaterialVendorActiveStatusRad" name="itemMaterialVendorActiveStatusRad" list="{'Active','InActive'}" disabled="true"></s:radio></td> 
                            </tr>

                            <tr height="50">
                                <td></td>
                                <td>
                                <sj:a href="#" id="btnItemMaterialVendorSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnItemMaterialVendorCancel" button="true">Cancel</sj:a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
    </s:form>
    <script>

        $.subscribe("itemMaterialVendorDetailInput_grid_onSelect", function () {
            var selectedRowID = $("#itemMaterialVendorDetailInput_grid").jqGrid("getGridParam", "selrow");
            itemMaterialVendorDetail_selectedLastSel = selectedRowID;
            if (selectedRowID !== itemMaterialVendorDetailLastSel) {
                $('#itemMaterialVendorDetailInput_grid').jqGrid("saveRow", itemMaterialVendorDetailLastSel);
                $('#itemMaterialVendorDetailInput_grid').jqGrid("editRow", selectedRowID, true);
                itemMaterialVendorDetailLastSel = selectedRowID;
            } else {
                $('#itemMaterialVendorDetailInput_grid').jqGrid("saveRow", selectedRowID);
            }

        });

        $('#btnItemMaterialVendorDetail').click(function (ev) {
            window.open("./pages/search/search-vendor-multiple.jsp?iddoc=itemMaterialVendorDetail&type=grid" + "&rowLast=" + itemMaterialVendorDetailLastRowId, "Search", "scrollbars=1, width=900, height=600");
        });

        function addRowItemMaterialVendorDetailVendorDataMultiSelected(lastRowId, defRow) {
            var ids = jQuery("#itemMaterialVendorDetailInput_grid").jqGrid('getDataIDs');
            var lastRow = [0];
            for (var i = 0; i < ids.length; i++) {
                var comp = (ids[i] - lastRow[0]) > 0;
                if (comp) {
                    lastRow = [];
                    lastRow.push(ids[i]);
                }
            }
            itemMaterialVendorDetailLastRowId = lastRowId;

            var data = $("#itemMaterialVendorDetailInput_grid").jqGrid('getRowData', lastRowId);
            $("#itemMaterialVendorDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#itemMaterialVendorDetailInput_grid").jqGrid('setRowData', lastRowId, {
                itemMaterialVendorDetailDelete: "delete",
                itemMaterialVendorDetailVendorCode: defRow.itemMaterialVendorDetailVendorCode,
                itemMaterialVendorDetailVendorName: defRow.itemMaterialVendorDetailVendorName,
                itemMaterialVendorDetailVendorAddress: defRow.itemMaterialVendorDetailVendorAddress


            });
        }

        function itemMaterialVendorDetailInputGrid_Delete_OnClick() {
            var selectDetailRowId = $("#itemMaterialVendorDetailInput_grid").jqGrid('getGridParam', 'selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            $("#itemMaterialVendorDetailInput_grid").jqGrid('delRowData', selectDetailRowId);
            setHeightGridItemMaterialVendorDetail();
        }

        function setHeightGridItemMaterialVendorDetail() {
            var ids = jQuery("#itemMaterialVendorDetailInput_grid").jqGrid('getDataIDs');
            if (ids.length > 15) {
                var rowHeight = $("#itemMaterialVendorDetailInput_grid" + " tr").eq(1).height();
                $("#itemMaterialVendorDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15, true);
            } else {
                $("#itemMaterialVendorDetailInput_grid").jqGrid('setGridHeight', "100%", true);
            }

        }
    </script>
    <table width="20%">
        <tr>
            <td>
                <sj:a href="#" id="btnItemMaterialVendorDetail" button="true" style="width: 90%">Search Vendor</sj:a> 
                </td>
            </tr>
        </table>
    <sjg:grid
        id="itemMaterialVendorDetailInput_grid"
        dataType="local"                    
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemMaterialVendorDetail"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        editinline="true"
        width="690"
        editurl="%{remoteurlItemMaterialVendorDetailInput}"
        onSelectRowTopics="itemMaterialVendorDetailInput_grid_onSelect"
        >
        <sjg:gridColumn
            name="itemMaterialVendorDetail" index="itemMaterialVendorDetail" title="" width="10" align="centre"
            editable="true" edittype="text" hidden="true"
            />
        <sjg:gridColumn
            name="itemMaterialVendorDetailDelete" index="itemMaterialVendorDetailDelete" title="" width="50" align="centre"
            editable="true"
            edittype="button"
            editoptions="{onClick:'itemMaterialVendorDetailInputGrid_Delete_OnClick()', value:'delete'}"
            />
        <sjg:gridColumn
            name="itemMaterialVendorDetailVendorCode" index="itemMaterialVendorDetailVendorCode" 
            key="itemMaterialVendorDetailVendorCode" title="Vendor Code" width="80" sortable="true" 
            />

        <sjg:gridColumn
            name = "itemMaterialVendorDetailVendorName" index = "itemMaterialVendorDetailVendorName" key = "itemMaterialVendorDetailVendorName" 
            title = "Vendor Name" width = "150"
            />
        <sjg:gridColumn
            name = "itemMaterialVendorDetailVendorAddress" index="itemMaterialVendorDetailVendorAddress" key="itemMaterialVendorDetailVendorAddress" title="Address" width="150" 
            />
    </sjg:grid>  
    <br/>     
   
    <sjg:grid
        id="itemMaterialVendorDetailExistingInput_grid"
        caption="Existing Vendor"
        dataType="local"                    
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemMaterialVendorDetailExisting"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        editinline="true"
        width="690"
        editurl="%{remoteurlItemMaterialVendorDetailExistingInput}"
        onSelectRowTopics="itemMaterialVendorDetailExistingInput_grid_onSelect"
        >
        <sjg:gridColumn
            name="itemMaterialVendorDetailExisting" index="itemMaterialVendorDetailExisting" title="" width="10" align="centre"
            editable="true" edittype="text" hidden="true"
            />
        <sjg:gridColumn
            name="itemMaterialVendorDetailExistingVendorCode" index="itemMaterialVendorDetailExistingVendorCode" 
            key="itemMaterialVendorDetailExistingVendorCode" title="Vendor Code" width="80" sortable="true" 
            />

        <sjg:gridColumn
            name = "itemMaterialVendorDetailExistingVendorName" index = "itemMaterialVendorDetailExistingVendorName" key = "itemMaterialVendorDetailExistingVendorName" 
            title = "Vendor Name" width = "150"
            />
        <sjg:gridColumn
            name = "itemMaterialVendorDetailExistingVendorAddress" index="itemMaterialVendorDetailExistingVendorAddress" key="itemMaterialVendorDetailExistingVendorAddress" title="Address" width="150" edittype="text" editable="true"
            />
    </sjg:grid>
</div>
