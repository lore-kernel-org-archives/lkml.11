Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA3C19F2B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 17:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiG0Rqs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242844AbiG0RqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:46:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E158C59D;
        Wed, 27 Jul 2022 09:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB58BB8200D;
        Wed, 27 Jul 2022 16:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0043CC433C1;
        Wed, 27 Jul 2022 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658940815;
        bh=Fu+RQZP2lBIVjrGU4m9Qhg1VGiP+0En1tD5IuKWsy6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpzrzVwcUmn+29pAW3Y9wslbA8nZg+rvMj5ASp8V4zUzH9IJSNaZ881IlPHl/L4CO
         dM/UFVxP30bRJhB96gXY2vFBNtGbZ93d+mTUQ6f3kBC0nHj3E1JWGTCLE/UpXNu30O
         1vnFcRFhC2HWOp+kRgmS36cGHF1YyyafMiJp5uDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.18 158/158] watch-queue: remove spurious double semicolon
Date:   Wed, 27 Jul 2022 18:13:42 +0200
Message-Id: <20220727161027.658313194@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727161021.428340041@linuxfoundation.org>
References: <20220727161021.428340041@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 44e29e64cf1ac0cffb152e0532227ea6d002aa28 upstream.

Sedat Dilek noticed that I had an extraneous semicolon at the end of a
line in the previous patch.

It's harmless, but unintentional, and while compilers just treat it as
an extra empty statement, for all I know some other tooling might warn
about it. So clean it up before other people notice too ;)

Fixes: 353f7988dd84 ("watchqueue: make sure to serialize 'wqueue->defunct' properly")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/watch_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -227,7 +227,7 @@ void __post_watch_notification(struct wa
 
 		if (lock_wqueue(wqueue)) {
 			post_one_notification(wqueue, n);
-			unlock_wqueue(wqueue);;
+			unlock_wqueue(wqueue);
 		}
 	}
 


