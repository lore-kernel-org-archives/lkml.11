Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B7BC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiHWJs6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352491AbiHWJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E092F6C;
        Tue, 23 Aug 2022 01:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44198614E7;
        Tue, 23 Aug 2022 08:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB55C433C1;
        Tue, 23 Aug 2022 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244246;
        bh=Nf3nLV0LGWbKIVOyxXvxMegNYIXmp73WYdm46kgRM34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmztlOc05d1Jupx+oDiRzf7L42Ju5oeuy6vuLilt/6GUt1GBX3ZUpgbeCkS5mv0kv
         J5NHafcCeqZPJ0lGIBRkB6b+BhyOH+AbzjndhoGa6/GzU13V5xU9TpUj0wBkD1d1nk
         u9Jb2axwdP6ZBIADEWQjJEQmH8fC840ypmxguSUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianglei Nie <niejianglei2021@163.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 108/229] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Date:   Tue, 23 Aug 2022 10:24:29 +0200
Message-Id: <20220823080057.538391777@linuxfoundation.org>
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

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit aa2a1df3a2c85f855af7d54466ac10bd48645d63 ]

setup_base_ctxt() allocates a memory chunk for uctxt->groups with
hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
is not released, which will lead to a memory leak.

We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
when init_user_ctxt() fails.

Fixes: e87473bc1b6c ("IB/hfi1: Only set fd pointer when base context is completely initialized")
Link: https://lore.kernel.org/r/20220711070718.2318320-1-niejianglei2021@163.com
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 7b8644610feb..d586bd6ddf22 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1327,8 +1327,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
 		goto done;
 
 	ret = init_user_ctxt(fd, uctxt);
-	if (ret)
+	if (ret) {
+		hfi1_free_ctxt_rcv_groups(uctxt);
 		goto done;
+	}
 
 	user_init(uctxt);
 
-- 
2.35.1



