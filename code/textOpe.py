"""
author  : Mr.lemon
TODO    : re match
date    : 2019-05-13 15:47:13
"""

import re
import gbl
import sqlp

host = "172.17.0.2"
port = 3306
user = "root"
passwd = "xxxxxxjbd_"
database = "test"
mysql = sqlp.sqlp(ip=host, us=user, passwd=passwd, db=database)


def textMatch(rePat, text):
    # TODO match rePat in Text
    result = None
    try:
        pattern = re.compile(rePat)
        result = pattern.findall(text)
    except re.error as erp:
        print(gbl.RE00001)
        print(erp)
    finally:
        if result == None:
            print(gbl.RE00002)
        return result


def writeFile(text, fname):
    # TODO match rePat in Text
    try:
        fl = open(fname, "a")
        if fl.writable():
            fl.write(text)
        else:
            print(gbl.FL0002)
    except fl.errors as erp:
        print(gbl.FL0001)
        print(erp)
    finally:
        fl.close()


def createTb():
    # TODO create table ID Name download_url paper
    sql = """
    CREATE TABLE paper
    (
    Id int PRIMARY KEY AUTO_INCREMENT,
    pName varchar(500) ,
    download_url char(100),
    paper TEXT
    )default charset=utf8;
    """
    mysql.exec(sql)
    sqlp = "alter database test CHARACTER SET utf8;"
    mysql.exec(sqlp)


def delTb():
    sql = """
        DROP TABLE paper;
        """
    mysql.exec(sql)


def writeDb(text):
    for i in range(len(text)):
        sql = """
        INSERT INTO paper ( pName, download_url,paper )
                           VALUES
                           ( "{v1}", "{v2}","{v3}" );
        """.format(v1=text[i][0], v2=text[i][1], v3=text[i][2])
        mysql.exec(sql)
