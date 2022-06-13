Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40235CCA47B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 11:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354409AbiFMLfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354433AbiFML33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CDCDEC9;
        Mon, 13 Jun 2022 03:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C6F61016;
        Mon, 13 Jun 2022 10:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E316C34114;
        Mon, 13 Jun 2022 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655117080;
        bh=GEkAqDSx45s2LHhDPiB/BSff7zw8Jn2i+SxePh6pqgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjItmqZf7xKa77xre5UkrA/yOpxTnBkL1GfxBawlKA+BWYelsz9cYmi7s8r7iyD6I
         wk/hdPkr8dT5BswGzUYFU7U889/60UaIWcKvJcYMeFT4Lp1oiBO1AcUQ869eiLGo9Y
         eAg3pN+mETiLIEtP6gG8U0LIvga+CCxb4Jn0OEIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, TOTE Robot <oslab@tsinghua.edu.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 280/411] md: bcache: check the return value of kzalloc() in detached_dev_do_request()
Date:   Mon, 13 Jun 2022 12:09:13 +0200
Message-Id: <20220613094937.156132240@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094928.482772422@linuxfoundation.org>
References: <20220613094928.482772422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit 40f567bbb3b0639d2ec7d1c6ad4b1b018f80cf19 upstream.

The function kzalloc() in detached_dev_do_request() can fail, so its
return value should be checked.

Fixes: bc082a55d25c ("bcache: fix inaccurate io state for detached bcache devices")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20220527152818.27545-4-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/request.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1119,6 +1119,12 @@ static void detached_dev_do_request(stru
 	 * which would call closure_get(&dc->disk.cl)
 	 */
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
+	if (!ddip) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		bio->bi_end_io(bio);
+		return;
+	}
+
 	ddip->d = d;
 	ddip->start_time = jiffies;
 	ddip->bi_end_io = bio->bi_end_io;


