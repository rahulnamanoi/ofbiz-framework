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

<#-- Helper macro to convert milliseconds to hours:minutes format -->
<#macro convertMillisToHoursMinutes millis>
  <#if millis?has_content && (millis?number > 0)>
    <#assign hours = (millis?number / 3600000)?floor>
    <#assign minutes = ((millis?number % 3600000) / 60000)?floor>
    ${hours}h ${minutes}m
  <#else>
    0h 0m
  </#if>
</#macro>

<div class="screenlet">
  <div class="screenlet-title-bar">
    <h3>${uiLabelMap.ManufacturingListOfProductionRunRoutingTasks}</h3>
  </div>
  <div class="screenlet-body">
    <table class="basic-table hover-bar" cellspacing="0">
      <thead>
        <tr class="header-row">
          <th>${uiLabelMap.CommonSequenceNum}</th>
          <th>${uiLabelMap.ManufacturingTaskName}</th>
          <th>${uiLabelMap.ManufacturingMachine}</th>
          <th>${uiLabelMap.FormFieldTitle_reservPersons}</th>
          <th>${uiLabelMap.ManufacturingStartDate}</th>
          <th>${uiLabelMap.ManufacturingEstimatedCompletionDate}</th>
          <th>${uiLabelMap.ManufacturingTaskEstimatedSetupMillis}</th>
          <th>${uiLabelMap.ManufacturingTaskEstimatedTotalMilliSeconds}</th>
          <th>&nbsp;</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        <#if productionRunRoutingTasks?has_content>
          <#list productionRunRoutingTasks as task>
            <#assign estimatedTotalMilliSeconds = (task.estimatedMilliSeconds?number * task.quantity?number)>
            <tr class="${(task_index % 2 == 0)?string('', 'alternate-row')}">
              <td>${task.priority!}</td>
              <td>${task.workEffortName!} [${task.workEffortId}]</td>
              <td>${task.fixedAssetId!}</td>
              <td>${task.reservPersons!}</td>
              <td><#if task.estimatedStartDate?has_content>${task.estimatedStartDate?string("yyyy-MM-dd HH:mm:ss")}</#if></td>
              <td><#if task.estimatedCompletionDate?has_content>${task.estimatedCompletionDate?string("yyyy-MM-dd HH:mm:ss")}</#if></td>
              <td><@convertMillisToHoursMinutes millis=task.estimatedSetupMillis!"0" /></td>
              <td><@convertMillisToHoursMinutes millis=estimatedTotalMilliSeconds?string /></td>
              <td>
                <a href="<@ofbizUrl>ProductionRunTasks?routingTaskId=${task.workEffortId}&amp;productionRunId=${task.workEffortParentId}</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonEdit}</a>
              </td>
              <td>
                <a href="<@ofbizUrl>deleteProductionRunRoutingTask?workEffortId=${task.workEffortId}&amp;productionRunId=${task.workEffortParentId}</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonDelete}</a>
              </td>
            </tr>
          </#list>
        <#else>
          <tr>
            <td colspan="10">${uiLabelMap.CommonNoRecordFound}</td>
          </tr>
        </#if>
      </tbody>
    </table>
  </div>
</div>

