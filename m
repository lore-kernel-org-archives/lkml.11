Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 17:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377085AbiCYRE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCYREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:04:46 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 10:03:09 PDT
Received: from mx.msync.work (mx.msync.work [51.91.38.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9963F1;
        Fri, 25 Mar 2022 10:03:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 677A331FD6;
        Fri, 25 Mar 2022 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648227312; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=lMkPsT9wmYQRWVhCSgEyUxO6l9DD/Z5L18efF0PKVNA=;
        b=dcqdVUFBtvhsacFMgAMkygcIlC6DX6JtyTQiKOlNvVW7ItoUlu9jRvO7CUo1Gbkfjp9sR+
        +2UkQ+xtF2LXicdMdspMCR41L7L11So7fW/nWK/OAlb1Gs77cV0BanUY724A31VsZP71s8
        ja35hInBOhj27KWmH2lo2tHZVPMlQ4m8gq9JK41YmGes8oDLtqkOulzOqijnS0DGUn2T4t
        poP1Rwpevyx4Yoywn9daf3jHIIXwHaGxiNgTGHu5GDtuHVt4o7nPCNOOMtVn6kyKm8eweR
        D7a2OqQeW7BD+PSiJYa7AbgtToPw7MtbFLyLc0EEIAe/o+js273bkk7TboUyrw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] arm64: meson: dts: update serial alias in dts for JetHub D1
Date:   Fri, 25 Mar 2022 19:55:00 +0300
Message-Id: <20220325165501.81551-3-adeep@lexina.in>
In-Reply-To: <20220325165501.81551-1-adeep@lexina.in>
References: <20220325165501.81551-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change zigbee serial port alias to ttyAML2 for backward compatibility.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index 52ebe371df26..66c1eeba8f48 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -18,7 +18,7 @@ / {
 	model = "JetHome JetHub J100";
 	aliases {
 		serial0 = &uart_AO;   /* Console */
-		serial1 = &uart_AO_B; /* External UART (Wireless Module) */
+		serial2 = &uart_AO_B; /* External UART (Wireless Module) */
 		ethernet0 = &ethmac;
 	};
 
-- 
2.30.2

