CREATE TEMPORARY TABLE TempTotalClaim AS
SELECT
  c.Subscriber_ID,
  c.Group_ID,
  SUM(cd.Billed_Price) AS Total_Claim_Amount
From
  Claim c
JOIN
  ClaimDetail cd ON c.Claim_Number = cd.Claim_Number
GROUP BY 
  c.Subscriber_ID, c.Group_ID


SELECT
    tc.Subscriber_ID,
    tc.Group_ID,
    tc.Total_Claim_Amount,
    (tc.Total_Claim_Amount - rc.Specific_Deductible) AS Amount_Exceeding,
    (tc.Total_Claim_Amount / rc.Specific_Deductible) * 100 AS Percentage_Exceeding
FROM 
  TempTotalClaim tc 
JOIN 
  ReinsContract rc ON tc.Group_ID = rc.Group_ID AND tc.Subscriber_ID = rc.Subscriber_ID
WHERE
  tc.Total_Claim_Amount > rc.Specific_Deductible

DROP TABLE TempTotalClaim;