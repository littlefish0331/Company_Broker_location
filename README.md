# README

最後更新時間: 2020-05-06

## 未來可加強

- 製作搜尋網站
  - 輸入公司名稱或公司統一編號，找到附近券商
  - 輸入券商名稱或公司統一編號，找到附近公司
  - 附近距離可以自行調整

- 用python撰寫

- 資料自動每月更新

- 資料範圍增加國外公司與國外券商

## 緣由

日前同事(順貿)，有個股票趨勢的假說，  
就是覺得公司和券商如果地理位置在附近的話，  
可能中午出來吃飯會有內線交易的嫌疑，  
所以請我幫忙將公司及券商的地址轉換成經緯度，  
並計算彼此距離，列出有在10公里範圍內的公司及券商。

資料來源: [券商一覽-Nvesto](https://www.nvesto.com/tpe/broker/list)

## 程式說明

- TGOS_address_lonlat.Rmd: 地址轉換成經緯度。
- FUN.R: 用到的自定義函式。
- cal_distance.Rmd: 計算公司看券商的距離。

**first version:**

- Geocode by
  - google sheet
  - google api

## 資料說明

- address.csv [名稱,地址,網址,類型]，原始資料。
- Address_TGOS_sample.csv [id, Address, Response_Address,Response_X, Response_Y]，TGOS的範例上傳資料。
- input.csv [id, Address, Response_Address, Response_X, Response_Y]，address.csv轉換成上傳TGOS需要的格式。
- Address_Finish_v1.csv [id, Address, Response_Address, Response_X, Response_Y]，未對資料進行處理就上傳TGOS的結果。
- Address_Finish_v2.csv [id, Address, Response_Address, Response_X, Response_Y]，有對資料進行處理就上傳TGOS的結果。
- tmp05_others.csv [Name, Address, Website, Type, useless_addr, useful_addr, clean_addr]，找不到指定門牌地址的資料，轉用 google sheet 的 awesome table或是google map轉換。
- tmp05_others_geocode_google.csv [Name, Address, Website, Type, useless_addr, useful_addr, clean_addr, google_geocode, google_latitude, google_longitude]，google sheet-geocode_google轉換的結果。
- tmp05_others_awesome_table.csv [Name, Address, Website, Type, useless_addr, useful_addr, clean_addr, Latitude, Longitude]，google sheet-awesome_table轉換的結果。
- address_lonlat [Name, Address, Website, Type, lon, lat]，合併所有結果。
- company_10km_broker.csv: [id_company, Name_company, id_broker, Name_broker]，有在10km內的公司及券商。
- company_broker_idlonlat.csv: [id, Name, Type, lon, lat]，公司及券商的id編號、類型與經緯度。
