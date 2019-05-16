"""
author ： Mr.lemon
TODO    ： operate mysql
date ：2019-05-13 11:07:57
main class ： sqlp
"""

import pymysql
import gbl


class sqlp:
    db = object
    tb = object

    def __init__(self, ip, us, passwd, db, po=3306):
        # TODO 初始化连接
        """
            :param ip : host ip
            :param us : mysql user
            :param passwd : mysql password
            :param db : mysql select database
            :param po : host port default=3306
        """
        try:
            db = pymysql.connect(host=ip, user=us, password=passwd, port=po, database=db, charset='utf8')
            tb = db.cursor()
            self.db = db
            self.tb = tb
        except self.db.Error or self.tb.Error as erp:
            print(gbl.DB0001)
            print(erp)
            self.__del__()

    def __del__(self):
        #  TODO 关闭连接
        try:
            self.db.close()
        except self.db.Error as erp:
            print(gbl.DB0002)
            print(erp)

    def exec(self, sqlDothing):
        # TODO 处理除select操作
        print(sqlDothing)
        if str(sqlDothing).find("select", 0, 10) != -1:
            print(gbl.DB0003)
            return
        try:
            self.tb.execute(str(sqlDothing))
        except self.tb.Error as erp:
            print(gbl.DB0004)
            print(erp)
        finally:
            self.db.commit()

    def selectTable(self, selectOperate):
        # TODO select from tableName
        try:
            self.tb.execute(str(selectOperate))
            getCont = self.tb.fetchall()
            return getCont
        except self.tb.Error as erp:
            print(gbl.DB0005)
            print(erp)
