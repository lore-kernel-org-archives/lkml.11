Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C558C4167B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383797AbiDEVqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357964AbiDEK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0BC5580;
        Tue,  5 Apr 2022 03:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A536179E;
        Tue,  5 Apr 2022 10:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80E3C385A1;
        Tue,  5 Apr 2022 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153504;
        bh=+tmigAPgxOUXyG8vpQNW9jGjOLFsVPcicykoJQBLNEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDySaSklepmCmz+IAQq3fbIIhcA6PTVjViPgszJ84Ygz1ryrdIZqU5dkC2ljIL4AC
         tErCwK9K9VYmv7NShSQMz+50aWI2i85O1YNKsdT96uTdvCmqmk1OH4B77AiG5jTTFN
         pEjNKxK2tUNDLzJ2xUJzhmElpowuabnusR/BhD+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 206/599] soc: qcom: ocmem: Fix missing put_device() call in of_get_ocmem
Date:   Tue,  5 Apr 2022 09:28:20 +0200
Message-Id: <20220405070304.971991708@linuxfoundation.org>
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

[ Upstream commit 0ff027027e05a866491bbb53494f0e2a61354c85 ]

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: 01f937ffc468 ("soc: qcom: ocmem: don't return NULL in of_get_ocmem")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220107073126.2335-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/ocmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index f1875dc31ae2..85f82e195ef8 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -206,6 +206,7 @@ struct ocmem *of_get_ocmem(struct device *dev)
 	ocmem = platform_get_drvdata(pdev);
 	if (!ocmem) {
 		dev_err(dev, "Cannot get ocmem\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENODEV);
 	}
 	return ocmem;
-- 
2.34.1



