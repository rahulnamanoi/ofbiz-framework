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
function updateEstimatedStartDate() {
  var dateTimeInput = document.getElementById('estimatedStartDateInput');
  var hiddenInput = document.getElementById('estimatedStartDate');
  if (dateTimeInput && dateTimeInput.value && hiddenInput) {
    // Convert from "2025-11-25T13:26" to "2025-11-25 13:26:00"
    var dateTimeValue = dateTimeInput.value.replace('T', ' ') + ':00';
    hiddenInput.value = dateTimeValue;
  }
}

function convertTimeToMilliseconds() {
  var setupHours = parseInt(document.getElementById('estimatedSetupHours').value) || 0;
  var setupMinutes = parseInt(document.getElementById('estimatedSetupMinutes').value) || 0;
  var hours = parseInt(document.getElementById('estimatedHours').value) || 0;
  var minutes = parseInt(document.getElementById('estimatedMinutes').value) || 0;

  // Convert to milliseconds (1 hour = 3600000 ms, 1 minute = 60000 ms)
  document.getElementById('hiddenEstimatedSetupMillis').value = (setupHours * 3600000) + (setupMinutes * 60000);
  document.getElementById('hiddenEstimatedMillis').value = (hours * 3600000) + (minutes * 60000);

  // Update the estimated start date one more time before submit
  updateEstimatedStartDate();

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
      <td align='right' valign='top' class="label">${uiLabelMap.ManufacturingRoutingTaskId}</td>
      <td>
        <@htmlTemplate.lookupField value="${parameters.routingTaskId!}" formName="productiontaskform" name="routingTaskId" id="routingTaskId" fieldFormName="LookupRoutingTask"/>
      </td>
    </tr>
    </#if>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.CommonSequenceNum}</td>
      <td><input type="text" size="4" name="priority" value="${(productionRunTask.priority)!}" /></td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskName}</td>
      <td><input type="text" size="50" name="workEffortName" value="${(productionRunTask.workEffortName)!}" /></td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.CommonDescription}</td>
      <td><input type="text" size="60" name="description" value="${(productionRunTask.description)!}" /></td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_reservPersons}</td>
      <td><input type="text" size="20" name="reservPersons" value="${(productionRunTask.reservPersons)!}" /></td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.ManufacturingStartDate}</td>
      <td>
        <#assign startDateValue = "">
        <#assign formattedStartDate = "">
        <#if productionRunTask?has_content && productionRunTask.estimatedStartDate?has_content>
          <#assign startDateValue = productionRunTask.estimatedStartDate?string("yyyy-MM-dd'T'HH:mm")>
          <#assign formattedStartDate = productionRunTask.estimatedStartDate?string("yyyy-MM-dd HH:mm:ss")>
        <#elseif nowTimestamp?has_content>
          <#assign startDateValue = nowTimestamp?string("yyyy-MM-dd'T'HH:mm")>
          <#assign formattedStartDate = nowTimestamp?string("yyyy-MM-dd HH:mm:ss")>
        </#if>
        <input type="datetime-local" id="estimatedStartDateInput" value="${startDateValue}" size="25" onchange="updateEstimatedStartDate()" />
        <input type="hidden" name="estimatedStartDate" id="estimatedStartDate" value="${formattedStartDate}" />
      </td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.ManufacturingEstimatedCompletionDate}</td>
      <td>
        <#if productionRunTask?has_content && productionRunTask.estimatedCompletionDate?has_content>
          ${productionRunTask.estimatedCompletionDate?string("yyyy-MM-dd HH:mm:ss")}
        </#if>
      </td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskEstimatedSetupMillis}</td>
      <td>
        <#assign setupHours = ((productionRunTask.estimatedSetupMillis)!0)?number / 3600000>
        <#assign setupMinutes = (((productionRunTask.estimatedSetupMillis)!0)?number % 3600000) / 60000>
       <b>Hours</b> <input type="number" style="width:100px;" id="estimatedSetupHours" size="10" name="estimatedSetupHours" value="${setupHours?int}" min="0" placeholder="Hours" />
       <b>Minutes</b> <input type="number" style="width:100px;" id="estimatedSetupMinutes" size="10" name="estimatedSetupMinutes" value="${setupMinutes?int}" min="0" max="59" placeholder="Minutes" />
      </td>
    </tr>
    <tr>
      <td align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskEstimatedMilliSeconds}</td>
      <td>
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

