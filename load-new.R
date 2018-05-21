fnames=list.files("Q:/Users/rootMNXL/Desktop/АнодированиеПослеОбработкиДанных/АнодиованиеРезы/АнодиованиеРезы/3/основ",
                  pattern = "Log-20150922-(\\d{6}).csv",full.names = T)
fnames=fnames[order(fnames)]
#Q:/Users/rootMNXL/Desktop/АнодированиеПослеОбработкиДанных/АнодиованиеРезы/АнодиованиеРезы/3/основ/Log-20170530-131522.csv
require(xts)
#fname="C:/Users/yuferov-vg/Desktop/YVY/data/Log-20170530-131522.csv"
df_list=list()
for(fname in fnames) {
  dt=strptime(substr(fname,104,118),"%Y%m%d-%H%M%S")
  print(dt)
  df=read.csv(fname,skip=5,header=T)
  #df['DT']=dt-df[length(df$Time.S.),1]+df[,1]
  df['DT']=dt-df[,1]
  print(substr(fname,104,118))
  df_list[[substr(fname,104,118)]]=as.xts(df[,c(1,2,3)],order.by=df$DT)
}
length(df_list)
class(df_list[[1]])
periodicity(df_list[[1]])

df_xts=do.call(rbind,df_list)
#merge(df_list[[1]],df_list[[2]])
# Remove rows with a duplicated timestamp
df_xts_noDUP <- df_xts[ ! duplicated( index(df_xts) ),  ]
df_xts_noDUP <- df_xts[ ! duplicated( index(df_xts), fromLast = TRUE),  ]

# Remove rows with a duplicated timestamp, but keep the latest one
z <- x[ ! duplicated( index(x), fromLast = TRUE ),  ]


plot.xts(df_xts[,c(1)])
?plot.xts(df_xts[,c(3)])
#plot.xts(df_xts)

head(df_xts,10)

write.csv2(as.data.frame(df_xts),'Q:/GLSKMSNA/xts.csv')
