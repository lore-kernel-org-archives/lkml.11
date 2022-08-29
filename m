Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE42ECAAD4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 11:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiH2L1G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiH2LYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769A7677F;
        Mon, 29 Aug 2022 04:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ED83B80F00;
        Mon, 29 Aug 2022 11:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FA5C433C1;
        Mon, 29 Aug 2022 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661771724;
        bh=Ywpm/N3wNiOfJT9MgHTXXtCudCMFssgoOA1F3CJyNtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQNAowDhyj0Z4vtQHJU7Ap+O100PJbnOM7UFjot7mkyTtj4M7zQ+hyAIaxP27VYsS
         7tk2umdYJwN/qQHEUXUEZk+wZn2YsTowxm84SDu/vs4u5NlYMHlgJxXXJBGghTkQs1
         ht3FnCFS1dEmtpKGcaXAnCcG/EMLVHZhHC8Gf97Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <guoqing.jiang@linux.dev>,
        Song Liu <song@kernel.org>
Subject: [PATCH 5.15 122/136] Revert "md-raid: destroy the bitmap after destroying the thread"
Date:   Mon, 29 Aug 2022 12:59:49 +0200
Message-Id: <20220829105809.688502811@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829105804.609007228@linuxfoundation.org>
References: <20220829105804.609007228@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@linux.dev>

commit 1d258758cf06a0734482989911d184dd5837ed4e upstream.

This reverts commit e151db8ecfb019b7da31d076130a794574c89f6f. Because it
obviously breaks clustered raid as noticed by Neil though it fixed KASAN
issue for dm-raid, let's revert it and fix KASAN issue in next commit.

[1]. https://lore.kernel.org/linux-raid/a6657e08-b6a7-358b-2d2a-0ac37d49d23a@linux.dev/T/#m95ac225cab7409f66c295772483d091084a6d470

Fixes: e151db8ecfb0 ("md-raid: destroy the bitmap after destroying the thread")
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6251,11 +6251,11 @@ static void mddev_detach(struct mddev *m
 static void __md_stop(struct mddev *mddev)
 {
 	struct md_personality *pers = mddev->pers;
+	md_bitmap_destroy(mddev);
 	mddev_detach(mddev);
 	/* Ensure ->event_work is done */
 	if (mddev->event_work.func)
 		flush_workqueue(md_misc_wq);
-	md_bitmap_destroy(mddev);
 	spin_lock(&mddev->lock);
 	mddev->pers = NULL;
 	spin_unlock(&mddev->lock);


