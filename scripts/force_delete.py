"""
Quick script to manually send a cloudformation success signal 
as the custom resource when it is deleted, to get the stack
back into a stable state when the custom resource fails to 
handle deletion properly.
"""

import sys
import json
import requests

event_raw = sys.argv[1]
event_raw = event_raw.replace("\'", "\"")
event = json.loads(event_raw)

if ("RequestType" in event and event["RequestType"] == "Delete"):
    requests.put(event["ResponseURL"], data={
        "Status": "SUCCESS",
        "PhysicalResourceId": event["PhysicalResourceId"],
        "StackId": event["StackId"],
        "RequestId": event["RequestId"],
        "LogicalResourceId": event["LogicalResourceId"],
        }
    )

#     print(event["RequestId"])
#     print(event["ResponseURL"])
#     print(event["StackId"])
#     print(event["LogicalResourceId"])
#     print(event["PhysicalResourceId"])
