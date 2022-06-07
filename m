Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78324C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376629AbiFGVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376618AbiFGUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:16:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09681CF16A;
        Tue,  7 Jun 2022 11:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04294B82381;
        Tue,  7 Jun 2022 18:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A902C385A2;
        Tue,  7 Jun 2022 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654626573;
        bh=oTUD0gfXlCXXBTlNhj7YdtZdcBIDAMIgu5/THuULMSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae7TWTrSsGWDYgX+ESGpjGsYJeuKxExGV5FsWyWldpm8BhA00b6ZqxbWMwk4K1KEw
         AhJY5+0SVEWQ5AI5rwEwE74BTkRsaG+bHwvijFec3E9fXAocprUeE5buBv35H2jN9P
         ZdhdCws0CjOqHIsGqrbvcvG2byyQ/5S6fGcWog/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 425/772] PM: domains: Fix initialization of genpds next_wakeup
Date:   Tue,  7 Jun 2022 19:00:17 +0200
Message-Id: <20220607165001.527041472@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 622d9b5577f19a6472db21df042fea8f5fefe244 ]

In the genpd governor we walk the list of child-domains to take into
account their next_wakeup. If the child-domain itself, doesn't have a
governor assigned to it, we can end up using the next_wakeup value before
it has been properly initialized. To prevent a possible incorrect behaviour
in the governor, let's initialize next_wakeup to KTIME_MAX.

Fixes: c79aa080fb0f ("PM: domains: use device's next wakeup to determine domain idle state")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7e8039d1884c..0f2e42f36851 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1978,6 +1978,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
+	genpd->next_wakeup = KTIME_MAX;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get();
-- 
2.35.1



