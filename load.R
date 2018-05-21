'C:/Users/yuferov-vg/Desktop/YVY/processed/АнодиованиеРезы/3/основ/'
#fnames=list.files('C:/Users/yuferov-vg/Desktop/YVY/processed/АнодиованиеРезы/3/основ/',
fnames=list.files("C:/Users/yuferov-vg/Desktop/YVY/data/",
  pattern = "Log-20171116-(\\d{6}).csv",full.names = T)
fnames=fnames[order(fnames)]

require(xts)
#fname="C:/Users/yuferov-vg/Desktop/YVY/data/Log-20170530-131522.csv"
df_list=list()
for(fname in fnames) {
  dt=strptime(substr(fname,42,56),"%Y%m%d-%H%M%S")
  print(dt)
  df=read.csv(fname,skip=5,header=T)
  #df['DT']=dt-df[length(df$Time.S.),1]+df[,1]
  df['DT']=dt-df[,1]
  df_list[[substr(fname,42,56)]]=as.xts(df[,c(1,2,3)],order.by=df$DT)
}
length(df_list)
class(df_list[[1]])
periodicity(df_list[[1]])

df_xts=do.call(rbind,df_list)
#merge(df_list[[1]],df_list[[2]])

plot.xts(df_xts[,c(2)])
plot.xts(df_xts[,c(3)])
plot.xts(df_xts)
