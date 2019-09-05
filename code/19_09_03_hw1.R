##########################################
##### try http://dagitty.net/primer/
# FOR HW 1 
# Cathy Su
##########################################
library(dagitty)

graphics.off()

g <- dagitty('dag {
    depart_delay [pos="0,0"]
    avg_speed [pos="0,1"]
    distance [pos="1,0.5"]
    time_of_flight [pos="2,1"]
    arrival_delay [pos="1,0"]
    
    depart_delay -> arrival_delay <- time_of_flight
    depart_delay -> avg_speed <- distance -> time_of_flight
    avg_speed -> time_of_flight
}')
plot(g)

impliedConditionalIndependencies(g )

# arrival_delay _||_ avg_speed | depart_delay, time_of_flight
# arrival_delay _||_ distance | depart_delay, time_of_flight
# depart_delay _||_ distance
# depart_delay _||_ time_of_flight | avg_speed, distance

###### tests whether there is any open path between two variables of interest
dseparated( g, "arrival_delay", "distance", c("depart_delay", "time_of_flight") )
# [1] TRUE 
# so no connection between arrival_delay and distance in this case

dseparated( g, "arrival_delay", "distance", c("depart_delay") )
# [1] FALSE
dseparated( g, "arrival_delay", "distance", c("depart_delay", "avg_speed") )
# [1] FALSE

dseparated( g, "arrival_delay", "distance", c("depart_delay", "avg_speed") )
# [1] FALSE

dseparated( g, "arrival_delay", "distance", c("depart_delay") )
# [1] FALSE

dseparated( g, "arrival_delay", "avg_speed", c("depart_delay", "avg_speed") )
# [1] FALSE
dseparated( g, "arrival_delay", "avg_speed", c("depart_delay" ) )
# [1] FALSE

dseparated( g, "arrival_delay", "avg_speed", c("depart_delay" ) )
# [1] FALSE


fig2.9 <- dagitty("dag { 
X <- Z1 -> Z3 <- Z2 -> Y
                  X <- Z3 -> Y
                  X -> W -> Y
                  }")
impliedConditionalIndependencies( fig2.9 )

dseparated( fig2.9, "Z2", "W", c("Z3" ) )
