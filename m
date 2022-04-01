Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA9FC43217
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 15:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbiDAPWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348560AbiDAOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1072B4A7B;
        Fri,  1 Apr 2022 07:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23076B8240F;
        Fri,  1 Apr 2022 14:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7E8C34114;
        Fri,  1 Apr 2022 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824152;
        bh=0mpPexRFo7zhA3WSAo9XaOCpHuoEaH4M/JoyqcnhP8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6OGs81U6RVyrQpAhyhg2XH6EVbCESpjupuN3+jcF5DQ0iNvvycd+YjQROk3qzI01
         DzNpsIGFC66kuWTKfvnPRIOs4Z3N663jx//ka5qst1gy83fJdGL4zRFx29Di85s65H
         YLZFHjhzgnSVjUFCiok8FodFNldUeGDTiVaC4StEQTPkaLEK/k+ZPrl39qbk0Wh4ne
         D/HcE7EPVr+UgohMWc1vw7AoYH3wPnIDx1MRmRDtX2wmO9EDqc/VU9j+5Lpd7zdCRB
         XE5RHmzyP7DOmYF5gnWHO9PhBK3JjaTUx5GVrQxM4ZLGZWwNrjNyYigg2pKPp5qHel
         IO+iNrQTg/+SA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        David Yang <davidcomponentone@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 07/65] ptp: replace snprintf with sysfs_emit
Date:   Fri,  1 Apr 2022 10:41:08 -0400
Message-Id: <20220401144206.1953700-7-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144206.1953700-1-sashal@kernel.org>
References: <20220401144206.1953700-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

[ Upstream commit e2cf07654efb0fd7bbcb475c6f74be7b5755a8fd ]

coccinelle report:
./drivers/ptp/ptp_sysfs.c:17:8-16:
WARNING: use scnprintf or sprintf
./drivers/ptp/ptp_sysfs.c:390:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index be076a91e20e..8cd59e848163 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -13,7 +13,7 @@ static ssize_t clock_name_show(struct device *dev,
 			       struct device_attribute *attr, char *page)
 {
 	struct ptp_clock *ptp = dev_get_drvdata(dev);
-	return snprintf(page, PAGE_SIZE-1, "%s\n", ptp->info->name);
+	return sysfs_emit(page, "%s\n", ptp->info->name);
 }
 static DEVICE_ATTR_RO(clock_name);
 
@@ -227,7 +227,7 @@ static ssize_t ptp_pin_show(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&ptp->pincfg_mux);
 
-	return snprintf(page, PAGE_SIZE, "%u %u\n", func, chan);
+	return sysfs_emit(page, "%u %u\n", func, chan);
 }
 
 static ssize_t ptp_pin_store(struct device *dev, struct device_attribute *attr,
-- 
2.34.1

