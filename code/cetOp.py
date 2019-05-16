"""
author  : Mr.lemon
TODO    : CET 恶心的爬去，数据清洗
date    : 2019-05-13 11:25:41
"""

import webspy
import textOpe
import time
import gbl
import re

http = webspy.reqHttp()


def getPaper(link, md):
    # 获取第一层页面
    http.setHttp(md, link)
    http.getHttp()
    http.setEncoding("gbk")
    txt = http.getText()
    return txt


def operate(host, txt, md):
    # 获取第二层子页面链接
    pa1 = r'href="/CET46/CET6/zhenti/[^\s]*.html'
    link = textOpe.textMatch(pa1, txt)
    links = sorted(set(link), key=link.index)
    result = []
    # 获取第二层子页面内容
    for ip in links:
        ll = host + ip[6:]
        # time.sleep(1)
        tpl = getPaper(ll, md=md)
        print(ll)
        topic = gettopic(tpl)

        if topic.find("图片版") != -1:
            continue
        paper = getPage(tpl)
        down = getDown(tpl)
        if len(paper) < 5000:
            paper = situ1(ll, md)
        print(topic)
        print(down)
        # print(paper)
        print()
        print()
        res = []
        res.append(topic)
        res.append(down)
        res.append(paper)
        result.append(res)
    return result


def gettopic(txt):
    # 获取标题
    pa = r'<title>(.*?)</title>'
    rest = textOpe.textMatch(pa, txt)
    return rest[0]


def getDown(txt):
    # 获取下载链接
    pa = r'[a-zA-z]+://[^\s]*.rar'
    rest = textOpe.textMatch(pa, txt)
    download = ""
    if rest == []:
        download = gbl.CET0001
    else:
        download = rest[0]

    return download


def getPage(txt):
    # 获取paper
    pa3 = r"<p>((.|\n)*)</p>"
    txt = txt.replace(r"\n", "<br />")
    rest2 = textOpe.textMatch(pa3, txt)

    if len(rest2) == 0:
        return ""
    all = str(rest2[0]).replace("<p>", "").replace("<br />", "").replace("&nbsp;", "").replace(r"\u3000", "")
    all = re.sub(re.compile(r'<a .*?>'), "", all).replace("</a>", "")
    all = re.sub(re.compile(r'<div.*?</div>'), "", all).replace('"',r"\'")
    all = re.sub(re.compile('<img.*?</p>'), "", all)
    all = re.sub(re.compile('.*?套）'), "", all)
    all = re.sub(re.compile(r'.*?</table>'), "", all).replace("</p>", "").replace(r"\r\n", " ")
    all = re.sub(re.compile(r'<strong>.*?<strong>'), "", all).replace("</strong>", "")
    all = re.sub(re.compile('.*?</span>'), "", all)
    return all


def situ1(link, md):
    # 获取
    txt = getPaper(link, md)
    pal = getPage(txt)
    res = str(pal)
    for i in range(2, 10):
        time.sleep(1)
        linp = str(link).replace(".html", "_" + str(i) + ".html")
        print(linp)
        txt = getPaper(linp, md)
        pal = getPage(txt)
        res = res + pal
    return res
