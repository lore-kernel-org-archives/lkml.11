Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B12C32772
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiHUPDD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:03:01 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E21EECA;
        Sun, 21 Aug 2022 08:02:58 -0700 (PDT)
X-QQ-mid: bizesmtp80t1661094173tcdp0liw
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:02:52 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: ILHsT53NKPhWA15NkJVoU6YTuW0GZIQAAgiwpPdGSSnCdIYNC9ZRv2gVekCbc
        ylDclXo+J46uVX6k76FssukFSGFte7zlN23Kh5EEfSeL4B7yRtaoinn7R9SjpeScePNysa/
        1ZV7Qpl2kBC1YgZEYepajx7YOLeYmxUGoPa64O4rQmqkU6dFEDpJx4o8lPBFqmzQ4jILTEO
        JKdYg71C9DMwKG5BMOLZn8YjAd9xR90iGVFiN2awwbuUDLIQPYrB1wex4SbCCfq/Okv5qoR
        /W7QnOvclchQuvl9A8pL0L3RfPG4QdZPkqsJxprSxmWI4Tif+iUao7EFgtouDv6F3vSKX9S
        WPpjL+HDJLwg9E9gIHkdhgYAMu/wiM0RikYNkuN/8kp7cy48dI=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mips/sgi-ip22: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:02:46 +0800
Message-Id: <20220821150246.51164-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 38d12f417e48..03d96638f957 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -41,7 +41,7 @@ static struct device gio_bus = {
 /**
  * gio_match_device - Tell if an of_device structure has a matching
  * gio_match structure
- * @ids: array of of device match structures to search in
+ * @ids: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an of_device present in the
-- 
2.36.1

