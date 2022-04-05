Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC5C38161
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381629AbiDELql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbiDEIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694A23BEA;
        Tue,  5 Apr 2022 01:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8FD7CE1C6B;
        Tue,  5 Apr 2022 08:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0F4C385A1;
        Tue,  5 Apr 2022 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148312;
        bh=n42Mv9mJiqaTeh+zUQOoVQHUPM1+yP94/zgTbe6p7QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSYOisXnTq2CehsupUcKDWqc4STmpX0j3ejbRx4Z323bTReXLcmxUQX+qRBM8wgTX
         7qySGLXtBXrgjjUo8sMrSX0Oa1HkkSoozqu5yb4RhRoOE0LPddIPBRSrlEqtMFK76K
         wNgksXr/WUdPHG3Negj5ZO1Yxf6oozbvXLCQIfas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0312/1017] soc: qcom: rpmpd: Check for null return of devm_kcalloc
Date:   Tue,  5 Apr 2022 09:20:25 +0200
Message-Id: <20220405070403.538520758@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 5a811126d38f9767a20cc271b34db7c8efc5a46c ]

Because of the possible failure of the allocation, data->domains might
be NULL pointer and will cause the dereference of the NULL pointer
later.
Therefore, it might be better to check it and directly return -ENOMEM
without releasing data manually if fails, because the comment of the
devm_kmalloc() says "Memory allocated with this function is
automatically freed on driver detach.".

Fixes: bbe3a66c3f5a ("soc: qcom: rpmpd: Add a Power domain driver to model corners")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20211231094419.1941054-1-jiasheng@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmpd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 4f69fb9b2e0e..69b587822e39 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -570,6 +570,9 @@ static int rpmpd_probe(struct platform_device *pdev)
 
 	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
 				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
 	data->num_domains = num;
 
 	for (i = 0; i < num; i++) {
-- 
2.34.1



