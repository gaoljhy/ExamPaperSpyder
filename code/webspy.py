"""
author  : Mr.lemon
TODO    : http request
date    : 2019-05-13 14:37:34
"""

import requests
import gbl


class reqHttp:
    method = ""
    headers = {}
    url = ""
    form = {}
    _result = requests.models.Response()
    """
    :param method : http request method
    :param headers : http request method
    :param url : http request url
    :param result : http request method 
    """

    def setHttp(self, method, url, form=None, headers={}):
        self.method = method
        self.url = url
        self.form = form
        self.headers = headers

    def setEncoding(self, encod="utf-8"):
        # TODO set response encoding
        self._result.encoding = encod

    def getHttp(self):
        # TODO operate http request
        if self.method.lower() == "get":
            try:
                self._result = requests.get(url=self.url, params=self.form, headers=self.headers)
            except requests.HTTPError or requests.ConnectionError as erp:
                print(gbl.HTTP0002)
                print(erp)
        elif self.method.lower() == "post":
            try:
                self._result = requests.post(url=self.url, data=self.form, headers=self.headers)
            except requests.HTTPError or requests.ConnectionError as erp:
                print(gbl.HTTP0003)
                print(erp)
        else:
            print(gbl.HTTP0001)

    def getStatus(self):
        # TODO return response http code
        code = self._result.status_code
        if code > 600 or code < 100:
            print(gbl.HTTP0004)
            return 0
        return code

    def getResponseHead(self):
        # TODO get response headers
        dtc = self._result.headers
        if len(dtc) == 0:
            print(gbl.HTTP0005)
            return None
        return dtc

    def getText(self):
        # TODO return response http contecnt
        ht = self._result.text.encode("utf-8").decode("utf-8")
        if len(ht) == 0:
            print(gbl.HTTP0006)
            return None
        return ht
