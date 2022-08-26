SELECT 
  CAST(EM.cod_id AS VARCHAR(20)) AS COD_ID,
    CASE
    WHEN VWEQ.PAC IS NULL
        OR VWEQ.PAC = 0 
        THEN Replace(EM.COD_ID, '0001-', 'DESC-')
    ELSE Cast('BT-' ||VWEQ.PAC AS VARCHAR2(20 byte))
    END AS PAC, 
    CAST(EM.dist AS NUMBER(38, 0)) AS DIST,
    CAST(EM.tip_unid AS VARCHAR2(3 byte))AS TIP_UNID,
    CAST(SUGERE.FAS_CON AS VARCHAR2(4 byte)) AS FAS_CON,
    CAST(EM.tipmed AS NUMBER(38, 0)) AS TIPMED,
    CAST(EM.odi AS VARCHAR2(99 byte)) AS ODI,
    CAST(EM.ti AS VARCHAR2(2 byte)) AS TI,
    CAST(EM.cm AS VARCHAR(3)) AS CM,
    CAST(EM.tuc AS VARCHAR(3)) AS TUC,
    CAST(EM.a1 AS VARCHAR(2)) AS A1,
    CAST(EM.a2 AS VARCHAR(2)) AS A2,
    CAST(EM.a3 AS VARCHAR(2)) AS A3,
    CAST(EM.a4 AS VARCHAR(2)) AS A4,
    CAST(EM.a5 AS VARCHAR(2)) AS A5,
    CAST(EM.a6 AS VARCHAR(2)) AS A6,
    CAST(EM.sitcont AS VARCHAR2(3 byte)) AS SITCONT,
    TO_CHAR(TO_DATE(EM.DAT_IMO, 'DD/MM/RR'), 'DD/MM/YYYY') AS DAT_IMO,
    CAST(EM.descr AS VARCHAR2(255 byte)) AS DESCR
FROM MV_SIGA_EQU_MED EM
LEFT JOIN BDGD_STAGING.MV_GENESIS_EQME VWEQ
ON TO_CHAR(VWEQ.NR_CONTA_CNS) = EM.DESCR 
LEFT JOIN (SELECT
 DISTINCT FEATURE_ID,
          FASE_SUGERIDA AS "FAS_CON"
 FROM BDGD_STAGING.MV_GENESIS_SUGERE_FASE_BT )SUGERE ON SUGERE.FEATURE_ID = VWEQ.RAMAL_LIGACAO