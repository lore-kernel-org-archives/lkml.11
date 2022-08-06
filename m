Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF903C19F2D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 15:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiHFPVf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiHFPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:21:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD337DE80
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:21:29 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KLcFoPzRS4lbwKLcFoQo1p; Sat, 06 Aug 2022 17:21:27 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 17:21:27 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] netfilter: Fix a typo in a comment
Date:   Sat,  6 Aug 2022 17:21:26 +0200
Message-Id: <ad0d4d6fc856ace94130a0e6ab60c9a297f0a87d.1659799260.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/_IPT_LOG_H/_IP6T_LOG_H/

While at it add some surrounding space to ease reading.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/uapi/linux/netfilter_ipv6/ip6t_LOG.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h b/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
index 23e91a9c2583..0b7b16dbdec2 100644
--- a/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
+++ b/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
@@ -17,4 +17,4 @@ struct ip6t_log_info {
 	char prefix[30];
 };
 
-#endif /*_IPT_LOG_H*/
+#endif /* _IP6T_LOG_H */
-- 
2.34.1

