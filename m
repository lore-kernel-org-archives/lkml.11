Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DC8C4708D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiDEIqb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiDEIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2186C1D9;
        Tue,  5 Apr 2022 01:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F606617DA;
        Tue,  5 Apr 2022 08:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA68C385A6;
        Tue,  5 Apr 2022 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145734;
        bh=G+tlzkSO4tf9ZQVjfwUjPYMxK5+NilPHHkn+It7OI2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vC6fAK027n6rzoJgQEDiBAkix6a9U4ARcWoEw9rwajiqPz1l0qG4Xf+ObUX5Mxu+T
         zQr4EhBYqDRsIqG/5zB+H8M2B2FeSdo1GwZk4QvDT27FzWzc15TgcArokAk69fniT3
         DbsCq3a2s/l7ytbuyOy/lsifvzshMsJnSMBVyddY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0472/1126] RDMA/core: Set MR type in ib_reg_user_mr
Date:   Tue,  5 Apr 2022 09:20:19 +0200
Message-Id: <20220405070421.481416891@linuxfoundation.org>
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

From: Maor Gottlieb <maorg@nvidia.com>

[ Upstream commit 32a88d16615c2be295571c29273c4ac94cb75309 ]

Add missing assignment of MR type to IB_MR_TYPE_USER.

Fixes: 33006bd4f37f ("IB/core: Introduce ib_reg_user_mr")
Link: https://lore.kernel.org/r/be2e91bcd6e52dc36be289ae92f30d3a5cc6dcb1.1642491047.git.leonro@nvidia.com
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c18634bec212..e821dc94a43e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2153,6 +2153,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return mr;
 
 	mr->device = pd->device;
+	mr->type = IB_MR_TYPE_USER;
 	mr->pd = pd;
 	mr->dm = NULL;
 	atomic_inc(&pd->usecnt);
-- 
2.34.1



