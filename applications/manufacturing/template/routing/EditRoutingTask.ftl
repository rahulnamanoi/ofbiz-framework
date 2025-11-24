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

<#if routingTask?has_content>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ManufacturingUpdateRoutingTask}</li>
    </ul>
    <br class="clear"/>
  </div>
  <div class="screenlet-body">
  <form name="routingtaskform" method="post" action="<@ofbizUrl>UpdateRoutingTask</@ofbizUrl>">
    <input type="hidden" name="workEffortId" value="${routingTask.workEffortId}" />
<#else>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ManufacturingCreateRoutingTask}</li>
    </ul>
    <br class="clear"/>
  </div>
  <div class="screenlet-body">
  <form name="routingtaskform" method="post" action="<@ofbizUrl>CreateRoutingTask</@ofbizUrl>">
    <input type="hidden" name="workEffortTypeId" value="ROU_TASK" />
    <input type="hidden" name="currentStatusId" value="ROU_ACTIVE" />
</#if>
  <table class="basic-table" cellspacing="0">
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskName}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="40" name="workEffortName" value="${(routingTask.workEffortName)!}" required="required" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskPurpose}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <select name="workEffortPurposeTypeId">
          <option value="">${uiLabelMap.CommonSelectOne}</option>
          <#if workEffortPurposeTypes?has_content>
            <#list workEffortPurposeTypes as workEffortPurposeType>
              <option value="${workEffortPurposeType.workEffortPurposeTypeId}" <#if (routingTask?has_content && routingTask.workEffortPurposeTypeId?default("") == workEffortPurposeType.workEffortPurposeTypeId)>selected</#if>>${workEffortPurposeType.description!}</option>
            </#list>
          </#if>
        </select>
      </td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.CommonDescription}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><textarea cols="60" rows="4" name="description">${(routingTask.description)!}</textarea></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingFixedAsset}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <select name="fixedAssetId">
          <option value="">${uiLabelMap.CommonSelectOne}</option>
          <#if fixedAssets?has_content>
            <#list fixedAssets as fixedAsset>
              <option value="${fixedAsset.fixedAssetId}" <#if (routingTask?has_content && routingTask.fixedAssetId?default("") == fixedAsset.fixedAssetId)>selected</#if>>${fixedAsset.fixedAssetName!} [${fixedAsset.fixedAssetId}]</option>
            </#list>
          </#if>
        </select>
      </td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskEstimatedSetupMillis}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="20" name="estimatedSetupMillis" value="${(routingTask.estimatedSetupMillis)!}" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingTaskEstimatedMilliSeconds}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="20" name="estimatedMilliSeconds" value="${(routingTask.estimatedMilliSeconds)!}" /></td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingEstimateCalcMethod}</td>
      <td width="5">&nbsp;</td>
      <td width="74%">
        <select name="estimateCalcMethod">
          <option value="">${uiLabelMap.CommonSelectOne}</option>
          <#if customMethods?has_content>
            <#list customMethods as customMethod>
              <option value="${customMethod.customMethodId}" <#if (routingTask?has_content && routingTask.estimateCalcMethod?default("") == customMethod.customMethodId)>selected</#if>>${customMethod.customMethodId!}</option>
            </#list>
          </#if>
        </select>
      </td>
    </tr>
    <tr>
      <td width='26%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingReservePersons}</td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="text" size="20" name="reservPersons" value="${(routingTask.reservPersons)!}" /></td>
    </tr>
    <tr>
      <td width="26%" align="right" valign="top"></td>
      <td width="5">&nbsp;</td>
      <td width="74%"><input type="submit" value="${uiLabelMap.CommonSubmit}" /></td>
    </tr>
  </table>
  </form>
  </div>
</div>

