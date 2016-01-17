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

    def a3_unknown(self, i3s_output_list, i3s_config):
        return self._get_response(Status.UNKNOWN, 'Unknown: {count}',
                                  '#ba8baf')

    def a2_critical(self, i3s_output_list, i3s_config):
        return self._get_response(Status.CRITICAL, 'Critical: {count}',
                                  '#ab4642')

    def a1_warning(self, i3s_output_list, i3s_config):
        return self._get_response(Status.WARNING, 'Warning: {count}',
                                  '#dc9656')

    def a0_ok(self, i3s_output_list, i3s_config):
        return self._get_response(Status.OK, 'OK: {count}', '#a1b56c')

    def _get_response(self, state, format, color):
        count = self._query_service_count(state)
        if count == 0:
            color = '#585858'
        elif count == -1:  # request error
            color = '#a16946'
        response = {
            'color': color,
            'cached_until': time() + self.cache_timeout,
            'full_text': format.format(count=count)
        }
        return response

    def _query_service_count(self, state):
        if self.disable_acknowledge:
            self.url_parameters = self.url_parameters + "&service_handled=0"
        try:
            result = requests.get(
                self.base_url +
                self.url_parameters.format(service_state=state.value),
                auth=(self.user, self.password), verify=self.ca, timeout=10)
        except:
            return -1
        return len(result.json())

if __name__ == "__main__":
    pass
