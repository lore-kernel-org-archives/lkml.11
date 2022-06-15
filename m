Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 15:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiFOPeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348988AbiFOPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:34:15 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAA7B2251F;
        Wed, 15 Jun 2022 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qA/Mf
        K70pcaP6AdlLT8hpxzBJq/0hmiFokmu1lnak5Y=; b=kdp19rkbRAjsm89x+oNg/
        9HneJ0oosgWT6JsWkGvnpa07MAO+P331qVi9niDbbh49ppafRhliZoQ05WkMKbUq
        HSOw230L2Vx9Q5ErHtL2nbJLzuREMN7Q9QYSZ0sFesVScuwDe2dtJqorZ5pQdcbV
        U3Frp0AWT66w7laTINfDus=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgD3+0PT+6liQETOEg--.51059S2;
        Wed, 15 Jun 2022 23:33:41 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     john@phrozen.org, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] mips: lantiq: Add missing of_node_put() in irq.c
Date:   Wed, 15 Jun 2022 23:33:39 +0800
Message-Id: <20220615153339.3970658-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgD3+0PT+6liQETOEg--.51059S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1rCry8Gw45uFykCFy7GFg_yoWDGFXEg3
        WIgr9rG3yrJ3WrJrZruw4agFs8A397WFyrA3Z2yFySy3W3A3WDtr47Jr17A3yUXF4SvFW5
        Cr1Dur4Yvw429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRK0eHtUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hUhF1uwMNZANgAAsC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In icu_of_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/lantiq/irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index b732495f138a..62f1b20a2169 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -396,6 +396,9 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 
 		ret = of_property_read_u32_array(eiu_node, "lantiq,eiu-irqs",
 						ltq_eiu_irq, exin_avail);
+						
+		of_node_put(eiu_node);
+						
 		if (ret)
 			panic("failed to load external irq resources");
 
@@ -409,6 +412,9 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 			panic("Failed to remap eiu memory");
 	}
 
+	/* if eiu_node&of_address_to_resource */
+	of_node_put(eiu_node);
+
 	return 0;
 }
 
-- 
2.25.1

