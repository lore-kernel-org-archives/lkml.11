Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD5BC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351312AbiHWLi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358013AbiHWLcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B144E614;
        Tue, 23 Aug 2022 02:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3736F61227;
        Tue, 23 Aug 2022 09:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15552C433B5;
        Tue, 23 Aug 2022 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661246789;
        bh=Md5RQ6iHQPX4e7LRHADrQoCMdtevRuFoWjv4ghAxn0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9zJ85aknlucM0VTIPEVz/++PcKJg3XppMqREVZOZ7wm5WBEneWMO1+xNqHSdOh87
         BPby9tGXiwFtFf3NbC19MPtetUG63VrnJedigcxrrWCAIxI/LUcQlDI4aOIElieu39
         ROZPTlsBkzfPAszBpz5iXhQ4NXFILrBVEwfhAolc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 220/389] rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge
Date:   Tue, 23 Aug 2022 10:24:58 +0200
Message-Id: <20220823080124.774737556@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 65382585f067d4256ba087934f30f85c9b6984de ]

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.

Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220511120737.57374-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/qcom_smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index a4db9f6100d2..0b1e853d8c91 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1364,6 +1364,7 @@ static int qcom_smd_parse_edge(struct device *dev,
 		}
 
 		edge->ipc_regmap = syscon_node_to_regmap(syscon_np);
+		of_node_put(syscon_np);
 		if (IS_ERR(edge->ipc_regmap)) {
 			ret = PTR_ERR(edge->ipc_regmap);
 			goto put_node;
-- 
2.35.1



