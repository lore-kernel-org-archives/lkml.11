Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiCUQOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbiCUQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F562C668
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=SKbhtQauDIu8IW
        sUX7r8Xzf/TTppMbLtpDDbTHDOTzI=; b=L+wXwqnhdQUCIdqmciIvH21TBIgwHl
        0dTRNA9rYiS1/MzXJeEkE84lDJskM2OWsAIjJ+4VVL5ZtvDmZHOk63xZz9CJO6Ox
        8TOZjKipbbm5YqVSS3LCB76CWL6i0DWZhv4yG5O1TolcdJVxXPpgZr12auciVO6r
        pa835YEQ9wN1U=
Received: (qmail 957647 invoked from network); 21 Mar 2022 17:12:28 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:28 +0100
X-UD-Smtp-Session: l3s3148p1@apNEw7zaGNkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 01/15] delay: rename fsleep to usleep_autoyield
Date:   Mon, 21 Mar 2022 17:12:09 +0100
Message-Id: <20220321161223.2837-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fsleep because the current name breaks the pattern of the first
letter being a unit (and it is not 'femto' here). Let's add the proper
unit again and add a suffix to the function which will hopefully be a
bit more explanatory. To give some time until all users are converted,
introduce a fallback define which will go away later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 Documentation/timers/timers-howto.rst | 2 +-
 include/linux/delay.h                 | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
index 5c169e3d29a8..d0a57ca5e18e 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -112,4 +112,4 @@ NON-ATOMIC CONTEXT:
 			you know you have a need for the interruptible variant.
 
 	FLEXIBLE SLEEPING (any delay, uninterruptible)
-		* Use fsleep
+		* Use usleep_autoyield
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 039e7e0c7378..d0919f52fec8 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -78,7 +78,7 @@ static inline void ssleep(unsigned int seconds)
 }
 
 /* see Documentation/timers/timers-howto.rst for the thresholds */
-static inline void fsleep(unsigned long usecs)
+static inline void usleep_autoyield(unsigned long usecs)
 {
 	if (usecs <= 10)
 		udelay(usecs);
@@ -88,4 +88,6 @@ static inline void fsleep(unsigned long usecs)
 		msleep(DIV_ROUND_UP(usecs, 1000));
 }
 
+#define fsleep usleep_autoyield
+
 #endif /* defined(_LINUX_DELAY_H) */
-- 
2.34.1

