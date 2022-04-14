Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27749C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 10:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiDNKhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiDNKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:37:18 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB1E49925
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649932495;
  x=1681468495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JB1JYKc2t7KYR3hxZpxMRwToN5ZsCx2BtRr9rtxcR4s=;
  b=k0gsXxemTvYCzUW65GW6incsDpOzywJhHtBBDV3Ii+LS+6s5izQHIUC6
   Tpz1GkfCbWVnsfWU8CCCOfBr/7CMTB65RtdLCuFsybd65aBhGWmfzwWMJ
   yeMVF6fyGIoxKajk3UyZzGORIp3+lCsBcvIZpyuMtAO3vLo9ghAd2hhZf
   4ucu6XrIne+S1TjvdUkQj4MDlXppOHp9wxVJFgN7Q2Ayrd2oakePpUFUo
   9TKRsr/n1kuqNAmskkUt9QIzCMZndbXusnkY0rZhzjPSi1F1Xn0H1fOwQ
   J4uttvmrcyGsI5aZP8LyAL5TfdXGCaSqq1ClSAD22JKkQtj8G1J6lZ/ir
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: enable ARCH_HAS_GCOV_PROFILE_ALL
Date:   Thu, 14 Apr 2022 12:34:51 +0200
Message-ID: <20220414103451.1662906-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARCH_HAS_GCOV_PROFILE_ALL so that CONFIG_GCOV_PROFILE_ALL can be
selected on UML.  I didn't need to explicitly disable GCOV on anything
to get this to work on the configs I tested.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4d398b80aea8..8062a0c08952 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_EPHEMERAL_INODES
+	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-- 
2.34.1

