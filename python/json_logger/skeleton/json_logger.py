# Based on NewRelicContextFormatter.
# https://github.com/newrelic/newrelic-python-agent/blob/9990e71ba90fe796d59f7d8761cf0842a0155e2e/newrelic/api/log.py#L45

import json
from logging import Formatter, LogRecord


class JsonLogFormatter(Formatter):
    DEFAULT_LOG_RECORD_KEYS = frozenset(vars(LogRecord("", 0, "", 0, "", (), None)))

    def _safe_str(self, object_, *args, **kwargs):
        try:
            return str(object_, *args, **kwargs)
        except Exception:
            return "<unprintable {} object>".format(type(object_).__name__)

    def format(self, record):
        data = {}

        for key, value in vars(record).items():
            if key in self.DEFAULT_LOG_RECORD_KEYS:
                data[key] = value
            else:
                data[f"extra.{key}"] = value

        return json.dumps(data, default=self._safe_str, separators=(",", ":"))
