Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D712EC43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354211AbiDEKMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A5A165AA;
        Tue,  5 Apr 2022 01:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36038B81BB1;
        Tue,  5 Apr 2022 08:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE06C385A2;
        Tue,  5 Apr 2022 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147335;
        bh=twSJ8PlR0JGEelnAB3cj1wJuxmgWcmI8h77gKBe/66Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yj+djiEbkNmLqjSbqLyLoh5aNvEqm6KWioqbSphEaBKsf5QCI5foh5wAjUWsPSJj4
         HVQpg91eIUkPVhYet6ytvlW9KUfCqpCXofx5Mzwmbc7WyWzvhbOhCj2tdHh9iQ4M5i
         BTxq+NDD8Xa0yjBamw3oqJz7Xh9dDqSGwrrWEndk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.17 1049/1126] block: Fix the maximum minor value is blk_alloc_ext_minor()
Date:   Tue,  5 Apr 2022 09:29:56 +0200
Message-Id: <20220405070438.261802306@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit d1868328dec5ae2cf210111025fcbc71f78dd5ca upstream.

ida_alloc_range(..., min, max, ...) returns values from min to max,
inclusive.

So, NR_EXT_DEVT is a valid idx returned by blk_alloc_ext_minor().

This is an issue because in device_add_disk(), this value is used in:
   ddev->devt = MKDEV(disk->major, disk->first_minor);
and NR_EXT_DEVT is '(1 << MINORBITS)'.

So, should 'disk->first_minor' be NR_EXT_DEVT, it would overflow.

Fixes: 22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/cc17199798312406b90834e433d2cefe8266823d.1648306232.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/genhd.c
+++ b/block/genhd.c
@@ -330,7 +330,7 @@ int blk_alloc_ext_minor(void)
 {
 	int idx;
 
-	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT, GFP_KERNEL);
+	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT - 1, GFP_KERNEL);
 	if (idx == -ENOSPC)
 		return -EBUSY;
 	return idx;


