# MS-7 Production Run Tasks - Hours/Minutes Display Update

## Summary
Updated the Production Run Tasks screens to display time values in hours and minutes format instead of milliseconds, similar to the changes made in EditRoutingTask.ftl and EditCalendarWeek.ftl.

## Files Changed

### 1. ProductionRunForms.xml
**Location:** `applications/manufacturing/widget/manufacturing/ProductionRunForms.xml`

**Changes Made:**

#### a) ViewListProductionRunRoutingTasks Grid (Lines ~192-210)
- Added row-actions to convert milliseconds to hours and minutes
- Updated `estimatedSetupMillis` field to display as "Xh Ym" format
- Updated `estimatedTotalMilliSeconds` field to display as "Xh Ym" format

```xml
<row-actions>
    <set field="estimatedTotalMilliSeconds" value="${groovy:estimatedMilliSeconds * quantity}" type="BigDecimal"/>
    <set field="estimatedSetupHours" value="${groovy: (estimatedSetupMillis ?: 0) / 3600000}" type="Integer"/>
    <set field="estimatedSetupMinutes" value="${groovy: ((estimatedSetupMillis ?: 0) % 3600000) / 60000}" type="Integer"/>
    <set field="estimatedTotalHours" value="${groovy: (estimatedTotalMilliSeconds ?: 0) / 3600000}" type="Integer"/>
    <set field="estimatedTotalMinutes" value="${groovy: ((estimatedTotalMilliSeconds ?: 0) % 3600000) / 60000}" type="Integer"/>
</row-actions>
```

#### b) ListProductionRunRoutingTasks Grid (Lines ~211-249)
- Added same row-actions as ViewListProductionRunRoutingTasks
- Updated display format for estimated setup and total time

#### c) ListProductionRunDeclRoutingTasks Grid (Lines ~373-428)
- Added row-actions to convert actual milliseconds to hours and minutes
- Updated `actualSetupMillis` field to display as "Xh Ym" format
- Updated `actualMilliSeconds` field to display as "Xh Ym" format

```xml
<row-actions>
    <set field="actualSetupHours" value="${groovy: (actualSetupMillis ?: 0) / 3600000}" type="Integer"/>
    <set field="actualSetupMinutes" value="${groovy: ((actualSetupMillis ?: 0) % 3600000) / 60000}" type="Integer"/>
    <set field="actualRunHours" value="${groovy: (actualMilliSeconds ?: 0) / 3600000}" type="Integer"/>
    <set field="actualRunMinutes" value="${groovy: ((actualMilliSeconds ?: 0) % 3600000) / 60000}" type="Integer"/>
</row-actions>
```

### 2. JobshopScreens.xml
**Location:** `applications/manufacturing/widget/manufacturing/JobshopScreens.xml`

**Changes Made:**

#### ProductionRunTasks Screen (Lines ~470-472)
- Replaced `include-form` with `html-template` to use the new FTL file
- This allows for custom JavaScript-based hour/minute input handling

```xml
<!-- BEFORE -->
<include-form name="EditProductionRunRoutingTask" location="component://manufacturing/widget/manufacturing/ProductionRunForms.xml"/>

<!-- AFTER -->
<html><html-template location="component://manufacturing/template/jobshopmgt/EditProductionRunRoutingTask.ftl"/></html>
```

### 3. EditProductionRunRoutingTask.ftl (NEW FILE)
**Location:** `applications/manufacturing/template/jobshopmgt/EditProductionRunRoutingTask.ftl`

**Purpose:**
Custom FTL template for editing production run routing tasks with hours/minutes input fields.

**Features:**
- JavaScript function `convertTimeToMilliseconds()` to convert user input (hours/minutes) to milliseconds before form submission
- Separate input fields for:
  - Estimated Setup Time: Hours and Minutes
  - Estimated Run Time: Hours and Minutes
- Hidden fields to store the converted millisecond values
- Supports both create and update modes
- Automatically converts existing millisecond values to hours/minutes for display

**Key JavaScript Logic:**
```javascript
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
```

### 4. ProductionRunTasksList.ftl (NEW FILE)
**Location:** `applications/manufacturing/template/jobshopmgt/ProductionRunTasksList.ftl`

**Purpose:**
Custom FTL template for displaying production run tasks list with hours/minutes format.

**Features:**
- Macro `convertMillisToHoursMinutes` to convert milliseconds to "Xh Ym" format
- Full table layout with all necessary columns
- Applied to both estimated setup time and estimated total time

## Impact

### User Interface Changes:
1. **Listing Screens:**
   - Estimated Setup Time: Now displays as "Xh Ym" instead of raw milliseconds
   - Estimated Total Run Time: Now displays as "Xh Ym" instead of raw milliseconds
   - Actual Setup Time: Now displays as "Xh Ym" instead of raw milliseconds
   - Actual Run Time: Now displays as "Xh Ym" instead of raw milliseconds

2. **Edit Form:**
   - Users can now input time as separate Hours and Minutes fields
   - More intuitive and user-friendly input
   - Automatic conversion happens on form submission

### Data Storage:
- No changes to backend data storage (still stores as milliseconds)
- All conversions happen at the presentation layer

## Related Commits Referenced:
- `cdf6eb9cf7` - MS-7 Updated Edit Week Section to show minutes hours instead of milliseconds
- `6c71f9fc31` - MS-7 Added FTL For change milliseconds to hour minutes in calendar week screen
- `66b2644f85` - MS-7 Modified EditRouting.ftl to convert hours minutes to milliseconds
- `c6793dd125` - MS-7 Added FTL for EditRoutingTask

## Testing Recommendations:
1. Test viewing production run tasks list - verify hours/minutes display correctly
2. Test creating new production run routing task with hours/minutes input
3. Test editing existing production run routing task - verify values convert correctly
4. Test form submission - ensure milliseconds are saved correctly in database
5. Verify calculation of estimated completion dates still works correctly

