Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B50C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 12:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiBLMXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 07:23:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiBLMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01A26107
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7426CB80691
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EAFC340E7;
        Sat, 12 Feb 2022 12:23:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dQfub2nP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyNsVaUyQWOPLIUs8NzWo56+7MmoIS24JC7SU4iNpOc=;
        b=dQfub2nPsXvqJ9dkmA9p8S497UZownITrhL1mhP12zvoQwNcGXVTKSNGGuqxWCh1c8ZX5R
        92v1yqZWHOB6TquxPwr4wx23iPOgTliBOlymZy+dG6VmtFpEButDUXc+mzR1+FqL1AZFl7
        h0Wa2Fb02nrPfagWbzb2hE+zNUjMCA8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6485056d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 02/10] random: remove useless header comment
Date:   Sat, 12 Feb 2022 13:23:10 +0100
Message-Id: <20220212122318.623435-3-Jason@zx2c4.com>
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
References: <20220212122318.623435-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This really adds nothing at all useful.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/random.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index e92efb39779c..37e1e8c43d7e 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -1,9 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * include/linux/random.h
- *
- * Include file for the random number generator.
- */
+
 #ifndef _LINUX_RANDOM_H
 #define _LINUX_RANDOM_H
 
-- 
2.35.0

