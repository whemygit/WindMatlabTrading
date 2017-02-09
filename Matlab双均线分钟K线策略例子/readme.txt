该应用案例是基于Wind量化接口对双均线策略进行分钟级策略回测

(1) 该回测使用Matlab语言开发。首先，我们通过Wind量化接口获取9:30到15:00之间的1分钟K线数据。主要使用的函数是wsi函数，wsi函数可以获取股票和期货等投资标的分钟级数据，其周期可在1分钟、3分钟、5分钟、10分钟、15分钟、30分钟、60分钟之间任意选择。
w.wsi(windcode,'open,high,low,close',start_time,end_time)
(2) 使用源代码中的LoadKline(windcode,start_time,end_time,interval)加载K线数据，并使用MovAvg(Prices,I,length)函数计算双均线值，此处我们采用5日均线和20日均线。
(3) 对每一根K线进行回测，判断是否均线交叉，当满足条件时，产生开仓平仓信号。所有回测周期处理完后，使用源代码中的Summary同时当日的投资收益。
