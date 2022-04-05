Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56FC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiDEIH3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiDEHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:54:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D682201AE;
        Tue,  5 Apr 2022 00:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29E10B81B90;
        Tue,  5 Apr 2022 07:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB9C340EE;
        Tue,  5 Apr 2022 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144972;
        bh=71jH69m/OVCh7KFUK9MfkwZ2+Xg0lD2a0a291BdIGak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbEH5NENZyJhlTgl2XYHbFz3/9q/75aXCU/Efyd1QjKqjWdQHCMTYQsZI3mX3SygR
         dxIBdMb215badDMIdaMb1kWxMEVEH9lpAKeMWXqBdN7RrDfNZ4P/V+8jQWxQZWilCs
         wdupaFxNY7/r9fdOvOtEm+RKfzqZOVJkaWBY3Iqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0238/1126] PM: hibernate: fix __setup handler error handling
Date:   Tue,  5 Apr 2022 09:16:25 +0200
Message-Id: <20220405070414.593464228@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ba7ffcd4c4da374b0f64666354eeeda7d3827131 ]

If an invalid value is used in "resumedelay=<seconds>", it is
silently ignored. Add a warning message and then let the __setup
handler return 1 to indicate that the kernel command line option
has been handled.

Fixes: 317cf7e5e85e3 ("PM / hibernate: convert simple_strtoul to kstrtoul")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e6af502c2fd7..08780a466fdf 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1328,7 +1328,7 @@ static int __init resumedelay_setup(char *str)
 	int rc = kstrtouint(str, 0, &resume_delay);
 
 	if (rc)
-		return rc;
+		pr_warn("resumedelay: bad option string '%s'\n", str);
 	return 1;
 }
 
-- 
2.34.1



