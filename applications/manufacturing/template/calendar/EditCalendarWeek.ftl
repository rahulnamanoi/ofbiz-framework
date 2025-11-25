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
function convertCapacityToMilliseconds() {
  // Convert Monday capacity
  var mondayHours = parseInt(document.getElementById('mondayCapacityHours').value) || 0;
  var mondayMinutes = parseInt(document.getElementById('mondayCapacityMinutes').value) || 0;
  document.getElementById('hiddenMondayCapacity').value = (mondayHours * 3600000) + (mondayMinutes * 60000);

  // Convert Tuesday capacity
  var tuesdayHours = parseInt(document.getElementById('tuesdayCapacityHours').value) || 0;
  var tuesdayMinutes = parseInt(document.getElementById('tuesdayCapacityMinutes').value) || 0;
  document.getElementById('hiddenTuesdayCapacity').value = (tuesdayHours * 3600000) + (tuesdayMinutes * 60000);

  // Convert Wednesday capacity
  var wednesdayHours = parseInt(document.getElementById('wednesdayCapacityHours').value) || 0;
  var wednesdayMinutes = parseInt(document.getElementById('wednesdayCapacityMinutes').value) || 0;
  document.getElementById('hiddenWednesdayCapacity').value = (wednesdayHours * 3600000) + (wednesdayMinutes * 60000);

  // Convert Thursday capacity
  var thursdayHours = parseInt(document.getElementById('thursdayCapacityHours').value) || 0;
  var thursdayMinutes = parseInt(document.getElementById('thursdayCapacityMinutes').value) || 0;
  document.getElementById('hiddenThursdayCapacity').value = (thursdayHours * 3600000) + (thursdayMinutes * 60000);

  // Convert Friday capacity
  var fridayHours = parseInt(document.getElementById('fridayCapacityHours').value) || 0;
  var fridayMinutes = parseInt(document.getElementById('fridayCapacityMinutes').value) || 0;
  document.getElementById('hiddenFridayCapacity').value = (fridayHours * 3600000) + (fridayMinutes * 60000);

  // Convert Saturday capacity
  var saturdayHours = parseInt(document.getElementById('saturdayCapacityHours').value) || 0;
  var saturdayMinutes = parseInt(document.getElementById('saturdayCapacityMinutes').value) || 0;
  document.getElementById('hiddenSaturdayCapacity').value = (saturdayHours * 3600000) + (saturdayMinutes * 60000);

  // Convert Sunday capacity
  var sundayHours = parseInt(document.getElementById('sundayCapacityHours').value) || 0;
  var sundayMinutes = parseInt(document.getElementById('sundayCapacityMinutes').value) || 0;
  document.getElementById('hiddenSundayCapacity').value = (sundayHours * 3600000) + (sundayMinutes * 60000);

  return true;
}
</script>

<#if calendarWeek?has_content>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ManufacturingUpdateCalendarWeek}</li>
    </ul>
    <br class="clear"/>
  </div>
  <div class="screenlet-body">
  <form name="calendarweekform" method="post" action="<@ofbizUrl>updateCalendarWeek</@ofbizUrl>" onsubmit="return convertCapacityToMilliseconds();">
    <input type="hidden" name="calendarWeekId" value="${calendarWeek.calendarWeekId}" />
    <input type="hidden" name="calendarId" value="${calendarWeek.calendarId}" />

    <!-- Hidden fields for capacity in milliseconds -->
    <input type="hidden" id="hiddenMondayCapacity" name="mondayCapacity" />
    <input type="hidden" id="hiddenTuesdayCapacity" name="tuesdayCapacity" />
    <input type="hidden" id="hiddenWednesdayCapacity" name="wednesdayCapacity" />
    <input type="hidden" id="hiddenThursdayCapacity" name="thursdayCapacity" />
    <input type="hidden" id="hiddenFridayCapacity" name="fridayCapacity" />
    <input type="hidden" id="hiddenSaturdayCapacity" name="saturdayCapacity" />
    <input type="hidden" id="hiddenSundayCapacity" name="sundayCapacity" />
<#else>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ManufacturingNewCalendarWeek}</li>
    </ul>
    <br class="clear"/>
  </div>
  <div class="screenlet-body">
  <form name="calendarweekform" method="post" action="<@ofbizUrl>createCalendarWeek</@ofbizUrl>" onsubmit="return convertCapacityToMilliseconds();">
    <input type="hidden" name="calendarId" value="${parameters.calendarId!}" />

    <!-- Hidden fields for capacity in milliseconds -->
    <input type="hidden" id="hiddenMondayCapacity" name="mondayCapacity" />
    <input type="hidden" id="hiddenTuesdayCapacity" name="tuesdayCapacity" />
    <input type="hidden" id="hiddenWednesdayCapacity" name="wednesdayCapacity" />
    <input type="hidden" id="hiddenThursdayCapacity" name="thursdayCapacity" />
    <input type="hidden" id="hiddenFridayCapacity" name="fridayCapacity" />
    <input type="hidden" id="hiddenSaturdayCapacity" name="saturdayCapacity" />
    <input type="hidden" id="hiddenSundayCapacity" name="sundayCapacity" />
</#if>

<table class="basic-table" cellpadding='2' cellspacing='0' border='0'>
  <#if calendarWeek?has_content>
    <tr>
      <td width='15%' align='right' valign='top' class="label">${uiLabelMap.ManufacturingCalendarWeekId}*</td>
      <td width="1%">&nbsp;</td>
      <td colspan="4">
        ${calendarWeek.calendarWeekId}
      </td>
    </tr>
  </#if>

  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.CommonDescription}</td>
    <td width="1%">&nbsp;</td>
    <td colspan="4">
      <input type="text" name="description" size="30" maxlength="100" value="${(calendarWeek.description)!}"/>
    </td>
  </tr>

  <!-- Monday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_mondayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="mondayStartTime" value="${(calendarWeek.mondayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_mondayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign mondayHours = ((calendarWeek.mondayCapacity)!0)?number / 3600000>
      <#assign mondayMinutes = (((calendarWeek.mondayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="mondayCapacityHours" size="6" name="mondayCapacityHours" value="${mondayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="mondayCapacityMinutes" size="6" name="mondayCapacityMinutes" value="${mondayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <!-- Tuesday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_tuesdayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="tuesdayStartTime" value="${(calendarWeek.tuesdayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_tuesdayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign tuesdayHours = ((calendarWeek.tuesdayCapacity)!0)?number / 3600000>
      <#assign tuesdayMinutes = (((calendarWeek.tuesdayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="tuesdayCapacityHours" size="6" name="tuesdayCapacityHours" value="${tuesdayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="tuesdayCapacityMinutes" size="6" name="tuesdayCapacityMinutes" value="${tuesdayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <!-- Wednesday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_wednesdayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="wednesdayStartTime" value="${(calendarWeek.wednesdayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_wednesdayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign wednesdayHours = ((calendarWeek.wednesdayCapacity)!0)?number / 3600000>
      <#assign wednesdayMinutes = (((calendarWeek.wednesdayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="wednesdayCapacityHours" size="6" name="wednesdayCapacityHours" value="${wednesdayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="wednesdayCapacityMinutes" size="6" name="wednesdayCapacityMinutes" value="${wednesdayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <!-- Thursday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_thursdayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="thursdayStartTime" value="${(calendarWeek.thursdayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_thursdayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign thursdayHours = ((calendarWeek.thursdayCapacity)!0)?number / 3600000>
      <#assign thursdayMinutes = (((calendarWeek.thursdayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="thursdayCapacityHours" size="6" name="thursdayCapacityHours" value="${thursdayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="thursdayCapacityMinutes" size="6" name="thursdayCapacityMinutes" value="${thursdayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <!-- Friday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_fridayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="fridayStartTime" value="${(calendarWeek.fridayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_fridayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign fridayHours = ((calendarWeek.fridayCapacity)!0)?number / 3600000>
      <#assign fridayMinutes = (((calendarWeek.fridayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="fridayCapacityHours" size="6" name="fridayCapacityHours" value="${fridayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="fridayCapacityMinutes" size="6" name="fridayCapacityMinutes" value="${fridayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <!-- Saturday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_saturdayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="saturdayStartTime" value="${(calendarWeek.saturdayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_saturdayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign saturdayHours = ((calendarWeek.saturdayCapacity)!0)?number / 3600000>
      <#assign saturdayMinutes = (((calendarWeek.saturdayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="saturdayCapacityHours" size="6" name="saturdayCapacityHours" value="${saturdayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="saturdayCapacityMinutes" size="6" name="saturdayCapacityMinutes" value="${saturdayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <!-- Sunday -->
  <tr>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_sundayStartTime}</td>
    <td width="1%">&nbsp;</td>
    <td width="15%">
      <input type="time" name="sundayStartTime" value="${(calendarWeek.sundayStartTime)!}"/>
    </td>
    <td width='15%' align='right' valign='top' class="label">${uiLabelMap.FormFieldTitle_sundayCapacity}</td>
    <td width="1%">&nbsp;</td>
    <td width="53%">
      <#assign sundayHours = ((calendarWeek.sundayCapacity)!0)?number / 3600000>
      <#assign sundayMinutes = (((calendarWeek.sundayCapacity)!0)?number % 3600000) / 60000>
      <b>Hours</b> <input type="number" style="width:70px;" id="sundayCapacityHours" size="6" name="sundayCapacityHours" value="${sundayHours?floor}" min="0" placeholder="Hours" />
      <b>Minutes</b> <input type="number" style="width:70px;" id="sundayCapacityMinutes" size="6" name="sundayCapacityMinutes" value="${sundayMinutes?floor}" min="0" max="59" placeholder="Minutes" />
    </td>
  </tr>

  <tr>
    <td width='15%'>&nbsp;</td>
    <td width="1%">&nbsp;</td>
    <td colspan="4">
      <input type="submit" value="${uiLabelMap.CommonSubmit}"/>
    </td>
  </tr>
</table>
</form>
</div>
</div>