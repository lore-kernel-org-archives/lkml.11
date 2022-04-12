Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA400C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiDLHL5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352463AbiDLGzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:55:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D533B03D;
        Mon, 11 Apr 2022 23:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D97B8B818C8;
        Tue, 12 Apr 2022 06:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306BAC385A1;
        Tue, 12 Apr 2022 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649745936;
        bh=TLeEnw5MXAmhw41VEY9V9prUO9fx9ipbikHBk+GaswI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HC/vskWUf95utzV7LU2AgdN44h8uW1QY8ywaWo3ndkOOImpBm9J/QV2eSzpnZ44oX
         ulAQUeCao4vtphCo9lHRqqOSn+9rnciXYrKmsJwgLuwoaDulXEcRY2X4WnxT0N9a1u
         rbLFhiG0hP7cKKDY8e/0p9cXM+e0Gju3MuMFY4D8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Shuklin <george.shuklin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 094/277] net: account alternate interface name memory
Date:   Tue, 12 Apr 2022 08:28:17 +0200
Message-Id: <20220412062944.764241045@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 5d26cff5bdbebdf98ba48217c078ff102536f134 ]

George reports that altnames can eat up kernel memory.
We should charge that memory appropriately.

Reported-by: George Shuklin <george.shuklin@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 91d7a5a5a08d..a8c319dc224a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3637,7 +3637,7 @@ static int rtnl_alt_ifname(int cmd, struct net_device *dev, struct nlattr *attr,
 	if (err)
 		return err;
 
-	alt_ifname = nla_strdup(attr, GFP_KERNEL);
+	alt_ifname = nla_strdup(attr, GFP_KERNEL_ACCOUNT);
 	if (!alt_ifname)
 		return -ENOMEM;
 
-- 
2.35.1



