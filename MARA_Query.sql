DROP TABLE [Weight_Unit_Comparision]

Select * INTO [Weight_Unit_Comparision] from

(select Distinct mm.MATNR,
CASE WHEN PMG.SPART IS NULL THEN 'Not Setup' ELSE PMG.SPART END as PL,
CASE WHEN PMG.MTART IS NULL THEN 'Not Setup' ELSE PMG.MTART END as Matl_Type,
CASE WHEN PMG.MSTAE IS NULL THEN 'Not Setup' ELSE PMG.MSTAE END as X_Plant_Status,
CASE WHEN PMGMAKT.MAKTX IS NULL THEN 'Not Setup' ELSE PMGMAKT.MAKTX END as PMG_Desc,
CASE WHEN PMG.GEWEI IS NULL THEN 'Not Setup' ELSE PMG.GEWEI END [Weight_Unit_PMG Value], 
CASE WHEN FAMS.GEWEI IS NULL THEN 'Not Setup' ELSE FAMS.GEWEI END [Weight_Unit_AMS Value],
CASE WHEN FEMEA.GEWEI IS NULL THEN 'Not Setup' ELSE FEMEA.GEWEI END [Weight_Unit_EMEA Value],
CASE WHEN FAPJ.GEWEI IS NULL THEN 'Not Setup' ELSE FAPJ.GEWEI END [Weight_Unit_APJ Value],
CASE WHEN QPC.GEWEI IS NULL THEN 'Not Setup' ELSE QPC.GEWEI END [Weight_Unit_QPC Value],
CASE WHEN VEL.GEWEI IS NULL THEN 'Not Setup' ELSE VEL.GEWEI END [Weight_Unit_VEL Value],


CASE WHEN PMG.GEWEI=FAMS.GEWEI THEN CASE WHEN PMG.GEWEI='' and FAMS.GEWEI='' THEN 'VB-(PMG & AMS)' ELSE 'TRUE' END 
ELSE CASE WHEN PMG.GEWEI IS NULL and FAMS.GEWEI IS NULL THEN 'NA-(PMG & AMS)' 
ELSE CASE WHEN PMG.GEWEI IS NULL THEN 'NA-(PMG)' WHEN FAMS.GEWEI IS NULL THEN 'NA-(AMS)' WHEN PMG.GEWEI='' THEN 'VB-(PMG)' WHEN FAMS.GEWEI='' THEN 'VB-(AMS)' ELSE 'FALSE' END END END
AS [PMG vs AMS],

CASE WHEN PMG.GEWEI=FEMEA.GEWEI THEN CASE WHEN PMG.GEWEI='' and FEMEA.GEWEI='' THEN 'VB-(PMG & EMEA)' ELSE 'TRUE' END 
ELSE CASE WHEN PMG.GEWEI IS NULL and FEMEA.GEWEI IS NULL THEN 'NA-(PMG & EMEA)' 
ELSE CASE WHEN PMG.GEWEI IS NULL THEN 'NA-(PMG)' WHEN FEMEA.GEWEI IS NULL THEN 'NA-(EMEA)' WHEN PMG.GEWEI='' THEN 'VB-(PMG)' WHEN FEMEA.GEWEI='' THEN 'VB-(EMEA)' ELSE 'FALSE' END END END
AS [PMG vs EMEA],

CASE WHEN PMG.GEWEI=FAPJ.GEWEI THEN CASE WHEN PMG.GEWEI='' and FAPJ.GEWEI='' THEN 'VB-(PMG & APJ)' ELSE 'TRUE' END 
ELSE CASE WHEN PMG.GEWEI IS NULL and FAPJ.GEWEI IS NULL THEN 'NA-(PMG & APJ)' 
ELSE CASE WHEN PMG.GEWEI IS NULL THEN 'NA-(PMG)' WHEN FAPJ.GEWEI IS NULL THEN 'NA-(APJ)' WHEN PMG.GEWEI='' THEN 'VB-(PMG)' WHEN FAPJ.GEWEI='' THEN 'VB-(APJ)' ELSE 'FALSE' END END END
AS [PMG vs APJ],

CASE WHEN PMG.GEWEI=QPC.GEWEI THEN CASE WHEN PMG.GEWEI='' and QPC.GEWEI='' THEN 'VB-(PMG & QPC)' ELSE 'TRUE' END 
ELSE CASE WHEN PMG.GEWEI IS NULL and QPC.GEWEI IS NULL THEN 'NA-(PMG & QPC)' 
ELSE CASE WHEN PMG.GEWEI IS NULL THEN 'NA-(PMG)' WHEN QPC.GEWEI IS NULL THEN 'NA-(QPC)' WHEN PMG.GEWEI='' THEN 'VB-(PMG)' WHEN QPC.GEWEI='' THEN 'VB-(QPC)' ELSE 'FALSE' END END END
AS [PMG vs QPC],

CASE WHEN PMG.GEWEI=VEL.GEWEI THEN CASE WHEN PMG.GEWEI='' and VEL.GEWEI='' THEN 'VB-(PMG & VEL)' ELSE 'TRUE' END 
ELSE CASE WHEN PMG.GEWEI IS NULL and VEL.GEWEI IS NULL THEN 'NA-(PMG & VEL)' 
ELSE CASE WHEN PMG.GEWEI IS NULL THEN 'NA-(PMG)' WHEN VEL.GEWEI IS NULL THEN 'NA-(VEL)' WHEN PMG.GEWEI='' THEN 'VB-(PMG)' WHEN VEL.GEWEI='' THEN 'VB-(VEL)' ELSE 'FALSE' END END END
AS [PMG vs VEL],

CASE WHEN FAMS.GEWEI=FEMEA.GEWEI THEN CASE WHEN FAMS.GEWEI='' and FEMEA.GEWEI='' THEN 'VB-(AMS & EMEA)' ELSE 'TRUE' END 
ELSE CASE WHEN FAMS.GEWEI IS NULL and FEMEA.GEWEI IS NULL THEN 'NA-(AMS & EMEA)' 
ELSE CASE WHEN FAMS.GEWEI IS NULL THEN 'NA-(AMS)' WHEN FEMEA.GEWEI IS NULL THEN 'NA-(EMEA)' WHEN FAMS.GEWEI='' THEN 'VB-(AMS)' WHEN FEMEA.GEWEI='' THEN 'VB-(EMEA)' ELSE 'FALSE' END END END
AS [FAMS vs FEMEA]


from (Select MATNR from [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[FAMS_MARA_FINAL] UNION Select MATNR from [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[FAPJ_MARA_FINAL] UNION       Select MATNR from [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[FEMEA_MARA_FINAL] UNION Select MATNR from [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[QPC_MARA_FINAL] UNION Select MATNR from [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[VEL_MARA_FINAL] UNION Select MATNR from [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[PMG_MARA_FINAL] Where [BEGRU] = 'HPE') mm 

left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[PMG_MARA_FINAL] PMG on mm.MATNR = PMG.MATNR
left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[FAMS_MARA_FINAL] FAMS on mm.MATNR = FAMS.MATNR
left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[FAPJ_MARA_FINAL] FAPJ on mm.MATNR = FAPJ.MATNR
left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[FEMEA_MARA_FINAL] FEMEA on mm.MATNR = FEMEA.MATNR
left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[QPC_MARA_FINAL] QPC on mm.MATNR = QPC.MATNR
left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[VEL_MARA_FINAL] VEL on mm.MATNR = VEL.MATNR
left join [hc4w01645.itcs.hpecorp.net,2048].[DM-STAGING].[dbo].[PMG_MAKT_FINAL] PMGMAKT on mm.MATNR = PMGMAKT.MATNR
)n
