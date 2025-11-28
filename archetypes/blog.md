+++
type = 'page'
layout = 'post'
date = '{{ .Date }}'
title = '{{ ( replace (slicestr .File.ContentBaseName 4) "-" " " ) | title}}'
slug = '{{ slicestr .File.ContentBaseName 4 }}'
lastmod = '{{ .Date }}'
draft = true
tags = []
description = ''
publishDate = ''
whatChanged = ''
+++
