Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E4ECAAD4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiHaVSh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHaVSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:18:33 -0400
Received: from server.lespinasse.org (server.lespinasse.org [63.205.204.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24794E0FC5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-83-ed;
 t=1661980711; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=EIkkMFs4sIWKssfSNTOzhO+kTBYbdsRJaTCSHYW0Ch0=;
 b=gSqVZ+SmMaoPDYgt8MdFoinD5wP2S76LO+D+5R3+tCR+K8W97mMxuJrFxurggN0TH6h+L
 UnlcgWe/a81okHOBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-83-rsa; t=1661980710; h=date :
 from : to : cc : subject : message-id : mime-version : content-type :
 from; bh=EIkkMFs4sIWKssfSNTOzhO+kTBYbdsRJaTCSHYW0Ch0=;
 b=HzO+HykJrTNDbxNUrHxNGpGNqrAoK1HtMmSgKfX5LdehdR1852JhlcR9ehGn0/XCkxV0w
 m8Pmi7AKxIXNTzBOo8JVPiegR/GLYCE9jX81fpmUSYUELOHBhsslef4f9NX0Orox7hKecPn
 4XNg+TVm1pf9G/tBiGtnQfOGGdMgG1FZM4w5CJQXfb11YGHaGWDGKwEs8TIjLMxFWnfGyNO
 yJAhqGR7h0z/tb7XjaO6cS9M4BeMke5rk5uK6RT9ykrmtvj5kXMLm/juX2SvdRbow9+mLup
 pnkdwIvyXITEYQne7hN0FgtAiIYD69MOEVSsvchpt5+HvEz0T078jhne7Q3Q==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id ED80F160522; Wed, 31 Aug 2022 14:18:30 -0700 (PDT)
Date:   Wed, 31 Aug 2022 14:18:30 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH] Remove unused variable i in process_mem_region()
Message-ID: <20220831211830.GA16578@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiny fix for a build warning. Could you get this queued ?

---------------------------- 8< -----------------------------------

This avoids a build warning when CONFIG_MEMORY_HOTREMOVE or CONFIG_ACPI
are unset.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/boot/compressed/kaslr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 4a3f223973f4..5ae2ecb16ad7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -624,7 +624,9 @@ static bool process_mem_region(struct mem_vector *region,
 			       unsigned long minimum,
 			       unsigned long image_size)
 {
+#if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
 	int i;
+#endif
 	/*
 	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
 	 * use @region directly.

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.20.1
