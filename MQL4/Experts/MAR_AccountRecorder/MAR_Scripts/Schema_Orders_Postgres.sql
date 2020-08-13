CREATE TABLE IF NOT EXISTS enum_exn_type (id INTEGER NOT NULL UNIQUE PRIMARY KEY, name TEXT);
INSERT INTO enum_exn_type VALUES (-1, 'Unspecified')  ON CONFLICT DO NOTHING;
INSERT INTO enum_exn_type VALUES (0, 'Other')  ON CONFLICT DO NOTHING;
INSERT INTO enum_exn_type VALUES (1, 'IRC 988(a)(1)(B)')  ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS enum_spt_phase (id INT PRIMARY KEY NOT NULL UNIQUE, name TEXT);
INSERT INTO enum_spt_phase VALUES (-1, 'Unspecified')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_phase VALUES (0, 'Other')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_phase VALUES (1, 'Entry')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_phase VALUES (2, 'Exit')  ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS enum_spt_subtype (id INT PRIMARY KEY NOT NULL UNIQUE, name TEXT);
INSERT INTO enum_spt_subtype VALUES (-1, 'Unspecified')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (0, 'Other')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (1, 'Commission')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (2, 'Swap')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (3, 'Tax')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (4, 'Deposit')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (5, 'Withdrawal')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (6, 'Expense')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_subtype VALUES (7, 'Rebate')  ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS enum_spt_type (id INT PRIMARY KEY NOT NULL UNIQUE, name TEXT);
INSERT INTO enum_spt_type VALUES (-1, 'Unspecified')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_type VALUES (0, 'Other')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_type VALUES (1, 'Gross')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_type VALUES (2, 'Fee')  ON CONFLICT DO NOTHING;
INSERT INTO enum_spt_type VALUES (3, 'Adjustment')  ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS enum_txn_type (id INT PRIMARY KEY NOT NULL UNIQUE, name TEXT);
INSERT INTO enum_txn_type VALUES (-1, 'Unspecified')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (0, 'Long')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (1, 'Short')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (2, 'Buy Limit')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (3, 'Buy Stop')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (4, 'Sell Limit')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (5, 'Sell Stop')  ON CONFLICT DO NOTHING;
INSERT INTO enum_txn_type VALUES (6, 'Balance')  ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS enum_act_mode (id INT PRIMARY KEY UNIQUE NOT NULL, name TEXT);
INSERT INTO enum_act_mode VALUES(-1, 'Unspecified') ON CONFLICT DO NOTHING;
INSERT INTO enum_act_mode VALUES(0, 'Demo') ON CONFLICT DO NOTHING;
INSERT INTO enum_act_mode VALUES(1, 'Contest') ON CONFLICT DO NOTHING;
INSERT INTO enum_act_mode VALUES(2, 'Real') ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS enum_act_margin_so_mode (id INT PRIMARY KEY UNIQUE NOT NULL, name TEXT);
INSERT INTO enum_act_margin_so_mode VALUES(-1, 'Unspecified') ON CONFLICT DO NOTHING;
INSERT INTO enum_act_margin_so_mode VALUES(0, 'Percent') ON CONFLICT DO NOTHING;
INSERT INTO enum_act_margin_so_mode VALUES(1, 'Money') ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS currency (uuid TEXT PRIMARY KEY UNIQUE NOT NULL, name TEXT NOT NULL, fraction NUMERIC NOT NULL DEFAULT (1));

CREATE TABLE IF NOT EXISTS accounts (uuid TEXT PRIMARY KEY UNIQUE NOT NULL, cny_uuid TEXT NOT NULL, num INT NOT NULL, mode INT, name TEXT, server TEXT, company TEXT);

CREATE TABLE IF NOT EXISTS elections (uuid TEXT PRIMARY KEY UNIQUE NOT NULL, txn_uuid TEXT NOT NULL, type INTEGER NOT NULL DEFAULT (- 1), active BOOLEAN NOT NULL DEFAULT FALSE, made_datetime TIMESTAMP WITH TIME ZONE NOT NULL, recorded_datetime TIMESTAMP WITH TIME ZONE NOT NULL);

CREATE TABLE IF NOT EXISTS splits (uuid TEXT PRIMARY KEY UNIQUE NOT NULL, txn_uuid TEXT NOT NULL, cny_uuid TEXT NOT NULL, phase INTEGER NOT NULL DEFAULT (- 1), type INTEGER NOT NULL DEFAULT (- 1), subtype INTEGER NOT NULL DEFAULT (- 1), amount NUMERIC NOT NULL, comment TEXT);

CREATE TABLE IF NOT EXISTS transactions (uuid TEXT PRIMARY KEY UNIQUE NOT NULL, act_uuid TEXT NOT NULL, type INTEGER NOT NULL DEFAULT (- 1), num INT NOT NULL, comment TEXT, magic INTEGER DEFAULT (- 1) NOT NULL, entry_datetime TIMESTAMP WITH TIME ZONE NOT NULL);

CREATE TABLE IF NOT EXISTS txn_orders (txn_uuid TEXT PRIMARY KEY UNIQUE NOT NULL, symbol TEXT NOT NULL, lots NUMERIC NOT NULL, entry_price NUMERIC NOT NULL, entry_stoploss NUMERIC NOT NULL DEFAULT (0), entry_takeprofit NUMERIC NOT NULL DEFAULT (0));

CREATE TABLE IF NOT EXISTS txn_orders_exit (txn_uuid TEXT PRIMARY KEY UNIQUE NOT NULL, exit_datetime TIMESTAMP WITH TIME ZONE NOT NULL, exit_lots NUMERIC, exit_price NUMERIC NOT NULL, exit_stoploss NUMERIC NOT NULL DEFAULT (0), exit_takeprofit NUMERIC NOT NULL DEFAULT (0), exit_comment TEXT);

CREATE TABLE IF NOT EXISTS act_equity (uuid TEXT PRIMARY KEY UNIQUE NOT NULL, act_uuid TEXT NOT NULL, record_datetime TIMESTAMP WITH TIME ZONE NOT NULL, leverage INTEGER, margin_so_mode INTEGER, margin_so_call NUMERIC, margin_so_so NUMERIC, balance NUMERIC, equity NUMERIC, credit NUMERIC, margin NUMERIC);

CREATE TABLE IF NOT EXISTS txn_orders_equity (txn_uuid TEXT NOT NULL, eqt_uuid TEXT NOT NULL, lots NUMERIC, price NUMERIC, stoploss NUMERIC, takeprofit NUMERIC, commission NUMERIC, swap NUMERIC, gross NUMERIC, PRIMARY KEY (txn_uuid, eqt_uuid));