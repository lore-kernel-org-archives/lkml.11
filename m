Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD10BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbiDZIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbiDZIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE7D47562;
        Tue, 26 Apr 2022 01:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E34CB81CF9;
        Tue, 26 Apr 2022 08:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885EAC385AC;
        Tue, 26 Apr 2022 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650961553;
        bh=JQ7Ve6zrX8vsQolzB2eHjcNa/3twcGFJn2Abmjf8RFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/Ej/uYHNVz2dfwJEohsHcmpnhLf8soryqbRtaybARk8Z0TSB69MB77I77iRla49V
         0P+gqWgImzopZIbriXvbL7Pq0ln8Vf0+7KKghtHBGf3VJVkMpOlLWl5SXc/7dNoMmZ
         SW7xldaqrKAfpEF6BD6fX6zt/0Bcn10ADwThPgEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 34/43] block/compat_ioctl: fix range check in BLKGETSIZE
Date:   Tue, 26 Apr 2022 10:21:16 +0200
Message-Id: <20220426081735.521229574@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081734.509314186@linuxfoundation.org>
References: <20220426081734.509314186@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khazhismel Kumykov <khazhy@google.com>

commit ccf16413e520164eb718cf8b22a30438da80ff23 upstream.

kernel ulong and compat_ulong_t may not be same width. Use type directly
to eliminate mismatches.

This would result in truncation rather than EFBIG for 32bit mode for
large disks.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20220414224056.2875681-1-khazhy@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/compat_ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -391,7 +391,7 @@ long compat_blkdev_ioctl(struct file *fi
 		return 0;
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
+		if ((size >> 9) > ~(compat_ulong_t)0)
 			return -EFBIG;
 		return compat_put_ulong(arg, size >> 9);
 


