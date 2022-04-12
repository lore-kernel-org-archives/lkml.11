Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E81C352A7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359551AbiDLHnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354010AbiDLHQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:16:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875342EC5;
        Mon, 11 Apr 2022 23:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E3DB81B4E;
        Tue, 12 Apr 2022 06:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90EDC385AC;
        Tue, 12 Apr 2022 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746677;
        bh=L4AE/btcFbCZktUVXKI6UoJsesrXhv9p0ciRMSDqhhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnzJ145MzihDEQznjCWqfpoAeW0Wkrb674O1lqlihWtMljpffqBpbqRGBfjNUb+As
         zkartndQD78TZe1xMkvxnUtx8SK3mMYj3mLWo47D4WC+Ojd+6ffRDS5zU9tNpTLQYJ
         4LX/0jpKmACamL7sfKgmVBavbvvBvPs5sGfr6d9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 091/285] powerpc/secvar: fix refcount leak in format_show()
Date:   Tue, 12 Apr 2022 08:29:08 +0200
Message-Id: <20220412062946.289292208@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit d601fd24e6964967f115f036a840f4f28488f63f ]

Refcount leak will happen when format_show returns failure in multiple
cases. Unified management of of_node_put can fix this problem.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220302021959.10959-1-hbh25y@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/secvar-sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index a0a78aba2083..1ee4640a2641 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -26,15 +26,18 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 	const char *format;
 
 	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
-	if (!of_device_is_available(node))
-		return -ENODEV;
+	if (!of_device_is_available(node)) {
+		rc = -ENODEV;
+		goto out;
+	}
 
 	rc = of_property_read_string(node, "format", &format);
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = sprintf(buf, "%s\n", format);
 
+out:
 	of_node_put(node);
 
 	return rc;
-- 
2.35.1



