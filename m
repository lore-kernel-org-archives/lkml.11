Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A374C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 16:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbiBJQJF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:09:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243993AbiBJQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:09:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37995EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:09:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB20B82502
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14460C004E1;
        Thu, 10 Feb 2022 16:09:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HfKQgM/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644509340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N3dD0tXTnwc6MdQY+PdYpzjIVrGQYs8c4jWPh9hZHek=;
        b=HfKQgM/hERoqZsQgCs248B+K69sHJaJY8+v7V5Yuz4JU2Ljp23b/NeKHFzjYHyj8hibV0J
        mCj7PDfaqMwk09oOMT6rdBV7uLSSiHZ7Jp/wS1hGDp/XOFR1TsTlZe7WFNuJ6BIl8gFmzZ
        6dLN2hd2Pg3Hb7w57W9YLTnQImMsxZo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5f28fc4d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 16:09:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/2] make irq collector clearer
Date:   Thu, 10 Feb 2022 17:08:53 +0100
Message-Id: <20220210160855.156548-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial series moves functions around and introduces a union rather
than having manual bit arithmetic.

Jason A. Donenfeld (2):
  random: move fast_pool/fast_mix definitions to site of use
  random: deobfuscate irq u32/u64 contributions

 drivers/char/random.c | 141 ++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 67 deletions(-)

-- 
2.35.0

