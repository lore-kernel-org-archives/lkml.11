Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59638C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 14:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiFFOMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiFFOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:11:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2669227FD2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7ABC61375
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AE0C3411C;
        Mon,  6 Jun 2022 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524717;
        bh=jEFcX4+rGobfNa0MECgKONfbmATsAGer9hHBokT4s5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tk2F0WXXTci5g5Ag501ao+8yKFGIEhoEAodqi9ePh1wX6HgIoeJVv+DTNhSxMNMU3
         Avq4i5/1UBm8a1XWTBW6oQB6FUJf1nhymkWYPJQoxAXG2TgAc9YGUo37XkvPeiPB+k
         ePRDONbAdVao5Uh0Ynq7XRrVPgj5qKdar+EIepL9S/Leg2wttJ1JGfIshZEFldLDqU
         XeVQISK2J5fh4mWl8PqxkMF2xtPyfvLlVuWZl/wmsClpnBTKF537xKAtkC0CEnb9fR
         3BRk7MCVjezwq9oixFjgRF0Gdc804skcEfPOvaAVIbRMoEikdNzQr8RXzhX8n+lHC2
         zvZUIRY2uQLig==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] platform/chrome: cros_ec_commands: fix compile errors
Date:   Mon,  6 Jun 2022 14:10:39 +0000
Message-Id: <20220606141051.285823-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606141051.285823-1-tzungbi@kernel.org>
References: <20220606141051.285823-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile errors when including cros_ec_commands.h solely.

1.
cros_ec_commands.h:587:9: error: unknown type name 'uint8_t'
  587 |         uint8_t flags;
      |         ^~~~~~~

2.
cros_ec_commands.h:1105:43: error: implicit declaration of function 'BIT'
 1105 |         EC_COMMS_STATUS_PROCESSING      = BIT(0),
      |                                           ^~~

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 include/linux/platform_data/cros_ec_commands.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 8cfa8cfca77e..a5b749a85707 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -13,8 +13,8 @@
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
-
-
+#include <linux/bits.h>
+#include <linux/types.h>
 
 #define BUILD_ASSERT(_cond)
 
-- 
2.36.1.255.ge46751e96f-goog

