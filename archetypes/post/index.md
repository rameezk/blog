---
title: "{{ replace (substr .Name 12) "-" " " | title }}"
date: {{ .Date | time.Format "2006-01-02" }}
draft: true
tags: ["new-post"]
author: "Rameez Khan"
showToc: true
TocOpen: false
hidemeta: false
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
series: []
---
