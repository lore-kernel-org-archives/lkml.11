Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7674FCCA47C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391107AbiFHBwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382703AbiFGWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:03:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6D252C0C;
        Tue,  7 Jun 2022 12:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 307C5B822C0;
        Tue,  7 Jun 2022 19:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C2C385A2;
        Tue,  7 Jun 2022 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629329;
        bh=oXpLKd/DALznNGwvJ+rgzx7UyoKE6EsnxDc4+u+dhNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVIeXRJrmUotg0n5AH+6rcTLEAi/R7Rf6j1nVrmnDrlAxAN+WaSfSvgy7lWcyn0DE
         P3lKTFPF/YWDLvwtUl1eYQtaPBuSiDZOLZOMzJwSD/drKrsTULxNTHVReMNV4Q0HqA
         /CwUjRCgOGOHivfSKFBvLIOqUkVQ/1IMHC8PlOVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 652/879] RDMA/rxe: Fix an error handling path in rxe_get_mcg()
Date:   Tue,  7 Jun 2022 19:02:50 +0200
Message-Id: <20220607165021.772480272@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 7f60951ff4d1664dfa2c304d144d195989199ef3 ]

The commit in the Fixes tag has shuffled some code.
Now 'mcg_num' is incremented before the kzalloc(). So if the memory
allocation fails, this increment must be undone.

Fixes: a926a903b7dc ("RDMA/rxe: Do not call dev_mc_add/del() under a spinlock")
Link: https://lore.kernel.org/r/fe137cd8b1f17593243aa73d59c18ea71ab9ee36.1653225896.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 873a9b10307c..86cc2e18a7fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -206,8 +206,10 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 
 	/* speculative alloc of new mcg */
 	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
-	if (!mcg)
-		return ERR_PTR(-ENOMEM);
+	if (!mcg) {
+		err = -ENOMEM;
+		goto err_dec;
+	}
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just added it */
-- 
2.35.1



