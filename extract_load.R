
library(request)
library(dotenv)
library(jsonlite)
library(tidyr)

load_dot_env('.env')

charges = api('https://api.stripe.com/v1/charges') %>%
  api_simple_auth(user = Sys.getenv('STRIPE_KEY'), pwd='') %>%
  http_client()

charges_df = fromJSON(content(charges$body(), 'text'), flatten = T)$data



customers = api('https://api.stripe.com/v1/customers') %>%
  api_simple_auth(user = Sys.getenv('STRIPE_KEY'), pwd='') %>%
  http_client()


customers_df = fromJSON(content(customers$body(), 'text'), flatten = T)$data


library(RPostgres)
conn = dbConnect(RPostgres::Postgres(), dbname='dwh', host='localhost', port=54320, user='postgres', password='dwh')

dbWriteTable(conn,'stripe_charges', charges_df)
dbWriteTable(conn,'stripe_customers', customers_df)
