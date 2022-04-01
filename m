Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180EC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352772AbiDAPUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352603AbiDAOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:51:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5B2B4487;
        Fri,  1 Apr 2022 07:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7007EB8251F;
        Fri,  1 Apr 2022 14:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3477BC340EE;
        Fri,  1 Apr 2022 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824122;
        bh=YE12cUvIVXb3Uc3DidVzRG0U2wk/7bDcCFNx8boAYXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=coMtgrzTKuGJv96WMN4A6iVIe27s1qWOP4g7endAyyefnL5uqGo//IZeYON5WK/EB
         K+58D92yNvLzsXxseTsJtFp11SAHPTVV8J73bDTZZNZlBD+AI2qw9br07DpZVn1/6p
         BCJIqkpYNV/vIxyXIw8jvwGRbhMEebKAXuMFpbaXTeGzUdvajB9odvpg+aXa/Tj9W+
         cSn43EXR2m6lUYyN1kjVG7nCrvyquHUNu9+XlWVll5E8bnXTj8TcrUBnjPj8Vq/CTZ
         RSkdYAXsDlBieIK098Xrz6VilyRYBWuX68dzyqws8nosvDmcI27vT5wyWPJW9iMK+c
         UguUWBF4CljAQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, ahalaney@redhat.com,
        linux@rasmusvillemoes.dk, wangkefeng.wang@huawei.com,
        keescook@chromium.org, mark-pk.tsai@mediatek.com,
        valentin.schneider@arm.com, peterz@infradead.org
Subject: [PATCH AUTOSEL 5.15 97/98] init/main.c: return 1 from handled __setup() functions
Date:   Fri,  1 Apr 2022 10:37:41 -0400
Message-Id: <20220401143742.1952163-97-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143742.1952163-1-sashal@kernel.org>
References: <20220401143742.1952163-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f9a40b0890658330c83c95511f9d6b396610defc ]

initcall_blacklist() should return 1 to indicate that it handled its
cmdline arguments.

set_debug_rodata() should return 1 to indicate that it handled its
cmdline arguments.  Print a warning if the option string is invalid.

This prevents these strings from being added to the 'init' program's
environment as they are not init arguments/parameters.

Link: https://lkml.kernel.org/r/20220221050901.23985-1-rdunlap@infradead.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index b340d990d77c..06b98350ebd2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1198,7 +1198,7 @@ static int __init initcall_blacklist(char *str)
 		}
 	} while (str_entry);
 
-	return 0;
+	return 1;
 }
 
 static bool __init_or_module initcall_blacklisted(initcall_t fn)
@@ -1460,7 +1460,9 @@ static noinline void __init kernel_init_freeable(void);
 bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
 {
-	return strtobool(str, &rodata_enabled);
+	if (strtobool(str, &rodata_enabled))
+		pr_warn("Invalid option string for rodata: '%s'\n", str);
+	return 1;
 }
 __setup("rodata=", set_debug_rodata);
 #endif
-- 
2.34.1

