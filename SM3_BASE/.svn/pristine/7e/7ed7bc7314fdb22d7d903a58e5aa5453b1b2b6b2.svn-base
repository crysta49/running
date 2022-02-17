SELECT A1.TABLE_COMMENTS
           , A1.TABLE_NAME
           , A1.COLUMN_ID
           , A1.COLUMN_NAME
           , A1.COLUMN_COMMENTS
           , A1.DATA_TYPE
           , (CASE WHEN B1.CONSTRAINT_TYPE = 'P' THEN 'PK' END) PK_FLAG   
           , (CASE A1.DATA_TYPE WHEN 'NUMBER' THEN TO_CHAR(A1.DATA_LENGTH)
                                              WHEN 'DATE'   THEN ' ' 
                                              ELSE TO_CHAR(A1.DATA_LENGTH) END) AS DATA_LENGTH
           , NVL(A1.NULL_FLAG, 'N') AS NULL_FLAG   
  FROM (SELECT B.COMMENTS TABLE_COMMENTS
                        , A.TABLE_NAME TABLE_NAME
                        , C.COMMENTS COLUMN_COMMENTS
                        , A.COLUMN_NAME COLUMN_NAME
                        , (CASE A.NULLABLE WHEN 'Y' THEN 'Y' END) NULL_FLAG
                        , A.DATA_TYPE DATA_TYPE
                        , A.DATA_LENGTH 
                        , A.COLUMN_ID AS COLUMN_ID
                        , A.DATA_PRECISION
               FROM USER_TAB_COLUMNS A
                       , USER_TAB_COMMENTS B
                       , USER_COL_COMMENTS C
             WHERE (A.TABLE_NAME = B.TABLE_NAME)
                 AND (      A.TABLE_NAME = C.TABLE_NAME
                        AND A.COLUMN_NAME = C.COLUMN_NAME
                        )
                 AND B.TABLE_TYPE = 'TABLE') A1
           , (SELECT A.TABLE_NAME
                         , A.COLUMN_NAME
                         , B.CONSTRAINT_TYPE
                 FROM USER_CONS_COLUMNS A
                         , USER_CONSTRAINTS B
               WHERE (A.CONSTRAINT_NAME = B.CONSTRAINT_NAME)
                    AND B.CONSTRAINT_TYPE IN ('P', 'R')) B1
WHERE (    A1.TABLE_NAME = B1.TABLE_NAME(+)
     AND A1.COLUMN_NAME = B1.COLUMN_NAME(+))
ORDER BY A1.TABLE_NAME, A1.COLUMN_ID