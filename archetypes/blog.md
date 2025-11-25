+++
type = 'page'
layout = 'post'
date = '{{ .Date }}'
draft = true
title = '{{ ( replace (slicestr .File.ContentBaseName 4) "-" " " ) | title}}'
slug = '{{ slicestr .File.ContentBaseName 4 }}'
lastmod = '{{ .Date }}'
tags = []
description = ''
publishDate = ''
+++
