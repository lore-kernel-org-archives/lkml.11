Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA49DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 09:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiBWJ23 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiBWJ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:28:26 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B71FA66
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:27:59 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 8so7309722qvf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhQOAPGriaJ90awBuK8zqjdKv78PGZubmhSGXhOpsOU=;
        b=WYvmz1X6IIdRaJ23Vh2yQ2n13gh/YEBa6QbFeHL6Hg+tvYpNdPGs2Yu2PPKeeQv3+e
         qG22nPSJTrT257gOYx3Q38lCw72iwtPISJGPnbgOEWf4UrqUHUHHbaVmX5J91ZsHMny+
         Sf3SSmoVt9kuW+aJgpPzk/jWHEDn9VVfEboLyY6dLhgY7/1+OzK7mtRhmy7uSCFijIyr
         DPNPZ27GmcW3LA2PNV5QhivEIZNmfxLb4ijyB22M7eliIcOyJr7/0jBgSVrvUeZALUDY
         E/A86W3bkAxbwJcOisoR85JnOvJ8yv2gCX0OOuRYnIFIjW3gguw2auSFMBFgjZsy27Zc
         LYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhQOAPGriaJ90awBuK8zqjdKv78PGZubmhSGXhOpsOU=;
        b=bTzY013irEPlkq3bGR6u3FP+5X7Ka5ZBdY4yqbWURuOzKARZGR8po5uNTJK5mX0TC3
         BmJrfeScW5QyZSllWtKH8LnMI9aClml64W/O+azzpUvvEH1fIR82N3C4O//3Y84iP+Q5
         Pd5ClVTwJ6uIjZjt1Am2sfubo/h6tBIhRliU4qymSdjCP73otxkhSXif3zpPvTTXlwgm
         72MbZTxkFx12noJWHY8zw+Z3DVdwPR+DjRlghLO3VkYPjHYoaV03TlJgWritIr7pYKgz
         FhVhNFZTPFWdaAXAVydwerqjJVXdnUO7RRXlG+Lk4m/yLJlPzC7IovvsM5+QdhVx/Nqk
         zCcA==
X-Gm-Message-State: AOAM532hbAMPUDkZgSjAbwD1LClsOpdmUj5mD8MhHElv2hAPnjU1WuRN
        LtbNIAK1ErpVa8L+8+s5uX4=
X-Google-Smtp-Source: ABdhPJysnuY1B6OBDOm07qZYHEzp4gc3FPKgkCLtJYvJiUsHxlwskqu3IAXmibYmkfhtVSIXogVIHg==
X-Received: by 2002:a05:622a:1452:b0:2de:6ed5:6230 with SMTP id v18-20020a05622a145200b002de6ed56230mr4682893qtx.619.1645608479002;
        Wed, 23 Feb 2022 01:27:59 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 18sm1691485qtx.88.2022.02.23.01.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:27:58 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] KVM: arm64: Remove unneeded semicolon
Date:   Wed, 23 Feb 2022 09:27:50 +0000
Message-Id: <20220223092750.1934130-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./arch/arm64/kvm/psci.c: 379: 3-4: Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/arm64/kvm/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 0a00ef250725..3b16dae4ab3d 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -376,7 +376,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 				ret = 0;
 			}
 			break;
-		};
+		}
 		fallthrough;
 	default:
 		return kvm_psci_0_2_call(vcpu);
-- 
2.25.1

