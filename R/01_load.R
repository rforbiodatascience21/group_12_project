#Load raw data and save it
SPE = read_csv(file = "data/raw/SPE_pitlatrine.csv")
write_csv(x = SPE, file = "data/SPE_pitlatrine.csv")
ENV = read_csv("data/raw/ENV_pitlatrine.csv")
write_csv(x = ENV, file = "data/ENV_pitlatrine.csv")