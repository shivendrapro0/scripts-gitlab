#!/usr/bin/python
#
# This script will list down all gitlab repos inside you have access on. 
# This will help in mass modification.
# replace token & gitlab_url  and run it
#
import requests
import json
token="?per_page=100&private_token=<token>"
project_url="https://<gitlab_url>/api/v4/projects"

def getJsonUrl(prj,token):
    list_project = requests.get(prj+token)
    list_project = list_project.json()
    return list_project


for g in getJsonUrl(project_url,token):
    print(g['http_url_to_repo'])
