Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5834C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 03:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiGZDG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiGZDGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:06:54 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982110578;
        Mon, 25 Jul 2022 20:06:51 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [113.118.189.34])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id B41D9800089;
        Tue, 26 Jul 2022 11:06:49 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/3] dt-bindings: soc: update MT7623A power dt-bindings
Date:   Tue, 26 Jul 2022 11:06:19 +0800
Message-Id: <20220726030621.7555-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxpNVkoZGUgeS09DHktPSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVKSkNVSkNCVUhPWVdZFhoPEhUdFFlBWU9LSFVKSEpCSE1VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6Lxw6IT0rOE4MGUgNNx4u
        K0wwFBhVSlVKTU5DQ0tPQ0pLSENNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SFVKSkNVSkNCVUhPWVdZCAFZQUpCS0M3Bg++
X-HM-Tid: 0a823878b113b03akuuub41d9800089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new power domains(VDEC/DISP/ISP/BDP)
for MT7623A from MT7623 side.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 include/dt-bindings/power/mt7623a-power.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/power/mt7623a-power.h b/include/dt-bindings/power/mt7623a-power.h
index 2544822aa76b..27d198e207b7 100644
--- a/include/dt-bindings/power/mt7623a-power.h
+++ b/include/dt-bindings/power/mt7623a-power.h
@@ -6,5 +6,9 @@
 #define MT7623A_POWER_DOMAIN_ETH	1
 #define MT7623A_POWER_DOMAIN_HIF	2
 #define MT7623A_POWER_DOMAIN_IFR_MSC	3
+#define MT7623A_POWER_DOMAIN_VDEC	4
+#define MT7623A_POWER_DOMAIN_DISP	5
+#define MT7623A_POWER_DOMAIN_ISP	6
+#define MT7623A_POWER_DOMAIN_BDP	7
 
 #endif /* _DT_BINDINGS_POWER_MT7623A_POWER_H */
-- 
2.25.1

