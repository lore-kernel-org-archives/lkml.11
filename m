Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 04:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiEEEgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 00:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbiEEEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:36:06 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33428E19
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 21:32:28 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5A1D027B;
        Wed,  4 May 2022 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651725148;
        bh=zEIuM0KnEuUErvwb/KL9ofxsEOyGFhOYXvbg9P4LPFg=;
        h=From:To:Cc:Subject:Date:From;
        b=VMTcg25Hjyon2Pr4qxk9q+6OB23okdgRe7hpgz8PNdMjUMnUyc/YPyugDUGgg0+k2
         hli+3PFvSD0/qsy+q5yqekcb2Jr+QWm6FHwTyoiX0gRF0XDHNxdSvOCTr8Myv0/Ywu
         lkiFXnr+EULqbRaG9jBKUzMAg4C5OqrzhGM6okIA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] regulator: core: Fix enable_count imbalance with EXCLUSIVE_GET
Date:   Wed,  4 May 2022 21:31:52 -0700
Message-Id: <20220505043152.12933-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of regulator->enable_count, a driver that did
an exclusive get on an already-enabled regulator would end up with
enable_count initialized to 0 but rdev->use_count initialized to 1.
With that starting point the regulator is effectively stuck enabled,
because if the driver attempted to disable it it would fail the
enable_count underflow check in _regulator_handle_consumer_disable().

The EXCLUSIVE_GET path in _regulator_get() now initializes
enable_count along with rdev->use_count so that the regulator can be
disabled without underflowing the former.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 5451781dadf85 ("regulator: core: Only count load for enabled consumers")
---

I tripped on this problem a bit in some recent experimentation with
the regulator API -- at first I figured I was misusing something, but
after looking a bit closer I *think* it's a bug (perhaps unnoticed
until now because EXCLUSIVE_GET doesn't seem to be very widely used),
but I'm not real knowledgeable about the regulator subsystem so
apologies if I've misdiagnosed.

 drivers/regulator/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d2553970a67b..c4d844ffad7a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2133,10 +2133,13 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		rdev->exclusive = 1;
 
 		ret = _regulator_is_enabled(rdev);
-		if (ret > 0)
+		if (ret > 0) {
 			rdev->use_count = 1;
-		else
+			regulator->enable_count = 1;
+		} else {
 			rdev->use_count = 0;
+			regulator->enable_count = 0;
+		}
 	}
 
 	link = device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
-- 
2.36.0

