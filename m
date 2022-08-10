Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B6C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiHJQFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiHJQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7273315
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDBEB611B3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D058C43140;
        Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oLoDF-000Uza-21;
        Wed, 10 Aug 2022 12:05:41 -0400
Message-ID: <20220810160541.453059716@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Aug 2022 12:04:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ben Hutchings <benh@debian.org>
Subject: [for-linus][PATCH 3/4] tools/rtla: Build with EXTRA_{C,LD}FLAGS
References: <20220810160455.872730397@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

To allow for distributions and other builders to apply hardening
policy and other customisation, append EXTRA_CFLAGS and EXTRA_LDFLAGS
to the corresponding variables.

Link: https://lore.kernel.org/linux-trace-devel/YtLBshz0nMQ7530H@decadent.org.uk

Signed-off-by: Ben Hutchings <benh@debian.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index b8fe10d941ce..f392708c7a1e 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -30,8 +30,8 @@ WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_A
 
 TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
-CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS)
-LDFLAGS	:=	-ggdb
+CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
+LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
 LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
-- 
2.35.1
