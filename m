Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09507CCA47B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiGEMZW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiGEMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC2183B9;
        Tue,  5 Jul 2022 05:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D303619A6;
        Tue,  5 Jul 2022 12:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5AEC341C7;
        Tue,  5 Jul 2022 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657023169;
        bh=KLewugvlQfnHhOK3fgli2q9qbyOzLhQxzieXn0BcCdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jnpui4DS7tMvR5BIqA4kYcc9rvw0vb9XmzBYAiimdcbYoQfZqJDknRo75y2L3KdW+
         s6roqgz7jrTIoOApC+CMBES6+TIAvWkSkbLtHm4SYejImh9wOSvisQLBqKz3ZqbVUG
         7CdE+pLA7HKiJ6subq8s9+CTFRP3o2SuaJtUmA7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 5.15 62/98] selftests/rseq: remove ARRAY_SIZE define from individual tests
Date:   Tue,  5 Jul 2022 13:58:20 +0200
Message-Id: <20220705115619.341529183@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115617.568350164@linuxfoundation.org>
References: <20220705115617.568350164@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

commit 07ad4f7629d4802ff0d962b0ac23ea6445964e2a upstream.

ARRAY_SIZE is defined in several selftests. Remove definitions from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from rseq tests and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c |    3 +--
 tools/testing/selftests/rseq/rseq.c                  |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -9,10 +9,9 @@
 #include <string.h>
 #include <stddef.h>
 
+#include "../kselftest.h"
 #include "rseq.h"
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -27,10 +27,9 @@
 #include <signal.h>
 #include <limits.h>
 
+#include "../kselftest.h"
 #include "rseq.h"
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 __thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };


