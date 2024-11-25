## Task

Using the provided SQL table schemas (`Claim`, `ClaimDetail`, and `ReinsContract`), write a single SQL query to identify subscribers who have exceeded their specific reinsurance deductible and are eligible for reimbursement.

### **Health Insurance Terminology**
- **Reinsurance Deductible**: This is the amount of loss that the primary insurer must cover before reinsurance kicks in. In other words, it's the threshold that must be met before the reinsurer becomes liable for part of the loss.
- **Specific Deductible**: A specific deductible applies to individual claims, meaning the policyholder must pay a set amount out-of-pocket for each claim before the insurance coverage begins to pay. It’s often used in health, auto, and property insurance.
- **Claim**: A request made by an insured party to an insurance company for coverage or compensation for a covered event or loss. The claim process involves the policyholder submitting documentation for evaluation and reimbursement.
- **Subscriber**: In insurance, a subscriber is the individual or entity who enrolls in an insurance plan (e.g., health insurance). They are the primary insured person, often responsible for paying premiums, and may also be the policyholder in some cases.
- **Claim Identification**: Columns like `Claim_Number`, `Claim_ID`, and `Batch_Number` are likely used for unique identification and grouping of claims.
- **Patient Information**: Fields like `Subscriber_ID`, `Member_Seq`, `Group_ID`, `Patient_Signature`, and Patient_Relationship capture patient-specific and subscriber details.
- **Service Details**: Columns like `Service_Date`, `Service_Thru`, `Admission_Date`, `D`ischarge_Date`, and `Procedure_Code` manage information about the healthcare services provided.
- **Insurance and Payment Data**: Columns such as `Other_Insurance`, `Plan_ID`, `Payor_ID`, `Refund_Funding_Key`, `Payment_Status`, and `Check_Number` pertain to financial aspects and insurance processing.
- **Medical Details**: `Diagnostic_Code1` through Diagnostic_Code24 and related fields, like EPSDT_Condition_Indicator and `Principal_Procedure_Code`, detail medical diagnoses and treatments.
- **Dates for Events**: Numerous datetime fields (`Received_Date`, `Admission_Date`, `Processed_Date`, `Accident_Date`, etc.) capture critical timestamps in the claim's lifecycle.
- **Audit and Metadata**: Fields like `Entry_Date`, `Entry_User`, `Update_Date`, and `Update_User` likely track who created or modified records and when.
- **Miscellaneous and Specialized Data**: Columns like `Ambulance_PickUp_Location` and `Prosthesis_Replacement` provide information specific to certain claims.

## Task
Using the provided SQL table schemas (Claim, ClaimDetail, and ReinsContract), write a SQL query that identifies subscribers who have exceeded their specific reinsurance deductible and are eligible for reimbursement. The query will join the tables, calculate the total claim amount, and determine whether the subscriber's claims exceed the deductible.

### Approach
- Step 1: Understanding the Tables
   To complete this task, we need to work with the following tables:

   Claim Table:
      This table contains information about claims made by subscribers. It includes fields such as Claim_Number, Subscriber_ID, and Group_ID.
      Key field for join: Claim_Number

   ClaimDetail Table:
      This table stores individual claim items with their billed prices. It is related to the Claim table via the Claim_Number.
      Key field for join: Claim_Number

   ReinsContract Table:
      This table holds the reinsurance contract details for each subscriber, including the Specific_Deductible for a particular Subscriber_ID and Group_ID.
      Key fields for join: Subscriber_ID, Group_ID

- Step 2: Using SQL Query to Join the Tables
   We need to join the Claim, ClaimDetail, and ReinsContract tables.

   Step 2.1: First, we calculate the Total Claim Amount for each subscriber. We achieve this by summing the Billed_Price from the ClaimDetail table for each subscriber (identified by Subscriber_ID and Group_ID).

   Step 2.2: Then, we join the TotalClaim (which is a derived table or Common Table Expression, CTE) with the ReinsContract table to match the subscriber’s and group’s Specific_Deductible.

   Step 2.3: Finally, we calculate:

   Amount Exceeding the deductible (the difference between the total claim amount and the deductible).
   Percentage Exceeding the deductible (the ratio of the total claim amount to the deductible, multiplied by 100).
- Step 3: Calculating the Breach and Filtering Results
   We filter the results to include only the subscribers whose total claim amount exceeds their Specific_Deductible. The conditions are:

   **Amount Exceeding is calculated as**:

   Amount_Exceeding = Total_Claim_Amount - Specific_Deductible
   Percentage Exceeding is calculated as:

   Percentage_Exceeding = (Total_Claim_Amount / Specific_Deductible) * 100
   The result includes:
   
   **Output Format**
   Subscriber_ID
   Group_ID
   Total Claim Amount
   Amount Exceeding the Deductible
   Percentage Exceeding