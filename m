Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350940AbiCUQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350874AbiCUQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8D68FB8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=ZF/5DkLLg4JB5G
        /b0aYVQ/D+wqP6oAiAQ+xCOCsTTQc=; b=IUEbapHp97buscEQL/BaRHHUTDr2Yy
        l5+rn7+1+m27S/cdp6+f1ZY/mD4cXumVba9ef/aRWGN/w2aXDYEUDl/2Z4yhMHaZ
        e8e7HZNmc4qQyelqAt5HxQaQb+qHrId37lWCBZjRh19WHUjzwPtT/NqwUsYKyRr6
        A9kFogw/eB4FM=
Received: (qmail 958006 invoked from network); 21 Mar 2022 17:12:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:35 +0100
X-UD-Smtp-Session: l3s3148p1@bTeow7zaNNkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 13/15] thermal: tegra: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:21 +0100
Message-Id: <20220321161223.2837-14-wsa+renesas@sang-engineering.com>
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

 drivers/thermal/tegra/tegra30-tsensor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 9b6b693cbcf8..705981f74a8d 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -105,7 +105,7 @@ static int tegra_tsensor_hw_enable(const struct tegra_tsensor *ts)
 		return err;
 	}
 
-	fsleep(1000);
+	usleep_autoyield(1000);
 
 	err = reset_control_deassert(ts->rst);
 	if (err) {
-- 
2.34.1

