Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54197C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352070AbiHWKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352382AbiHWJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689BA1A59;
        Tue, 23 Aug 2022 01:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C376155E;
        Tue, 23 Aug 2022 08:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C5C433C1;
        Tue, 23 Aug 2022 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244450;
        bh=PYhSPsobpJ6kkl+Qsx5f0HgJelQ0xIq3RmooO9CvX2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUJym/ModyYir2k1KqEWiEY4UP2fdakpTc2z5dyHj8qqjNWoqeHUfkhj40blHyto/
         8FPH0lltya8FV3cUyuMuR5K7DH3ByHtj/V4uZBTctp+M2t/qBTwCAaH4MHZgXprQvZ
         RRQQZIWz2RP1AXAV1qIywL4PJx7N/b2Dmu07JzB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 139/229] powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
Date:   Tue, 23 Aug 2022 10:25:00 +0200
Message-Id: <20220823080058.655478858@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080053.202747790@linuxfoundation.org>
References: <20220823080053.202747790@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit df5d4b616ee76abc97e5bd348e22659c2b095b1c ]

of_get_next_parent() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() in the error path to avoid refcount leak.

Fixes: ce21b3c9648a ("[CELL] add support for MSI on Axon-based Cell systems")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220605065129.63906-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/cell/axon_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 6ea3f248b155..e98b61c06a81 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -230,6 +230,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 	if (!prop) {
 		dev_dbg(&dev->dev,
 			"axon_msi: no msi-address-(32|64) properties found\n");
+		of_node_put(dn);
 		return -ENOENT;
 	}
 
-- 
2.35.1



