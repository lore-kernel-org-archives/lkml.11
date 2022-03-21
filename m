Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09D0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350925AbiCUQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350822AbiCUQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5179969280
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=KqOKmkSiv4XScF
        s86hoBk+u/08tcRXiCL6CqLW8A4xo=; b=2SNV0O58qpDM1YlOPb57qj0OOJ1tgw
        aQMRd6Gb9OXfxbXbrGmJpPmgaZvpHmBzkfYrLe6EImSTf/2HRzkEL62OVa9uhm+G
        2Hko1BFTM5mDQpvFFskCAiInGYE/lcjRofed1MoKNpRSxFyv0YfMfJrU68WTDma7
        8u6hRijoOt//Y=
Received: (qmail 957707 invoked from network); 21 Mar 2022 17:12:29 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:29 +0100
X-UD-Smtp-Session: l3s3148p1@xgpWw7zaHNkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 03/15] bus: mhi: core: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:11 +0100
Message-Id: <20220321161223.2837-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was just renamed to be easier understandable. No functional
change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 drivers/bus/mhi/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index ffde617f93a3..2a8d724e1445 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -54,7 +54,7 @@ int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
 		if (out == val)
 			return 0;
 
-		fsleep(delayus);
+		usleep_autoyield(delayus);
 	}
 
 	return -ETIMEDOUT;
-- 
2.34.1

