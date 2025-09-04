# SellerPath: Journey Optimization & Tag Diagnostics  

🚀 **Analytics Avenue Project**  

## 📌 Problem Statement  
Improve seller enrollment rates by identifying **funnel gaps** (impressions → clicks → enrollments) using tracking data, seller metadata, and ingestion events.  

---

## 🔄 Project Flow  

1. **Data Ingestion & Preprocessing**  
   - Load datasets (`impressions`, `clicks`, `enrolled`, `platform`, `category`, etc.)  
   - Clean inconsistencies in tagging fields (e.g., `optin_cta_tagged`, `impression_tag_valid`)  

2. **Funnel Drop-off Analysis**  
   - Define funnel: *Impressions → Clicks → Enrollments*  
   - Analyze drop-offs across `platform`, `category`, `kind`, and `manual_file_ingested`  

3. **Tag Validation Check**  
   - Detect invalid tags (`optin_cta_tagged = No`, `impression_tag_valid = No`)  
   - Identify patterns of tagging failures  

4. **Seller Behavior Insights**  
   - Correlate `seller_tenure_months` with conversion  
   - Assess `risk_rating` impact on enrollments  
   - Discover top `product_opted` across seller types  

5. **Power BI Dashboard**  
   Includes:  
   - 📊 Funnel view: *Impressions → Clicks → Enrolled*  
   - 📉 Daily trend analysis (click/enroll drop-offs)  
   - 🧮 Filters: platform, category, region, kind, campaign_id  
   - ⚠️ Error flags for invalid tags  

6. **Business Impact Measurement**  
   - Highlight conversion gaps  
   - Recommend fixes:  
     - Engineering fixes for invalid tags  
     - UI audits for low-CTA categories  
     - Strategy for manual ingestion sellers  
