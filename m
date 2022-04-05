Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027CC3527B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiDEJp1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiDEIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965174DEC;
        Tue,  5 Apr 2022 01:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0714609AD;
        Tue,  5 Apr 2022 08:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD53C385A0;
        Tue,  5 Apr 2022 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146177;
        bh=uUCyCdXvLdpZNjhvD5/H8FcoxNfveFCUJrqmtXQXbZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5MGGBIkBhXCnlbPV5158stJMvsKzzToS/cshRH7SQAI51ujE+BM4IojQt2DTsJbR
         +tnMTg4FlIB9UizH4pjfKJndY2wr02gRWwNZIyJtVRnJp2ksAq9Id5bJFWJYuQp+4V
         dc9wqp12X08LS2AGuDhDbMU05UgOM7SFxa7U6fw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0633/1126] IB/hfi1: Allow larger MTU without AIP
Date:   Tue,  5 Apr 2022 09:23:00 +0200
Message-Id: <20220405070426.217324246@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

[ Upstream commit b135e324d7a2e7fa0a7ef925076136e799b79f44 ]

The AIP code signals the phys_mtu in the following query_port()
fragment:

	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
				ib_mtu_enum_to_int(props->max_mtu);

Using the largest MTU possible should not depend on AIP.

Fix by unconditionally using the hfi1_max_mtu value.

Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
Link: https://lore.kernel.org/r/1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index dc9211f3a009..99d0743133ca 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1397,8 +1397,7 @@ static int query_port(struct rvt_dev_info *rdi, u32 port_num,
 				      4096 : hfi1_max_mtu), IB_MTU_4096);
 	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
 		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
-	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
-				ib_mtu_enum_to_int(props->max_mtu);
+	props->phys_mtu = hfi1_max_mtu;
 
 	return 0;
 }
-- 
2.34.1



