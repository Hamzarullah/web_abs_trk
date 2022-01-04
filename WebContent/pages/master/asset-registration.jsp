
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    var 
        txtAssetRegistrationCode = $("#assetRegistration\\.code"),
        txtAssetRegistrationName = $("#assetRegistration\\.name"),
        txtAssetRegistrationAcquiredDate = $("#assetRegistration\\.acquiredDate"),
        txtAssetRegistrationAssetCategoryCode = $("#assetRegistration\\.assetCategory\\.code"),
        txtAssetRegistrationAssetCategoryName = $("#assetRegistration\\.assetCategory\\.name"),
        txtAssetRegistrationCurrencyCode = $("#assetRegistration\\.currency\\.code"),
        txtAssetRegistrationCurrencyName = $("#assetRegistration\\.currency\\.name"),
        txtAssetRegistrationExchangeRate = $("#assetRegistration\\.exchangeRate"),
        txtAssetRegistrationPriceForeign = $("#assetRegistration\\.priceForeign"),
        txtAssetRegistrationPriceIDR = $("#assetRegistration\\.priceIDR"),
        txtAssetRegistrationSerialNo = $("#assetRegistration\\.serialNo"),
        txtAssetRegistrationRefNo = $("#assetRegistration\\.refNo"),
        txtAssetRegistrationRemark = $("#assetRegistration\\.remark"),
        rdbAssetRegistrationActiveStatus = $("#assetRegistration\\.activeStatus"),
        txtAssetRegistrationCreatedBy = $("#assetRegistration\\.createdBy"),
        txtAssetRegistrationCreatedDate = $("#assetRegistration\\.createdDate"),
        
        allFieldsAssetRegistration=$([])
            .add(txtAssetRegistrationCode)
            .add(txtAssetRegistrationName)
            .add(txtAssetRegistrationAcquiredDate)
            .add(txtAssetRegistrationAssetCategoryCode)
            .add(txtAssetRegistrationAssetCategoryName)
            .add(txtAssetRegistrationCurrencyCode)
            .add(txtAssetRegistrationCurrencyName)
            .add(txtAssetRegistrationExchangeRate)
            .add(txtAssetRegistrationPriceForeign)
            .add(txtAssetRegistrationPriceIDR)
            .add(txtAssetRegistrationSerialNo)
            .add(txtAssetRegistrationRefNo)
            .add(txtAssetRegistrationRemark)
            .add(rdbAssetRegistrationActiveStatus)
            .add(txtAssetRegistrationCreatedBy)
            .add(txtAssetRegistrationCreatedDate);  
      
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("assetRegistration");
        
        $('#assetRegistration\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#assetRegistrationSearchActiveStatusRadActive').prop('checked',true);
        $("#assetRegistrationSearchActiveStatus").val("true");
        
        $('input[name="assetRegistrationSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#assetRegistrationSearchActiveStatus").val(value);            
        });
                
        $('input[name="assetRegistrationSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#assetRegistrationSearchActiveStatus").val(value);
        });
        
        $('input[name="assetRegistrationSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#assetRegistrationSearchActiveStatus").val(value);
        });
        
        $('input[name="assetRegistration\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#assetRegistration\\.activeStatus").val(value);           
        });
                
        $('input[name="assetRegistration\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#assetRegistration\\.activeStatus").val(value);
        });

        $("#assetRegistration\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#assetRegistration\\.exchangeRate").change(function(e){
            var exchangeRate=$("#item\\.exchangeRate").val();
            if(exchangeRate==="" || parseFloat(exchangeRate)===0){
               $("#item\\.exchangeRate").val("1.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
        });

        $("#assetRegistration\\.priceForeign").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgPriceForeign").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#assetRegistration\\.priceForeign").change(function(e){
            var priceForeign=$("#item\\.priceForeign").val();
            if(priceForeign==="" || parseFloat(priceForeign)===0){
               $("#item\\.priceForeign").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
        });

        $("#btnAssetRegistrationNew").click(function(ev){
            var url="master/asset-registration-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                showInput("assetRegistration");
                hideInput("assetRegistrationSearch");
                $('#assetRegistration\\.activeStatusActive').prop('checked',true);
                $("#assetRegistration\\.activeStatus").val("true");
                var today=getDateTimeIndonesianToday(false);
                $("#assetRegistration\\.acquiredDate").val(today);
                txtAssetRegistrationCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtAssetRegistrationCode.attr("readonly",false);
                txtAssetRegistrationCode.val("");
                txtAssetRegistrationAssetCategoryCode.val($("#assetCategoryCode").val());
                txtAssetRegistrationAssetCategoryName.val($("#assetCategoryName").val());
                txtAssetRegistrationCurrencyCode.val($("#currencyCode").val());
                txtAssetRegistrationCurrencyName.val($("#currencyName").val());
                txtAssetRegistrationExchangeRate.val("1.00");
                txtAssetRegistrationPriceForeign.val("0.00");
                txtAssetRegistrationPriceIDR.val("0.00");           
            });
            ev.preventDefault();
        });
        
        $("#btnAssetRegistrationSave").click(function(ev) {            
            if(!$("#frmAssetRegistrationInput").valid()) {
                ev.preventDefault();
                return;
            };
           
            assetRegistrationFormatDate();

            var exchangeRate=removeCommas($("#assetRegistration\\.exchangeRate").val());
            txtAssetRegistrationExchangeRate.val(exchangeRate);
                
            var priceForeign=removeCommas($("#assetRegistration\\.priceForeign").val());
            txtAssetRegistrationPriceForeign.val(priceForeign);          
                
            var priceIDR=removeCommas($("#assetRegistration\\.priceIDR").val());
            txtAssetRegistrationPriceIDR.val(priceIDR);
 
            var url = "";
            if (updateRowId < 0)
                url = "master/asset-registration-save";
            else
                url = "master/asset-registration-update";

            var params = $("#frmAssetRegistrationInput").serialize();

            $.post(url, params, function(data) {
                if (data.error) {
                    assetRegistrationFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }

                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }

                alertMessage(data.message);

                hideInput("assetRegistration");
                showInput("assetRegistrationSearch");
                allFieldsAssetRegistration.val('').removeClass('ui-state-error');
                reloadGridAssetRegistration();           
            });
           
            ev.preventDefault();
        });
        
        $("#btnAssetRegistrationUpdate").click(function(ev){
            var url="master/asset-registration-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                updateRowId = $("#assetRegistration_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var assetRegistration = $("#assetRegistration_grid").jqGrid('getRowData', updateRowId);
                var url = "master/asset-registration-get-data";
                var params = "assetRegistration.code=" + assetRegistration.code;

                txtAssetRegistrationCode.attr("readonly",true);

                $.post(url, params, function(result) {
                    var data = (result);
                        txtAssetRegistrationCode.val(data.assetRegistrationTemp.code);
                        txtAssetRegistrationName.val(data.assetRegistrationTemp.name);
                        var assetRegistrationAcquiredDate = formatDateRemoveT(data.assetRegistrationTemp.acquiredDate, true);
                        txtAssetRegistrationAcquiredDate.val(assetRegistrationAcquiredDate);
                        txtAssetRegistrationAssetCategoryCode.val(data.assetRegistrationTemp.assetCategoryCode);
                        txtAssetRegistrationAssetCategoryName.val(data.assetRegistrationTemp.assetCategoryName);
                        txtAssetRegistrationCurrencyCode.val(data.assetRegistrationTemp.currencyCode);
                        txtAssetRegistrationCurrencyName.val(data.assetRegistrationTemp.currencyName);

                        var AssetRegistrationExchangeRate = formatNumber(parseFloat(data.assetRegistrationTemp.exchangeRate),2);
                        txtAssetRegistrationExchangeRate.val(AssetRegistrationExchangeRate);

                        var AssetRegistrationPriceForeign = formatNumber(parseFloat(data.assetRegistrationTemp.priceForeign),2);
                        txtAssetRegistrationPriceForeign.val(AssetRegistrationPriceForeign);
                                                
                        var AssetRegistrationPriceIDR = formatNumber(parseFloat(data.assetRegistrationTemp.priceIDR),2);
                        txtAssetRegistrationPriceIDR.val(AssetRegistrationPriceIDR);

                        txtAssetRegistrationSerialNo.val(data.assetRegistrationTemp.serialNo);
                        txtAssetRegistrationRefNo.val(data.assetRegistrationTemp.refNo);
                        txtAssetRegistrationRemark.val(data.assetRegistrationTemp.remark);
                        rdbAssetRegistrationActiveStatus.val(data.assetRegistrationTemp.activeStatus);
                        txtAssetRegistrationCreatedBy.val(data.assetRegistrationTemp.createdBy);
                        txtAssetRegistrationCreatedDate.val(data.assetRegistrationTemp.createdDate);
                        
                        if(data.assetRegistrationTemp.activeStatus===true) {
                           $('#assetRegistration\\.activeStatusActive').prop('checked',true);
                           $("#assetRegistration\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#assetRegistration\\.activeStatusInActive').prop('checked',true);              
                           $("#assetRegistration\\.activeStatus").val("false");
                        }

                    showInput("assetRegistration");
                    hideInput("assetRegistrationSearch");
                });
                
            });
            ev.preventDefault();
        });
        
        $('#btnAssetRegistrationDelete').click(function(ev) {
            var url="master/asset-registration-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#assetRegistration_grid").jqGrid('getGridParam','selrow');
            
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var assetRegistration = $("#assetRegistration_grid").jqGrid('getRowData', deleteRowId);

                if (confirm("Are You Sure To Delete (Code : " + assetRegistration.code + ")")) {
                    var url = "master/asset-registration-delete";
                    var params = "assetRegistration.code=" + assetRegistration.code;

                    $.post(url, params, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }

                        alertMessage(data.message);
                        reloadGridAssetRegistration();
                    });
                }
            });
            ev.preventDefault();
        });

        $("#btnAssetRegistrationCancel").click(function(ev) {
            hideInput("assetRegistration");
            showInput("assetRegistrationSearch");
            allFieldsAssetRegistration.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        $('#btnAssetRegistrationRefresh').click(function(ev) {  
            $('#assetRegistrationSearchActiveStatusRadActive').prop('checked',true);
            $("#assetRegistrationSearchActiveStatus").val("true");
            $("#assetRegistration_grid").jqGrid("clearGridData");
            $("#assetRegistration_grid").jqGrid("setGridParam",{url:"master/asset-registration-data?"});
            $("#assetRegistration_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
               
        $('#btnAssetRegistration_search').click(function(ev) {
            $("#assetRegistration_grid").jqGrid("clearGridData");
            $("#assetRegistration_grid").jqGrid("setGridParam",{url:"master/asset-registration-data?" + $("#frmAssetRegistrationSearchInput").serialize()});
            $("#assetRegistration_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnAssetRegistrationPrint").click(function(ev) {
            var status=$('#assetRegistrationSearchActiveStatus').val();
            var url = "report/asset-registration-print-out-pdf?";
            var params = "activeStatus="+status;
              
            window.open(url+params,'assetRegistration','width=500,height=500');
        });
       
        $('#assetRegistration_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=assetRegistration&idsubdoc=currency","Search", "width=700, height=500");
        });
       
        $('#assetRegistration_btnAssetCategory').click(function(ev) {
            window.open("./pages/search/search-asset-category.jsp?iddoc=assetRegistration&idsubdoc=assetCategory","Search", "width=700, height=500");
        });
    }); // End Of Ready
    
    function reloadGridAssetRegistration() {
        $("#assetRegistration_grid").trigger("reloadGrid");
    };
    
    function calculatePriceIDR(){
        var priceForeign=removeCommas($("#assetRegistration\\.priceForeign").val());
        var exchangeRate=removeCommas($("#assetRegistration\\.exchangeRate").val());
        var priceIDR=(parseFloat(priceForeign)* parseFloat(exchangeRate));
        if(priceForeign===""){
            $("#assetRegistration\\.priceIDR").val("0.00");
        }else{
            $("#assetRegistration\\.priceIDR").val(formatNumber(priceIDR,2));
        }
    };
 
    function assetRegistrationFormatDate(){    
        var acquiredDate=formatDate(txtAssetRegistrationAcquiredDate.val(),false);
        txtAssetRegistrationAcquiredDate.val(acquiredDate);
    }    
</script>

<s:url id="remoteurlAssetRegistration" action="asset-registration-data" />
<b>ASSET REGISTRATION</b>
<hr>
<br class="spacer" />
<sj:div id="assetRegistrationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <a href="#" id="btnAssetRegistrationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/></a>
    <a href="#" id="btnAssetRegistrationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/></a>
    <a href="#" id="btnAssetRegistrationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/></a>
    <a href="#" id="btnAssetRegistrationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
    <a href="#" id="btnAssetRegistrationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/></a>
</sj:div>
        
<div id="assetRegistrationSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmAssetRegistrationSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre">Code</td>
                <td>
                    <s:textfield id="assetRegistrationSearchCode" name="assetRegistrationSearchCode" size="30"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="centre">Name</td>
                <td>
                    <s:textfield id="assetRegistrationSearchName" name="assetRegistrationSearchName" size="50"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="assetRegistrationSearchActiveStatus" name="assetRegistrationSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="assetRegistrationSearchActiveStatusRad" name="assetRegistrationSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>  
        </table>
        <br />
        <sj:a href="#" id="btnAssetRegistration_search" button="true">Search</sj:a>
    </s:form>
</div>
<br class="spacer" />
    
<div id="assetRegistrationGrid">
    <sjg:grid
        id="assetRegistration_grid"
        dataType="json"
        href="%{remoteurlAssetRegistration}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listAssetRegistrationTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuAssetRegistration').width()"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />

        <sjg:gridColumn
            name="name" index="name" title="Name" width="225" sortable="true"
        />

        <sjg:gridColumn
            name="acquiredDate" index="acquiredDate" title="Acquired Date" width="100" sortable="true" formatter="date" 
        />

        <sjg:gridColumn
            name="assetCategoryName" index="assetCategoryName" key = "assetCategoryName" title="Asset Category" width="150" sortable="true"
        />

        <sjg:gridColumn
            name="currencyCode" index="currencyCode" title="Currency" width="75" sortable="true"
        />

        <sjg:gridColumn
            name="priceForeign" index="priceForeign" title="Price" width="75" sortable="true" 
            align= "right" formatter="number" formatoptions= "{ thousandsSeparator:','}"
        />

        <sjg:gridColumn
            name="exchangeRate" index="exchangeRate" title="Rate" width="75" sortable="true" 
           align ="right" formatter="number" formatoptions= "{ thousandsSeparator:','}"
        />
        
        <sjg:gridColumn
            name="serialNo" index="serialNo" title="Serial No" width="100" sortable="true"
        />
        
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />
    </sjg:grid >

</div>
    
<div id="assetRegistrationInput" class="content ui-widget">
    <s:form id="frmAssetRegistrationInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Asset Code *</b></td>
                <td><s:textfield id="assetRegistration.code" name="assetRegistration.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Asset Name *</B></td>
                <td><s:textfield id="assetRegistration.name" name="assetRegistration.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            
             <tr>
                <td align="right"><B>Acquired Date *</B></td>
                <td>
                    <sj:datepicker id="assetRegistration.acquiredDate" name="assetRegistration.acquiredDate"  title = "*" required="true" cssClass="required" displayFormat="dd/mm/yy" showOn="focus" size="20"></sj:datepicker>
                </td>
            </tr>
                    
            <tr>
                <td align="right"><B>Category *</B></td>
                <td>
                    <script type = "text/javascript">

                        txtAssetRegistrationAssetCategoryCode.change(function(ev) {

                            if(txtAssetRegistrationAssetCategoryCode.val()===""){
                                txtAssetRegistrationAssetCategoryCode.val("");
                                txtAssetRegistrationAssetCategoryName.val("");
                                return;
                            }

                            var url = "master/asset-category-get";
                            var params = "assetCategory.code=" + txtAssetRegistrationAssetCategoryCode.val();
                            params += "&assetCategory.accountType=S";
                            params += "&assetCategory.activeStatus="+true;
                            
                            $.post(url, params, function(result) {
                                var data = (result);

                                if (data.assetCategoryTemp){
                                    txtAssetRegistrationAssetCategoryCode.val(data.assetCategoryTemp.code);
                                    txtAssetRegistrationAssetCategoryName.val(data.assetCategoryTemp.name);
                                }
                                else{
                                    txtAssetRegistrationAssetCategoryCode.val("");
                                    txtAssetRegistrationAssetCategoryName.val("");
                                    alert("Asset Category Found");
                                }
                            });
                        });

                    </script>
                    <div class="searchbox ui-widget-header">
                    <s:textfield id="assetRegistration.assetCategory.code" name="assetRegistration.assetCategory.code" title="*" required="true" cssClass="required" size="25" maxLength="45"></s:textfield>
                        <sj:a id="assetRegistration_btnAssetCategory" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="assetRegistration.assetCategory.name" name="assetRegistration.assetCategory.name" size="45" readonly="true"></s:textfield> 
                </td>
            </tr>
                        
            <tr>
                <td align="right"><B>Acquisiton Currency *</B></td>
                <td>
                    <script type = "text/javascript">

                        txtAssetRegistrationCurrencyCode.change(function(ev) {

                            if(txtAssetRegistrationCurrencyCode.val()===""){
                                txtAssetRegistrationCurrencyCode.val("");
                                txtAssetRegistrationCurrencyName.val("");
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtAssetRegistrationCurrencyCode.val();
                            params += "&currency.accountType=S";
                            params += "&currency.activeStatus="+true;
                            
                            $.post(url, params, function(result) {
                                var data = (result);

                                if (data.currencyTemp){
                                    txtAssetRegistrationCurrencyCode.val(data.currencyTemp.code);
                                    txtAssetRegistrationCurrencyName.val(data.currencyTemp.name);
                                }
                                else{
                                    txtAssetRegistrationCurrencyCode.val("");
                                    txtAssetRegistrationCurrencyName.val("");
                                    alert("Account Not Found");
                                }
                            });
                        });

                    </script>
                    <div class="searchbox ui-widget-header">
                    <s:textfield id="assetRegistration.currency.code" name="assetRegistration.currency.code" title="*" required="true" cssClass="required" size="25" maxLength="45"></s:textfield>
                        <sj:a id="assetRegistration_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="assetRegistration.currency.name" name="assetRegistration.currency.name" size="45" readonly="true"></s:textfield> 
                </td>
            </tr>
                        
            <tr>
                <td align="right"><B>Acquisiton Exchange Rate *</B></td>
                <td><s:textfield id="assetRegistration.exchangeRate" name="assetRegistration.exchangeRate" onkeyup="calculatePriceIDR()" 
                         size="25" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align:right"
                         formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Acquisiton Price Foreign *</B></td>
                <td><s:textfield id="assetRegistration.priceForeign" name="assetRegistration.priceForeign" onkeyup="calculatePriceIDR()" 
                         size="25" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align:right" PlaceHolder="0.00"
                         formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Acquisiton Price IDR *</B></td>
                <td><s:textfield id="assetRegistration.priceIDR" name="assetRegistration.priceIDR" readonly="true" size="25" title="*" maxLength="45" cssStyle="text-align:right"
                         formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Serial No </B></td>
                <td><s:textfield id="assetRegistration.serialNo" name="assetRegistration.serialNo" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Ref No </B></td>
                <td><s:textfield id="assetRegistration.refNo" name="assetRegistration.refNo" size="25" title="*"  maxLength="45"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Remark </B></td>
                <td><s:textfield id="assetRegistration.remark" name="assetRegistration.remark" size="35" title="*" maxLength="65"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="assetRegistration.activeStatus" name="assetRegistration.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="assetRegistration.activeStatus" name="assetRegistration.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr>
            
            <td></td>
            <td>
                <sj:a href="#" id="btnAssetRegistrationSave" button="true">Save</sj:a>
                <sj:a href="#" id="btnAssetRegistrationCancel" button="true">Cancel</sj:a>
            </td>
            <td><s:textfield id="assetRegistration.createdBy"  name="assetRegistration.createdBy" size="20" style="display:none"></s:textfield></td>
            <td><s:textfield id="assetRegistration.createdDate" name="assetRegistration.createdDate" size="20" style="display:none"></s:textfield></td>

            <td><s:textfield id="currencyCode" name="currencyCode" size="20" hidden = "true"></s:textfield></td>
            <td><s:textfield id="currencyName" name="currencyName" size="20" hidden = "true"></s:textfield></td>

        </table>
    </s:form>
</div>