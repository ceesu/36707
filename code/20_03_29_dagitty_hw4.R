##########################################
##### try http://dagitty.net/primer/
# FOR HW 1 
# Cathy Su
##########################################


library(dagitty)

g <- dagitty('dag {
v1 [pos="0.591,0.095"]
v2 [pos="0.693,0.223"]
v3 [pos="0.483,0.255"]
v4 [pos="0.347,0.210"]
v5 [pos="0.440,0.065"]
v1 -> v2
v2 -> v3
v4 -> v3
v5 -> v1
}')

plot(g)
impliedConditionalIndependencies(g )
