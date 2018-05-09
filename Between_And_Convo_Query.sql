--Conversantion and tolarance query

Select [PMG_MATNR]
      ,[FAMS_MATNR]
      ,[FAPJ_MATNR]
      ,[FEMEA_MATNR]
      ,[Pxx_MATNR]
      ,[VEL_MATNR]
      ,[PMG_BRGEW]
      ,[PMG_GEWEI]
	  ,[FAMS_BRGEW]
      ,[FAMS_GEWEI]
	  ,[PMG_KG]
	  ,[AMS_KG]
	  ,[PMGvsAMS(D)]
	  ,[PMGvsAMS]

from [dbo].[MM_Weight_Unit_Comparision] where [PMGvsAMS] = 'FALSE' --AND [PMGvsAMS(D)] BETWEEN cast(-2 as float) AND cast(+2 as float)


ALTER TABLE [dbo].[MM_Weight_Unit_Comparision] ADD [PMGvsAMS(Diff)] VARCHAR(10);

Update [dbo].[MM_Weight_Unit_Comparision] 
Set [PMGvsAMS(D)] = cast([PMG_KG] as float)-cast([AMS_KG] as float)
from [dbo].[MM_Weight_Unit_Comparision] 

Update [dbo].[MM_Weight_Unit_Comparision] 
Set  [AMSvsEMEA] = CASE WHEN AMS_KG=EMEA_KG THEN CASE WHEN AMS_KG='99999.000000' and EMEA_KG='99999.000000' THEN 'VB-(AMS & EMEA)' ELSE 'TRUE' END 
ELSE CASE WHEN AMS_KG IS NULL and EMEA_KG IS NULL THEN 'NA-(AMS & EMEA)' 
ELSE CASE WHEN AMS_KG IS NULL THEN 'NA-(AMS)' WHEN EMEA_KG IS NULL THEN 'NA-(EMEA)' WHEN AMS_KG='99999.000000' THEN 'VB-(AMS)' WHEN EMEA_KG='99999.000000' THEN 'VB-(EMEA)'
ELSE CASE WHEN cast(AMS_KG as float)-cast(EMEA_KG as float) BETWEEN cast(-1 as float) AND cast(+1 as float) THEN 'Tol_in_1'
ELSE CASE WHEN cast(AMS_KG as float)-cast(EMEA_KG as float) BETWEEN cast(-2 as float) AND cast(+2 as float) THEN 'Tol_in_2' ELSE 'FALSE' END END END END END
from [dbo].[MM_Weight_Unit_Comparision] 


Select [PMGvsAMS(D)],Count(*)
From [dbo].[MM_Weight_Unit_Comparision] group by [PMGvsAMS(D)]


Select SUBSTRING(PH_WEB_PL,2,2)
from [dbo].[Division_Comparision]