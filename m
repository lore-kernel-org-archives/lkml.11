Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385896AbiBGLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383136AbiBGLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:21:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA10C043189;
        Mon,  7 Feb 2022 03:21:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA644B811BE;
        Mon,  7 Feb 2022 11:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDBAC004E1;
        Mon,  7 Feb 2022 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232892;
        bh=L3njw7D1h60xj4ZtXZ2nQPYXAjn8bemYgbJCbuB78r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3zN6vrFr61rXRjBnvAxC2wCTqHhTHwU9IX7psjGx4bMUHH0MlO+GfRVPivRfHIxW
         Oy2fb3Sc3FpBbAgVKN2c12VmmPzFrFymjZbnFhwMMhoGGHb0IouVK3Odt4Nocpz+2S
         jlt8yIbeppdeuNDK0yOIPY4XXFRWs0XujfvCfdtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.10 25/74] RDMA/cma: Use correct address when leaving multicast group
Date:   Mon,  7 Feb 2022 12:06:23 +0100
Message-Id: <20220207103758.065621350@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103757.232676988@linuxfoundation.org>
References: <20220207103757.232676988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

commit d9e410ebbed9d091b97bdf45b8a3792e2878dc48 upstream.

In RoCE we should use cma_iboe_set_mgid() and not cma_set_mgid to generate
the mgid, otherwise we will generate an IGMP for an incorrect address.

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Link: https://lore.kernel.org/r/913bc6783fd7a95fe71ad9454e01653ee6fb4a9a.1642491047.git.leonro@nvidia.com
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -68,8 +68,8 @@ static const char * const cma_events[] =
 	[RDMA_CM_EVENT_TIMEWAIT_EXIT]	 = "timewait exit",
 };
 
-static void cma_set_mgid(struct rdma_id_private *id_priv, struct sockaddr *addr,
-			 union ib_gid *mgid);
+static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
+			      enum ib_gid_type gid_type);
 
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 {
@@ -1840,17 +1840,19 @@ static void destroy_mc(struct rdma_id_pr
 		if (dev_addr->bound_dev_if)
 			ndev = dev_get_by_index(dev_addr->net,
 						dev_addr->bound_dev_if);
-		if (ndev) {
+		if (ndev && !send_only) {
+			enum ib_gid_type gid_type;
 			union ib_gid mgid;
 
-			cma_set_mgid(id_priv, (struct sockaddr *)&mc->addr,
-				     &mgid);
-
-			if (!send_only)
-				cma_igmp_send(ndev, &mgid, false);
-
-			dev_put(ndev);
+			gid_type = id_priv->cma_dev->default_gid_type
+					   [id_priv->id.port_num -
+					    rdma_start_port(
+						    id_priv->cma_dev->device)];
+			cma_iboe_set_mgid((struct sockaddr *)&mc->addr, &mgid,
+					  gid_type);
+			cma_igmp_send(ndev, &mgid, false);
 		}
+		dev_put(ndev);
 
 		cancel_work_sync(&mc->iboe_join.work);
 	}


