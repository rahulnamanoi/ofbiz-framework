<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<script>
function convertTimeToMilliseconds() {
  var setupHours = parseInt(document.getElementById('estimatedSetupHours').value) || 0;
  var setupMinutes = parseInt(document.getElementById('estimatedSetupMinutes').value) || 0;
  var hours = parseInt(document.getElementById('estimatedHours').value) || 0;
  var minutes = parseInt(document.getElementById('estimatedMinutes').value) || 0;

  // Convert to milliseconds (1 hour = 3600000 ms, 1 minute = 60000 ms)
  document.getElementById('hiddenEstimatedSetupMillis').value = (setupHours * 3600000) + (setupMinutes * 60000);
  document.getElementById('hiddenEstimatedMillis').value = (hours * 3600000) + (minutes * 60000);

  return true;
}
</script>

<#if productionRunTask?has_content>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ManufacturingEditProductionRunRoutingTask}</li>
    </ul>
    <br class="clear"/>
  </div>
  <div class="screenlet-body">
  <form name="productiontaskform" method="post" action="<@ofbizUrl>updateProductionRunRoutingTask</@ofbizUrl>" onsubmit="return convertTimeToMilliseconds();">
    <input type="hidden" name="productionRunId" value="${productionRunId}" />
    <input type="hidden" name="routingTaskId" value="${productionRunTask.workEffortId}" />
    <input type="hidden" id="hiddenEstimatedSetupMillis" name="estimatedSetupMillis" />
    <input type="hidden" id="hiddenEstimatedMillis" name="estimatedMilliSeconds" />
<#else>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ManufacturingNewProductionRunRoutingTask}</li>
    </ul>
    <br class="clear"/>
  </div>
  <div class="screenlet-body">
  <form name="productiontaskform" method="post" action="<@ofbizUrl>addProductionRunRoutingTask</@ofbizUrl>" onsubmit="return convertTimeToMilliseconds();">
    <input type="hidden" name="productionRunId" value="${productionRunId}" />
    <input type="hidden" id="hiddenEstimatedSetupMillis" name="estimatedSetupMillis" />
    <input type="hidden" id="hiddenEstimatedMillis" name="estimatedMilliSeconds" />
</#if>
  <table class="basic-table" cellspacing="0">
    <#if !productionRunTask?has_content>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingRoutingTaskId}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <@htmlTemplate.lookupField value="${parameters.routingTaskId!}" formName="productiontaskform" name="routingTaskId" id="routingTaskId" fieldFormName="LookupRoutingTask"/>
      </td>
    </tr>
    </#if>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.CommonSequenceNum}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="4" name="priority" value="${(productionRunTask.priority)!}" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskName}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="50" name="workEffortName" value="${(productionRunTask.workEffortName)!}" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.CommonDescription}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="60" name="description" value="${(productionRunTask.description)!}" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_reservPersons}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="20" name="reservPersons" value="${(productionRunTask.reservPersons)!}" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingStartDate}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <@htmlTemplate.renderDateTimeField name="estimatedStartDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${(productionRunTask.estimatedStartDate)!nowTimestamp}" size="25" maxlength="30" id="estimatedStartDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
      </td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingEstimatedCompletionDate}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <#if productionRunTask?has_content && productionRunTask.estimatedCompletionDate?has_content>
          ${productionRunTask.estimatedCompletionDate?string("yyyy-MM-dd HH:mm:ss")}
        </#if>
      </td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskEstimatedSetupMillis}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <#assign setupHours = ((productionRunTask.estimatedSetupMillis)!0)?number / 3600000>
        <#assign setupMinutes = (((productionRunTask.estimatedSetupMillis)!0)?number % 3600000) / 60000>
       <b>Hours</b> <input type="number" style="width:100px;" id="estimatedSetupHours" size="10" name="estimatedSetupHours" value="${setupHours?int}" min="0" placeholder="Hours" />
       <b>Minutes</b> <input type="number" style="width:100px;" id="estimatedSetupMinutes" size="10" name="estimatedSetupMinutes" value="${setupMinutes?int}" min="0" max="59" placeholder="Minutes" />
      </td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskEstimatedMilliSeconds}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <#assign hours = ((productionRunTask.estimatedMilliSeconds)!0)?number / 3600000>
        <#assign minutes = (((productionRunTask.estimatedMilliSeconds)!0)?number % 3600000) / 60000>
       <b>Hours</b> <input type="number" style="width:100px;" id="estimatedHours" size="3" name="estimatedHours" value="${hours?int}" min="0" placeholder="Hours" />
       <b>Minutes</b> <input type="number" style="width:100px;" id="estimatedMinutes" size="3" name="estimatedMinutes" value="${minutes?int}" min="0" max="59" placeholder="Minutes" />
      </td>
    </tr>
    <tr>
      <td colspan="3" align="center">
        <input type="submit" value="${uiLabelMap.CommonEdit}" class="smallSubmit"/>
      </td>
    </tr>
  </table>
  </form>
  </div>
</div>

