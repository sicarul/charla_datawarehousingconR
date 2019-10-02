library(RPostgres)
library(tidyverse)
library(dbplyr)

conn = dbConnect(RPostgres::Postgres(), dbname='dwh', host='localhost', port=54320, user='postgres', password='dwh')

stripe_charges = tbl(conn, 'stripe_charges')
stripe_customers = tbl(conn, 'stripe_customers')

#monthly_charges
amount_and_charge_date = stripe_charges %>%
  select(amount, created)

transformed_date = amount_and_charge_date %>%
  mutate(created_at = sql('to_timestamp( TRUNC( CAST( created AS bigint ) ) )'))

truncated_date = transformed_date %>%
  mutate(created_month = date_trunc('month', created_at))

show_query(truncated_date)

monthly_charges = truncated_date %>%
  group_by(created_month) %>%
  summarize(amount=sum(amount, na.rm=T)) %>%
  arrange(desc(created_month))

monthly_charges_df = collect(monthly_charges)

dbWriteTable(conn, 'monhtly_charges', monthly_charges_df)
