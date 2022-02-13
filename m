Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639B9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 16:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiBMQ6s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 11:58:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiBMQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:58:43 -0500
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A195C34D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 08:58:37 -0800 (PST)
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 21DGvOv0024736;
        Mon, 14 Feb 2022 01:57:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 21DGvOv0024736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644771445;
        bh=aE1Z5Wnu3OhpIzmO3LuF2exqHkI8SQj4E6ygpDDb5Hs=;
        h=From:To:Cc:Subject:Date:From;
        b=D8Ww2NjH02SFZBcgxXUVVOM3947jbUmKvg/tDIVebDGLfDrk8b/YoinKObWkF5DgZ
         uR2cih55H6S5HNTaOOIvKOsj002N4n8Ww10DxdWmDjEeReZuOpEn9N6GEvBsWm+TUE
         WEcZOgaWBwt/epxT7OOA87GaFqaqG9mO3hwjpL/7twlGpffJkWdSEyY0AwJPLjBlGJ
         n5SEL86ri0zq119fc5WfaV64xzVh780qE9kFxPZ7jnZGn5EuzNIXS8tJFbNjthTn44
         KGsOHdJih0D5WgNFx0F/do9J7o9PwjTM1ZtAmWKrbjWOBhFtkV+a1PsJgyKk944/JM
         1KRPRrVY8LmjA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] jump_label: avoid unneeded casts in STATIC_KEY_INIT_{TRUE,FALSE}
Date:   Mon, 14 Feb 2022 01:57:16 +0900
Message-Id: <20220213165717.2354046-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3821fd35b58d ("jump_label: Reduce the size of struct static_key")
introduced the union to struct static_key.

It is more natual to set JUMP_TYPE_* to the .type field without casting.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 48b9b2a82767..6924e6837e6d 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -251,10 +251,10 @@ extern void static_key_disable_cpuslocked(struct static_key *key);
  */
 #define STATIC_KEY_INIT_TRUE					\
 	{ .enabled = { 1 },					\
-	  { .entries = (void *)JUMP_TYPE_TRUE } }
+	  { .type = JUMP_TYPE_TRUE } }
 #define STATIC_KEY_INIT_FALSE					\
 	{ .enabled = { 0 },					\
-	  { .entries = (void *)JUMP_TYPE_FALSE } }
+	  { .type = JUMP_TYPE_FALSE } }
 
 #else  /* !CONFIG_JUMP_LABEL */
 
-- 
2.32.0

