Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F2C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jun 2022 03:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiFRDxJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFRDxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:53:06 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A25FA13F65
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B5LgJ
        wZ+mPjWqyMswOQulY2y3abQQoRCtFlG8faFEGc=; b=HciIVu+Ell31IepjGrn5u
        YjpWgrElOwmr2apsZpgr2i8vWcESlPeufQOX5cTAQ5/Z4/dIKxLM7aFQpAddXgY3
        M+mKcE718LFuHLklYMXdJLmciBlDnq3Jt+uCCp7sI3LuypnAm+LJoGA2cNxfsjVi
        EnQir5HGUqpT83LeERjD5E=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowAA3R5_kS61isxLFDg--.40406S2;
        Sat, 18 Jun 2022 11:52:06 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, nick.child@ibm.com, npiggin@gmail.com
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: embedded6xx: Fix refcount leak bug in holly.c
Date:   Sat, 18 Jun 2022 11:52:04 +0800
Message-Id: <20220618035204.4057698-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAA3R5_kS61isxLFDg--.40406S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWruF43WryrCr13KrWDtwb_yoWfJrb_Xw
        n7Aan7Cr4Fqa1DZr1DZ3W3XFW8A3s5Gr4xGrnYqa12v3WfJa13Wr45tFy8uay8WrWYy398
        Ga1ktFWjkaySyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjksqtUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QckF1pEAOPbAAAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In holly_init_pci(), of_find_node_by_type() will return a node
pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/embedded6xx/holly.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 78f2378d9223..a4938505e89a 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -122,6 +122,7 @@ static void __init holly_init_pci(void)
 	np = of_find_node_by_type(NULL, "pci");
 	if (np)
 		tsi108_setup_pci(np, HOLLY_PCI_CFG_PHYS, 1);
+	of_node_put(np);
 
 	ppc_md.pci_exclude_device = holly_exclude_device;
 	if (ppc_md.progress)
-- 
2.25.1

