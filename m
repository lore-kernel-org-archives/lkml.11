Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809FEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbiESVlh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiESVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:41:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477E4D9E6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4pFy5yUDyOn3t6yQ5LMrAaM08lEHZzH/aMff1iGk6z8=; b=qxWfOID7UF8TYDA8cO+Bwcr5Yz
        90IqcFX8KvkE84q8PtXbSeF9qf942jx61MkfSJCa+uWeSyTi3t80pBTU8f/EMSSBIsNhXy8LIo3gt
        WTMq9ouMDYlOZuspBASafJZIJ/hGnWzkAku35uYqG1oxuw/YPUvLzypNqq1r6NRJpGGwuyt9akRAq
        I/x16EGv7Dkm5vrPKBNQPUSvisK95D0lwu9iMpLG8xZoyi3U9+YyNejFqaz4EjUrQJLwszXT7Twk5
        YOEeBS3t8c/WsOT2BMTapP4R/rbZh++wu2+OOLFnDd1AwtLl20brjufm4LHtu/fG9ReMbAMGnhj0S
        zyRZ0ZVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrntP-00D7Pn-A6; Thu, 19 May 2022 21:41:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A39C3010C4;
        Thu, 19 May 2022 23:41:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1AACA2021AF80; Thu, 19 May 2022 23:41:07 +0200 (CEST)
Message-ID: <20220519213421.999009886@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 19 May 2022 23:27:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org
Subject: [RFC][PATCH 7/9] cpuidle: Annotate poll_idle()
References: <20220519212750.656413111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __cpuidle functions will become a noinstr class, as such they need
explicit annotations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/poll_state.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -13,7 +13,10 @@
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start = local_clock();
+	u64 time_start;
+
+	instrumentation_begin();
+	time_start = local_clock();
 
 	dev->poll_time_limit = false;
 
@@ -37,6 +40,7 @@ static int __cpuidle poll_idle(struct cp
 		}
 	}
 	current_clr_polling();
+	instrumentation_end();
 
 	return index;
 }


