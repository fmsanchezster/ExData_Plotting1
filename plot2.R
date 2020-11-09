# plot2.R
## Script para la generación del gráfico correspondiente 
## Author: Francisco M. Sánchez Sosa
##

## Instalacion y carge de paquetes
install.packages('lubridate')
library(lubridate)


## Carga de los datos 

url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
filezip='electric_power_consumption.zip'
file='household_power_consumption.txt'
download.file(url,filezip)
unzip(filezip)

### EStudio de espacio de memoria necesario para los datos

numero_filas<-2075259
numero_columnas <- 9
tamañocelda<- 8
tamañofichero<-tamañocelda*numero_columnas*numero_filas
MBtamañofichero<-round(tamañofichero/2^20, 2)
mensaje<-paste('El tamaño de memoria necesario es de:',MBtamañofichero,'MB')
print(mensaje) 

### Lectura de los datos , carga en memoria
electricPowerConsumption<-read.table(file,sep=';',dec=',', header = T)

### Preparación de los datos
electricPowerConsumption<-electricPowerConsumption[electricPowerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]
electricPowerConsumption$Date<-paste(electricPowerConsumption$Date,electricPowerConsumption$Time,sep=' ')
electricPowerConsumption$Date<-strptime(electricPowerConsumption$Date, format='%d/%m/%Y %H:%M:%S')
electricPowerConsumption<-select(electricPowerConsumption,-Time)
electricPowerConsumption$Global_active_power<-as.numeric(electricPowerConsumption$Global_active_power)
electricPowerConsumption$Sub_metering_1<-as.numeric(electricPowerConsumption$Sub_metering_1)
electricPowerConsumption$Sub_metering_2<-as.numeric(electricPowerConsumption$Sub_metering_2)
electricPowerConsumption$Sub_metering_3<-as.numeric(electricPowerConsumption$Sub_metering_3)

### Comprobación de los datos
str(electricPowerConsumption)
head(electricPowerConsumption)

### Creación del plot
par(mfrow=c(1,1))
plot(electricPowerConsumption$Date,electricPowerConsumption$Global_active_power,
       ylab ='Global Active Power (kilowatts)',xlab='',col = 'black',type='l')
### Grabación del plot en fichero 'png'
dev.copy(png,file='plot2.png', height = 480, width = 480)
dev.off()

