library(tidyverse);library(lme4);library(broom)
library(modelr);library(ggthemes)



cw1 <- lmer(log(weight) ~ Time*Diet + (1|Chick), data = ChickWeight)
nd <- data_grid(data = ChickWeight, Time = Time, Diet = Diet)
predict.fun <- function(my.lmm) {
  predict(my.lmm, newdata = nd, re.form = NA,)   # This is predict.merMod 
}
nd$pred <- predict.fun(cw1)
ggplot(ChickWeight,aes(Time,log(weight)))+
  geom_point(alpha = 0.5)+
  geom_smooth(method = "lm", se = F,  linetype = "dashed", color = "black")+
  geom_line(data = nd,aes(Time,pred,color = Diet))+
  facet_wrap(~Diet)+
  theme_few()
  



sl1 <- lmer(Reaction ~ Days + (1|Subject), sleepstudy)
sl2 <- lm(Reaction ~ Days, sleepstudy)


nd2 <- data_grid(data = sleepstudy, Days = Days)

predict.fun <- function(my.lmm) {
  predict(my.lmm, newdata = nd2, re.form = NA,)   # This is predict.merMod 
}

nd2$pred <- predict.fun(sl1)
nd2$lm_pred <- predict(sl2,newdata = nd2)


ggplot(sleepstudy,aes(Days,Reaction))+
  geom_point(alpha = 0.5)+
  geom_line(data = nd2, aes(Days, lm_pred), color = "red", size = 1.5)+
  geom_line(data = nd2, aes(Days, pred))+
  geom_line(data = xx, aes(Days, .fixed), color = "blue")
  


xx <- augment(sl1)
