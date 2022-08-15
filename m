Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8EFC32764
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 19:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbiHOTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbiHOTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45683CBC9;
        Mon, 15 Aug 2022 11:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AAE60EEB;
        Mon, 15 Aug 2022 18:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22703C433C1;
        Mon, 15 Aug 2022 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660588758;
        bh=me+uVPTFhaXSsPHbDKu2J3u0dmD1ACILvwldhii9Rro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhE7xj1qrckUzp6/JtwZgYKh6SxpPZhx/Eh4phWtNg5c9fc8MOzVwuXjnJnvd5rrA
         RiJepeE0X6sZkievcn/wLxrZ0L2r0Hr0mjwULVgYSssGuJv3IFKaZeo1MKEYtEt9WG
         0ChAJqrEvnKM4kVSWlSO3T2qwHPSrUGOSt1pJGWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 506/779] RDMA/rtrs: Do not allow sessname to contain special symbols / and .
Date:   Mon, 15 Aug 2022 20:02:30 +0200
Message-Id: <20220815180358.892721182@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
References: <20220815180337.130757997@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@ionos.com>

[ Upstream commit dea7bb3ad3e08f96815330f88a62c24d7a9dacae ]

Allowing these characters in sessname can lead to unexpected results,
particularly because / is used as a separator between files in a path, and
. points to the current directory.

Link: https://lore.kernel.org/r/20210922125333.351454-7-haris.iqbal@ionos.com
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index a23438bacf12..be96701cf281 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2790,6 +2790,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 	struct rtrs_clt *clt;
 	int err, i;
 
+	if (strchr(sessname, '/') || strchr(sessname, '.')) {
+		pr_err("sessname cannot contain / and .\n");
+		err = -EINVAL;
+		goto out;
+	}
+
 	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
 			ops->link_ev,
 			reconnect_delay_sec,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 078a1cbac90c..7df71f8cf149 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_con *con,
 		return err;
 	}
 
+	if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.')) {
+		rtrs_err(s, "sessname cannot contain / and .\n");
+		return -EINVAL;
+	}
+
 	if (exist_sessname(sess->srv->ctx,
 			   msg->sessname, &sess->srv->paths_uuid)) {
 		rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname);
-- 
2.35.1



