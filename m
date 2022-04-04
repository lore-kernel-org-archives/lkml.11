Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F84C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 14:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377135AbiDDO0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377107AbiDDO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:26:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCEA33E82
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:24:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t4so8488731pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Pt7hrdGVjbeZjOBpknKDovgV8m2sdxjtHmhHuyy54SA=;
        b=Ibxp+1UIhOCnKUdny+f1j8gRzydc/TreU0vWzbOhAGB3zG2v8l18+yu4aENjio/OUO
         U5HvjbAyzUeD6jZD8QiRah49VcAHJoW7S2ha4tG0SNKdTf8Q4tQBDudXHVlATctr0OB0
         1d6g9fSHGlRHsSzsLyAEkAXQ6GhtboHwmN93lmFzTw+oPHfApgOtuOAvzYZ3PdoUNDAr
         z7X+RmSYpXLQgqIOxMLDcJvmaFuWHvL2y5ctWeAJtjZGqCo1Fkk+msCsLJ57/Ev9uRpL
         E6ebqmlHE4dz6LfHFleG44IcGP5+lZNEOn6rp+hf7dZ20a3bMmXCQpedLwZTv3702SuF
         kh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pt7hrdGVjbeZjOBpknKDovgV8m2sdxjtHmhHuyy54SA=;
        b=zHeAp9YOYQ4tZ4jiRdy45PlNVdyq+tu+xe1xbr592PTtP5W6/PeSLZOt7WX87eXcu3
         pqoK4mDIfYR9qpwMFY/x6NMQ0GAkXmcknTOjzfbVwg076Bogxc7FyY7kPhXfeM2DNIcQ
         wzdSez4+JK8zM5pNrDBrBhAsthsnsOk5qFTw8MrOwN9P+VEppOf+yxBUWg09gXXIeX0+
         uN0a1oxhCgVPvQdqxRWoJEssOjGS0AfOVN3ZfcwM0aq910g5Lndn3pJTUhVJatFB0Zyb
         9kMa+8HTGzdFIaUZBxYlcwO2i9mq+YXlllK+lkFcm10DlYqjlJViUQ/WXgu6VW6OBV8/
         poRg==
X-Gm-Message-State: AOAM530hABYSh7O0yJijvnUcLbBcLHTl/7rg68OPf0mKp2PmFrJGljJK
        eaL+9SjYUozUDSmLZxIkCy0=
X-Google-Smtp-Source: ABdhPJzcpSKZIQN1bpipplS8MHxtv1HBy+Tf1pQY65MHBC1+O6gQM1dyk2JubkRCefhsocGp409b9w==
X-Received: by 2002:a63:ad45:0:b0:382:2459:5bc6 with SMTP id y5-20020a63ad45000000b0038224595bc6mr123838pgo.474.1649082272439;
        Mon, 04 Apr 2022 07:24:32 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm12513182pfc.214.2022.04.04.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:24:32 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] bus: fsl-mc: Check the platform_get_resource() return value
Date:   Mon,  4 Apr 2022 14:24:26 +0000
Message-Id: <20220404142427.11418-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource() may fail and return NULL, so check it's value
before using it.

Fixes: 6305166c8771 ("bus: fsl-mc: Add ACPI support for fsl-mc")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..ab520b4ce885 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1168,6 +1168,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	 * Get physical address of MC portal for the root DPRC:
 	 */
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!plat_res)
+		return -EINVAL;
+
 	mc_portal_phys_addr = plat_res->start;
 	mc_portal_size = resource_size(plat_res);
 	mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
-- 
2.17.1

