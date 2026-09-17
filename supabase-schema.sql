-- Yojana Mitra — Supabase (Postgres) schema
-- Run this in Supabase Dashboard → SQL Editor → New query

create table if not exists schemes (
  id bigint generated always as identity primary key,
  name text not null,
  category text not null,
  description text not null,
  benefits text not null,
  eligibility_min_age int default 0,
  eligibility_max_age int default 100,
  eligibility_income_max int,                 -- null = no income cap
  eligibility_occupation text default 'any',   -- farmer, student, unemployed, any, etc.
  eligibility_gender text default 'any',       -- male, female, any
  eligibility_state text default 'all',        -- 'all' or specific state
  apply_link text not null,
  keywords text not null                       -- comma-separated, used for keyword matching
);

-- Enable Row Level Security, then allow anonymous read-only access
-- (this app only ever reads scheme data — no writes from the client)
alter table schemes enable row level security;

create policy "Public read access"
  on schemes for select
  using (true);

-- Seed data: starter set of high-impact, well-known schemes
insert into schemes (name, category, description, benefits, eligibility_min_age, eligibility_max_age, eligibility_income_max, eligibility_occupation, eligibility_gender, eligibility_state, apply_link, keywords) values
('PM-KISAN', 'Agriculture', 'Income support scheme for landholding farmer families across India.', '₹6,000 per year in 3 equal installments directly to bank account.', 18, 100, null, 'farmer', 'any', 'all', 'https://pmkisan.gov.in', 'farmer,farming,kisan,agriculture,income support,crop'),

('Ayushman Bharat (PM-JAY)', 'Health', 'Health insurance scheme providing free treatment for poor and vulnerable families.', 'Health cover up to ₹5 lakh per family per year for secondary and tertiary hospitalization.', 0, 100, 250000, 'any', 'any', 'all', 'https://pmjay.gov.in', 'health,hospital,insurance,medical,treatment,ayushman'),

('PM Awas Yojana (PMAY)', 'Housing', 'Housing scheme to provide affordable housing to urban and rural poor.', 'Financial assistance/subsidy for construction or purchase of a house.', 18, 100, 300000, 'any', 'any', 'all', 'https://pmaymis.gov.in', 'house,housing,home,awas,shelter'),

('National Scholarship Portal Schemes', 'Education', 'Umbrella of scholarships for students from pre-matric to post-graduate level.', 'Financial assistance ranging from a few thousand to lakhs of rupees depending on scheme.', 5, 30, 800000, 'student', 'any', 'all', 'https://scholarships.gov.in', 'scholarship,student,education,study,fees,college,school'),

('MGNREGA', 'Employment', 'Guarantees 100 days of wage employment per year to rural households.', 'Guaranteed wage employment; minimum wages as per state rates.', 18, 100, null, 'unemployed', 'any', 'all', 'https://nrega.nic.in', 'job,employment,work,wage,rural,unemployed,mgnrega'),

('PM Ujjwala Yojana', 'Welfare', 'Provides LPG connections to women from below-poverty-line households.', 'Free LPG gas connection with financial support for first refill and stove.', 18, 100, 100000, 'any', 'female', 'all', 'https://pmuy.gov.in', 'gas,lpg,ujjwala,cooking,women,kitchen'),

('Sukanya Samriddhi Yojana', 'Welfare', 'Savings scheme for the girl child to secure her education and marriage expenses.', 'High interest rate savings account; tax benefits under Section 80C.', 0, 10, null, 'any', 'female', 'all', 'https://www.nsiindia.gov.in', 'girl child,savings,sukanya,daughter,education fund'),

('Pradhan Mantri Mudra Yojana', 'Employment', 'Loans up to ₹10 lakh to non-corporate, non-farm small/micro enterprises.', 'Collateral-free loans for starting or expanding a small business.', 18, 100, null, 'self-employed', 'any', 'all', 'https://www.mudra.org.in', 'loan,business,mudra,startup,self employed,entrepreneur'),

('Atal Pension Yojana', 'Welfare', 'Pension scheme aimed at unorganized sector workers.', 'Guaranteed minimum pension of ₹1,000 to ₹5,000 per month after age 60.', 18, 40, null, 'unorganized worker', 'any', 'all', 'https://npscra.nsdl.co.in/scheme-details.php', 'pension,retirement,old age,atal,unorganized sector'),

('PM Fasal Bima Yojana', 'Agriculture', 'Crop insurance scheme protecting farmers against crop loss/damage.', 'Insurance cover and financial support in case of crop failure due to natural calamities.', 18, 100, null, 'farmer', 'any', 'all', 'https://pmfby.gov.in', 'crop insurance,fasal bima,farmer,crop loss,drought,flood');
