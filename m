Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E800C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 14:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiCAOug (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiCAOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:50:33 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CD546B0D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646146192;
  x=1677682192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OVXnHx1+bUpU3p6Ka0LCONj//t9wynbM77Xx3/5dJlE=;
  b=mMUYuhObYXgSSYr7J1qyb5m7aJ0+/Flg6J6J7WYTjkvf5yynlczR/NF5
   vh3h0bb2DUJwQfSuBj3TRnSgcvwypT6gVBwpwXjG9Op4jTqJTg8OqWHyY
   uiB9pHdVXZpJt3tOzrsLckMo5z2Tf6ZAXNHmPWD45jl/mwyWFSt78fb8q
   NDVgIuN5uKHrxPMPc4Kr6Ww7lhKW40DHhOdGF7HRpjND1llXzM2wePhLp
   1+vJfRqEXwiFBHuE/MyusDRRfxK0b1vFKv24OpC5EefYCnCZcfW+bcVEM
   lWm738BcP9rKR9QUhZ3MYq3QNtpXSTp79EyPUOxzoDMvSN7is7BRWm3MA
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pstore: Add prefix to ECC messages
Date:   Tue, 1 Mar 2022 15:49:32 +0100
Message-ID: <20220301144932.89549-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "No errors detected" message from the ECC code is shown at the end
of the pstore log and can be confusing or misleading, especially since
it usually appears just after a kernel crash log which normally means
quite the opposite of "no errors".  Prefix the message to clarify that
this message is only about ECC-detected errors.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/pstore/ram_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index fe5305028c6e..a89e33719fcf 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -263,10 +263,10 @@ ssize_t persistent_ram_ecc_string(struct persistent_ram_zone *prz,
 
 	if (prz->corrected_bytes || prz->bad_blocks)
 		ret = snprintf(str, len, ""
-			"\n%d Corrected bytes, %d unrecoverable blocks\n",
+			"\nECC: %d Corrected bytes, %d unrecoverable blocks\n",
 			prz->corrected_bytes, prz->bad_blocks);
 	else
-		ret = snprintf(str, len, "\nNo errors detected\n");
+		ret = snprintf(str, len, "\nECC: No errors detected\n");
 
 	return ret;
 }
-- 
2.34.1

