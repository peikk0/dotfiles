# -*- coding: utf-8 -*-
"""
Display Icinga2 service status informations

Configuration Parameters:
    - cache_timeout: how often the data should be updated
    - base_url: the base url to the icinga-web2 services list
    - disable_acknowledge: enable or disable counting of acknowledged service
      problems
    - user: username to authenticate against the icinga-web2 interface
    - password: password to authenticate against the icinga-web2 interface

@author Ben Oswald <ben.oswald@root-space.de>
@license MIT License <https://opensource.org/licenses/MIT>
@source https://github.com/nazco/i3status-modules
"""
from time import time
from enum import Enum
import requests


class Status(Enum):
    OK = 0
    WARNING = 1
    CRITICAL = 2
    UNKNOWN = 3


class Py3status:
    """
    """
    # available configuration parameters
    cache_timeout = 60
    base_url = ''
    disable_acknowledge = False
    url_parameters = "?service_state={service_state}&format=json"
    user = ''
    password = ''
    ca = True

    def a3unknown(self, i3s_output_list, i3s_config):
        format = 'Unknown: {unknown}'
        response = {
            'color': '#ba8baf',
            'cached_until': time() + self.cache_timeout,
            'full_text': format.format(unknown=self._queryServiceCount(Status.UNKNOWN))
        }
        return response

    def a2critical(self, i3s_output_list, i3s_config):
        format = 'Critical: {critical}'
        response = {
            'color': '#ab4642',
            'cached_until': time() + self.cache_timeout,
            'full_text': format.format(critical=self._queryServiceCount(Status.CRITICAL))
        }
        return response

    def a1warning(self, i3s_output_list, i3s_config):
        format = 'Warning: {warning}'
        response = {
            'color': '#dc9656',
            'cached_until': time() + self.cache_timeout,
            'full_text': format.format(warning=self._queryServiceCount(Status.WARNING))
        }
        return response

    def a0ok(self, i3s_output_list, i3s_config):
        format = 'OK: {ok}'
        response = {
            'color': '#a1b56c',
            'cached_until': time() + self.cache_timeout,
            'full_text': format.format(ok=self._queryServiceCount(Status.OK))
        }
        return response

    def _queryServiceCount(self, state):
        if self.disable_acknowledge:
            self.url_parameters = self.url_parameters + "&service_handled=0"
        result = requests.get(
            self.base_url +
            self.url_parameters.format(service_state=state.value),
            auth=(self.user, self.password), verify=self.ca)
        return len(result.json())

if __name__ == "__main__":
    pass
