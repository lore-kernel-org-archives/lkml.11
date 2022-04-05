Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C6C4167E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiDEIOf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiDEH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF115675D;
        Tue,  5 Apr 2022 00:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E212B81B9C;
        Tue,  5 Apr 2022 07:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF35C340EE;
        Tue,  5 Apr 2022 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145225;
        bh=phuxJo7oRmldSO2cwujmdOqMdhQCoMAdhkZWFNfJytE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJaHsze0YeKMAuHOjWBrvKUlHWs6b1pkDthI8+hLwEHlILC3/iGubhPE1uNLQTKAb
         RdD4ZwEBRp4GOyRYd3L8YW8Z9JcGK11K95UHzo8DwHhWli0Z/0ZPVVHGM4TjkV4OrV
         wxGi6PbtUWQjqxtAX7S9cqYPyO3KElglVHwhwxPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0329/1126] soc: qcom: aoss: Fix missing put_device call in qmp_get
Date:   Tue,  5 Apr 2022 09:17:56 +0200
Message-Id: <20220405070417.275513555@linuxfoundation.org>
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

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 4b41a9d0fe3db5f91078a380f62f0572c3ecf2dd ]

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: 8c75d585b931 ("soc: qcom: aoss: Expose send for generic usecase")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220108095931.21527-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/qcom_aoss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index cbe5e39fdaeb..563ae0a501dc 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -451,7 +451,11 @@ struct qmp *qmp_get(struct device *dev)
 
 	qmp = platform_get_drvdata(pdev);
 
-	return qmp ? qmp : ERR_PTR(-EPROBE_DEFER);
+	if (!qmp) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+	return qmp;
 }
 EXPORT_SYMBOL(qmp_get);
 
-- 
2.34.1



