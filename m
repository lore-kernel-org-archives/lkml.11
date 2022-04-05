Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F89C43217
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356759AbiDEKYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiDEIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0C60E8;
        Tue,  5 Apr 2022 01:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8070B81BB1;
        Tue,  5 Apr 2022 08:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFCAC385A1;
        Tue,  5 Apr 2022 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147426;
        bh=lAtKoaS9HUgr0Lm7QE70qsSO+vReFYiIsn0xRlig5Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4ekw+tIOnrBly1sz2cVMn7rCfeTMLTBui3S5KgJq5sggua/OEdFuEZwRH3Bfmua0
         +aUU3yXiT7cY3opub/p735aJnFYMiSfdiYOOkmTqXGjz4NQAGj4ksXGbDK15JgB4fk
         FX+tmeLPQJ3FEoGNeaPyvAUobcK7aSLQjStfEiR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.17 1119/1126] n64cart: convert bi_disk to bi_bdev->bd_disk fix build
Date:   Tue,  5 Apr 2022 09:31:06 +0200
Message-Id: <20220405070440.274077725@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

commit b2479de38d8fc7ef13d5c78ff5ded6e5a1a4eac0 upstream.

My kernel robot report below:

  drivers/block/n64cart.c: In function ‘n64cart_submit_bio’:
  drivers/block/n64cart.c:91:26: error: ‘struct bio’ has no member named ‘bi_disk’
     91 |  struct device *dev = bio->bi_disk->private_data;
        |                          ^~
    CC      drivers/slimbus/qcom-ctrl.o
    CC      drivers/auxdisplay/hd44780.o
    CC      drivers/watchdog/watchdog_core.o
    CC      drivers/nvme/host/fault_inject.o
    AR      drivers/accessibility/braille/built-in.a
  make[2]: *** [scripts/Makefile.build:288: drivers/block/n64cart.o] Error 1

Fixes: 309dca309fc3 ("block: store a block_device pointer in struct bio");
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20220321071216.1549596-1-liu.yun@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/n64cart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -88,7 +88,7 @@ static void n64cart_submit_bio(struct bi
 {
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	struct device *dev = bio->bi_disk->private_data;
+	struct device *dev = bio->bi_bdev->bd_disk->private_data;
 	u32 pos = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
 	bio_for_each_segment(bvec, bio, iter) {


