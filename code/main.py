import cetOp
import textOpe

md = "get"
host = "http://hxen.com"
url = "/CET46/CET6/zhenti/index.html"
# url = "http://hxen.com/CET46/CET6/zhenti/index_2.html"

def getRes():
    txt = cetOp.getPaper(host + url, md)

    result = cetOp.operate(host, txt, md)
    return result

if __name__=="__main__":

    result = getRes()
    textOpe.createTb()
    # textOpe.delTb()
    textOpe.writeDb(result)
    # all = textOpe.mysql.selectTable()
    # print(all)

    for i in range(len(result)):
        textOpe.writeFile(result[i][2],result[i][0][0:27]+".txt")

