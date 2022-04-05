Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB85AC4167E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbiDEJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbiDEIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3742136;
        Tue,  5 Apr 2022 01:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 609E7609D0;
        Tue,  5 Apr 2022 08:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F80DC385A1;
        Tue,  5 Apr 2022 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146626;
        bh=P3NtWkh9h3XTIlElB6Qko8BGssaTAw2AjqJ3aVe94Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ub+8ZWECkYc9Zzr7slZmwZqMFcrCBY9/z4GmdkrPronVwyhfc9R7ez784I2UpJVV3
         qWNVnUW+XmhYtRpoD06V6CwHWn57a8xW6zGbIsd6PWnDXptRBMYER132c9g1krAVJY
         dkuFXa1G0m1JeMPDSLUm/hMPNz3okl4ZPq4KtdEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0831/1126] lib/test: use after free in register_test_dev_kmod()
Date:   Tue,  5 Apr 2022 09:26:18 +0200
Message-Id: <20220405070431.950973665@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit dc0ce6cc4b133f5f2beb8b47dacae13a7d283c2c ]

The "test_dev" pointer is freed but then returned to the caller.

Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_kmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index ce1589391413..cb800b1d0d99 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1149,6 +1149,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
 	if (ret) {
 		pr_err("could not register misc device: %d\n", ret);
 		free_test_dev_kmod(test_dev);
+		test_dev = NULL;
 		goto out;
 	}
 
-- 
2.34.1



