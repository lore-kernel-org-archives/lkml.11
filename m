Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4539EC4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451351AbiDEW3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358779AbiDELRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253DDFD4F;
        Tue,  5 Apr 2022 03:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16D5E61676;
        Tue,  5 Apr 2022 10:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1BBC385A0;
        Tue,  5 Apr 2022 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153971;
        bh=unhPyUW8G+l7QGRP3i6xaRJRIbHDnFsEq/nRZi8DT8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zp0eYMJopxfUZNSO/JdsEX9HedS237kW97LvLJyt1nsONFxrXyMvTsy8nXQxfADa6
         GcfHVcIeWwMioguixP/Tzz7MxDZwLR/Bw2um+frgYwq2rC7AIoYkBl5i44RpdwkxGD
         VypTO9D/d/WrNHBx79b4v86bZvKYYq7fMKRMKkrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 406/599] remoteproc: qcom_wcnss: Add missing of_node_put() in wcnss_alloc_memory_region
Date:   Tue,  5 Apr 2022 09:31:40 +0200
Message-Id: <20220405070310.913272682@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 8f90161a66bc3d6b9fe8dde4d9028d20eae1b62a ]

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: aed361adca9f ("remoteproc: qcom: Introduce WCNSS peripheral image loader")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220308063102.10049-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_wcnss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index e2573f79a137..67286a4505cd 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -448,6 +448,7 @@ static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
 	}
 
 	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
 	if (ret)
 		return ret;
 
-- 
2.34.1



