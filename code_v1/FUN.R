
# ---
# - unicode編碼轉換為UTF-8編碼
# 地址用向量送進來
library(stringi)
library(dplyr)
unicode2utf8 <- function(x_vec){
  t1 <- gsub("<U\\+(....)>", "\\\\u\\1", x_vec)
  res <- t1 %>% stri_unescape_unicode()
  return(res)
}


# ---
# 將地址依照門牌號分開，用useless決定要回傳哪一部分。
# 如果沒有偵測到門牌號
# - useless = F 則回傳完整地址
# - useless = T 則回傳 wrong address
# 地址用sapply送進來
library(dplyr)
addr.SPby.doornum <- function(x, useless = F){
  idx <- x %>% gregexpr(pattern = "號", text = .) %>% unlist() %>% max
  if (idx==-1 & !useless) res <- x
  if (idx==-1 & useless) res <- "wrong_address"
  if (idx!=-1 & !useless) res <- x %>% substring(., 1, idx)
  if (idx!=-1 & useless) res <- x %>% substring(., idx+1)
  return(res)
}


# ---
# 移除開頭的郵遞區號
# 地址用sapply送進來
library(dplyr)
rm.headpostcode <- function(x){
  res <- x %>% 
    sub(x = ., pattern = "^[0-9]+", replacement = "") %>% 
    sub(x = ., pattern = "^\\([0-9]+\\)", replacement = "")
  return(res)
}




# ---
# 移除多地址連結符號後的文字
# 地址用sapply送進來
library(dplyr)
rm.comb.addr <- function(x){
  idx <- x %>% gregexpr(pattern = "-|,|、", text = .) %>% unlist() %>% min
  if (idx==-1) res <- x
  if (idx!=-1) res <- x %>% substring(., 1, idx-1)
  return(res)
}




# ---
# 如果清理完的地址，最後一個字不是號，補上號字
# 地址用向量送進來
add.doornum.word <- function(x_vec){
  t1 <- str_sub(string = x_vec, start = -1)
  res <- ifelse(t1!="號", paste0(x_vec, "號"), x_vec)
  return(res)
}





# ---
# 處理TGOS地址轉經緯度的結果
# 針對多個地址結果[Response_Address, Response_X, Response_Y]，取出第一個
# 如果原本就只有一個地址，就直接回傳。
# 如果偵測到";"，就拆解並回傳第一個。
# 地址、lon、lat分別用apply送進來
take.first.TGOSresult <- function(x){
  idx <- x %>% gregexpr(pattern = ";", text = .) %>% unlist() %>% min
  if (idx==-1) res <- x
  else res <- x %>% substring(., 1, idx-1)
  return(res)
}

