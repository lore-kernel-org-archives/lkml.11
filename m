Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbiBJUmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:42:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344289AbiBJUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:42:36 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E5108D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:42:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,359,1635199200"; 
   d="scan'208";a="5603083"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 21:42:32 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Andy Walls <awalls@md.metrocast.net>
Cc:     kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] media: cx18: use GFP_KERNEL
Date:   Thu, 10 Feb 2022 21:42:16 +0100
Message-Id: <20220210204223.104181-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220210204223.104181-1-Julia.Lawall@inria.fr>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pci_driver probe functions aren't called with locks held
and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.

Problem found with Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/media/pci/cx18/cx18-driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 59497ba6bf1f..1be9672ae9d4 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -899,7 +899,7 @@ static int cx18_probe(struct pci_dev *pci_dev,
 		return -ENOMEM;
 	}
 
-	cx = kzalloc(sizeof(*cx), GFP_ATOMIC);
+	cx = kzalloc(sizeof(*cx), GFP_KERNEL);
 	if (!cx)
 		return -ENOMEM;
 

